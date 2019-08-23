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
    USER_NOT_AUTHENTICATED: new Error('User not authenticated')
}

let COLLECTIONS = {
    HOSPITALS: 'hospitals',

}

export default {
    init: init,

    onAuthStateChanged: onAuthStateChanged,
    prepareGoogleSignIn: prepareGoogleSignIn,
    signInWithEmailAndPassword: signInWithEmailAndPassword,
    createUserWithEmailAndPassword: createUserWithEmailAndPassword,
    signOut: signOut,

    getUserType: getUserType,

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
        'name': name,
        'address': address,
        'phones': phones
    }

    return database.collection(COLLECTIONS.HOSPITALS).add(hospital)
}
