import firebase from 'firebase'
import validator from 'validator'

let USER_TYPE = {
    SUPER_ADMIN: 'superadmin',
    ADMIN: 'admin',
    CLIENT: 'client'
}

let ERRORS = {
    INSUFFICIENT_PRIVILEGES: new Error('Insufficient privileges'),
    INVALID_USER_TYPE: new Error('Invalid user type or not specified'),
    USER_NOT_AUTHENTICATED: new Error('User not authenticated'),
    RESOURCE_DOESNT_EXIST: new Error('The resource you are trying to access doesn\'t exist')
}

let COLLECTIONS = {
    HOSPITALS: 'hospitals',
    DOCTORS: 'doctors'
}

export default {
    init: init,

    onAuthStateChanged: onAuthStateChanged,
    prepareGoogleSignIn: prepareGoogleSignIn,
    signInWithEmailAndPassword: signInWithEmailAndPassword,
    createUserWithEmailAndPassword: createUserWithEmailAndPassword,
    signOut: signOut,

    getUserType: getUserType,
    createHospital: createHospital,
    createDoctor: createDoctor,
    registerDoctor: registerDoctor

    USER_TYPE: USER_TYPE,
    ERRORS: ERRORS
}

let config = {
    apiKey: "AIzaSyA6QM4BKDHqCo4BaLMVzaw9tNsniWjcohs",
    authDomain: "hospoint-itba.firebaseapp.com",
    databaseURL: "https://hospoint-itba.firebaseio.com",
    projectId: "hospoint-itba",
    storageBucket: "hospoint-itba.appspot.com",
    messagingSenderId: "937460384289",
    appId: "1:937460384289:web:73a568a6d029ea91"
}

var database = null

// Must be called before using any other method.
function init() {
    firebase.initializeApp(config)
    database = firebase.firestore()
}


// -------- Auth --------

// Observer must be a function receiving a user. If user != null then it is signed in.
// Returns the function that de-registers it
function onAuthStateChanged(observer) {
    return firebase.auth().onAuthStateChanged(observer)
}

// Returns a promise
function signInWithEmailAndPassword(email, password) {
    return firebase.auth().signInWithEmailAndPassword(email, password)
}

// Returns a promise
function createUserWithEmailAndPassword(email, password) {
    return new Promise(function (resolve, reject) {
        firebase.auth().createUserWithEmailAndPassword(email, password).then(function () {
            sendEmailVerification().then(resolve).catch(reject)
        }).catch(reject)
    })
}

// Returns a promise
function prepareGoogleSignIn() {
    let provider = new firebase.auth.GoogleAuthProvider()
    return firebase.auth().signInWithPopup(provider)
}

// Returns a promise.
// Automatically called after a successful createUserWithEmailAndPassword
// Token should be refreshed after completed verification.
function sendEmailVerification() {
    return new Promise(function (resolve, reject) {
        if (firebase.auth().currentUser != null) {
            firebase.auth().currentUser.sendEmailVerification().then(resolve).catch(reject)
        } else {
            reject(ERRORS.USER_NOT_AUTHENTICATED)
        }
    })
}

// Returns a promise
function signOut() {
    return firebase.auth().signOut()
}

// Return a promise (async). Resolves to:
//      USER_TYPE.SUPER_ADMIN if user is superadmin (can manage hospitals) or
//      USER_TYPE.ADMIN if user can manage a particular hospital or
//      USER_TYPE.CLIENT if user is a patient.
// Throws ERRORS.INVALID_USER_TYPE if user type is invalid or not specified
async function getUserType() {
    let idTokenResult = await firebase.auth().currentUser.getIdTokenResult(true)
    if (idTokenResult.claims.userType === 'superadmin') {
        return USER_TYPE.SUPER_ADMIN
    } else if (idTokenResult.claims.userType === 'admin') {
        return USER_TYPE.ADMIN
    } else if (idTokenResult.claims.userType === 'client') {
        return USER_TYPE.CLIENT
    } else {
        throw ERRORS.INVALID_USER_TYPE
    }
}


// -------- Hospital --------

