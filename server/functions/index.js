let functions = require("firebase-functions");
let admin = require("firebase-admin");

admin.initializeApp();
let db = admin.firestore();

let COLLECTIONS = {
    USERS: 'u'
};
let ERRORS = {
    AUTH: "This function is only available to authenticated users",
    ARGS: "Invalid arguments. May be of the wrong type or unspecified",
    UNKNOWN: "Unknown error. Please, try again later",
    DOC_NOT_FOUND: "Document not found in DB",
    DOG_ALREADY_EXISTS: "Dog already exists",
    USER_IS_ACTIVE: "This action cannot be performed when a transaction is in place"
};
let BREEDS = ['doberman'];

// ---------------- Methods that handle return values ----------------
// Returns an Object with keys error and message if an error was produced, or error and data.
// Error is a boolean representing if an error has occurred.
function formatResult(data, error) {
    if (error !== null) {
        return {
            error: true,
            message: error
        }
    } else {
        return {
            error: false,
            data: data
        }
    }
}

// Shortcut to return an Object after an error was produced
function formatError(error) {
    return formatResult(null, error);
}

// Shortcut to return an Object after a successful operation
function formatData(data) {
    return formatResult(data, null);
}

// ---------------- Helper methods ----------------
function toMillis(y, m) {
    return y * 31556952000 + m * 2592000000;
}

// ---------------- Main methods ----------------
// Whenever a new user is created, we need to add him/her to the Users collection
// and setup basic data
exports.onUserCreate = functions.auth.user().onCreate(async (user) => {
    let usersReference = db.collection(COLLECTIONS.USERS);

    // i = dni (only for dog walkers), n = name, s = surname, p = phones, d = dogs, ad = active dogs, a = active, c = cost
    await usersReference.doc(user.uid).create({
        i: "",
        n: "",
        s: "",
        p: [],
        d: {},
        ad: {},
        a: false,
        c: -1
    });

    let customClaims = {
        admin: false,
        walker: false,
        verified: false,
        walker_verified: false
    };

    await admin
        .auth()
        .setCustomUserClaims(user.uid, customClaims);
});

// This method handles the creation of a Dog.
// n represents its name, y the amount of years old it is, m (nullable) the amount of months old it is, r the dogs' breed
exports.addDog = functions.https.onCall(async (data, context) => {
    if (context.auth.uid === null || context.auth.uid === undefined) {
        return formatError(ERRORS.AUTH);
    }
    if (typeof data.n !== 'string' ||
        typeof data.y !== "number" ||
        typeof data.r !== "string" ||
        !BREEDS.includes(data.r))
        return formatError(ERRORS.ARGS);

    let timestamp = Date.now() - toMillis(data.y, typeof data.m === 'number' ? data.m : 0);

    let dog = {
        t: timestamp,
        r: data.r
    };

    let userReference = db.collection(COLLECTIONS.USERS).doc(context.auth.uid);
    try {
        return await db.runTransaction(async transaction => {
            let doc = await transaction.get(userReference);
            if (!doc.exists) {
                return formatError(ERRORS.DOC_NOT_FOUND);
            }
            if (data.n in doc.data().d) {
                return formatError(ERRORS.DOG_ALREADY_EXISTS);
            }

            await userReference.update({
                ['d.' + data.n]: dog
            });

            return formatData({});
        });
    } catch (e) {
        console.error(e);
        return formatError(ERRORS.UNKNOWN);
    }
});

// This method handles the removal of a Dog.
// n represents its name
exports.removeDog = functions.https.onCall(async (data, context) => {
    if (context.auth.uid === null || context.auth.uid === undefined) {
        return formatError(ERRORS.AUTH);
    }
    if (typeof data.n !== 'string') {
        return formatError(ERRORS.ARGS);
    }

    let userReference = db.collection(COLLECTIONS.USERS).doc(context.auth.uid);
    try {
        return await db.runTransaction(async transaction => {
            let doc = await transaction.get(userReference);
            if (!doc.exists) {
                return formatError(ERRORS.DOC_NOT_FOUND);
            }
            if (doc.data().a === true) {
                return formatError(ERRORS.USER_IS_ACTIVE);
            }

            await userReference.update({
                ['d.' + data.n]: db.FieldValue.delete()
            });

            return formatData({});
        });
    } catch (e) {
        console.error(e);
        return formatError(ERRORS.UNKNOWN);
    }
});
