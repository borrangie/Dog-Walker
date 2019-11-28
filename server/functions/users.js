let global = require("./global");
let db = null;
let admin = null;

export default {
    initialize: initialize,
    addDog: addDog,
    removeDog: removeDog
};

function initialize(_admin, _db) {
    admin = _admin;
    db = _db;
}

// ---------------- Main methods ----------------
// Whenever a new user is created, we need to add him/her to the Users collection
// and setup basic data
exports.onUserCreate = functions.auth.user().onCreate(async (user) => {
    let usersReference = db.collection(global.COLLECTIONS.USERS);

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