// Creates a hospital with basic inforamtion
// Returns a promise
async function createHospital(name, address, phones) {
    let userType = await getUserType();
    if (userType !== USER_TYPE.SUPER_ADMIN)
        throw ERRORS.INSUFFICIENT_PRIVILEGES

    if (!validator.validateString(name, validator.LOCALE.ARGENTINA)) {
        throw new Error('"name" must be a (non empty) string')
    }
    if (!validator.validateString(address, validator.LOCALE.ARGENTINA)) {
        throw new Error('"address" must be a (non empty) string')
    }
    if (!validator.validateArray(phones, validator.LOCALE.ARGENTINA, validator.validatePhoneNumber)) {
        throw new Error('"phones" must be a (non empty) array, and every phone number must be a valid string')
    }

    let hospital = {
        name: name,
        address: address,
        phones: phones
    }

    return database.collection(COLLECTIONS.HOSPITALS).add(hospital)
}

// Creates a doctor. MUST have a unique set of Country and License number.
// Returns a promise
async function createDoctor(name, phones, country, license) {
    let userType = await getUserType();
    if (userType !== USER_TYPE.SUPER_ADMIN || userType !== USER_TYPE.ADMIN)
        throw ERRORS.INSUFFICIENT_PRIVILEGES

    if (!validator.validateString(name, validator.LOCALE.ARGENTINA)) {
        throw new Error('"name" must be a (non empty) string')
    }
    if (!validator.validateString(country, validator.LOCALE.ARGENTINA)) {
        throw new Error('"country" must be a (non empty) string')
    }
    if (!validator.validateString(license, validator.LOCALE.ARGENTINA)) {
        throw new Error('"license" must be a (non empty) string')
    }
    if (!validator.validateArray(phones, validator.LOCALE.ARGENTINA, validator.validatePhoneNumber)) {
        throw new Error('"phones" must be a (non empty) array, and every phone number must be a valid string')
    }

    let doctor = {
        name: name,
        country: country,
        phones: phones,
        license: license
    }

    // We need to check for uniqueness. This MUST be done inside a transaction
    // to ensure we don't encounter a race condition
    let id = license + '_' + country
    let docRef = database.collection(COLLECTIONS.DOCTORS).doc(id)

    return database.runTransaction(async transaction => {
        let doc = await transaction.get(docRef)
        // Already created
        if (doc.exists)
            return id

        transaction.set(docRef, doctor)
    })
}

// Associates a doctor with a hospital.
// Returns a promise
async function registerDoctor(doctorsId, hospitalId) {
    let userType = await getUserType();
    if (userType !== USER_TYPE.SUPER_ADMIN || userType !== USER_TYPE.ADMIN)
        throw ERRORS.INSUFFICIENT_PRIVILEGES

    if (!validator.validateString(hospitalId, validator.LOCALE.ARGENTINA)) {
        throw new Error('"name" must be a (non empty) string')
    }
    if (!validator.validateArray(doctorsId, validator.LOCALE.ARGENTINA, validator.validateString)) {
        throw new Error('"doctorsId" must be a (non empty) array, and every doctorId must be a valid string')
    }

    // We need to make sure the doctor(s) aren't already associated. This MUST be done inside a transaction
    // to ensure we don't encounter a race condition
    let docRef = database.collection(COLLECTIONS.HOSPITALS).doc(hospitalId)
    return database.runTransaction(async transaction => {
        let doc = await transaction.get(docRef)
        // Already created
        if (!doc.exists)
            throw ERRORS.RESOURCE_DOESNT_EXIST

        let doctors = []
        let data = doc.data()
        if ('doctors' in data) {
            for (let doctor of data.doctors) {
                doctors.push(doctor)

                // Use getId as 'doctor' is of type DocumentReference
                let savedDoctorIdIndex = doctorsId.indexOf(doctor.getId())
                if (savedDoctorIdIndex !== -1) {
                    doctorsId = doctorsId.slice(savedDoctorIdIndex, 1)
                }
            }
        }

        var save = false;
        for (let doctorId of doctorsId) {
            // We need to save the DocumentReference, not the ID
            doctors.push(database.collection(COLLECTIONS.DOCTORS).doc(doctorId))
            if (!save)
                save = true
        }

        if (save)
            transaction.set(docRef, {doctors: doctors})
    })
}
