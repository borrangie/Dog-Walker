let global = require("./global");
let db = null;
let admin = null;

module.exports = {
    initialize: initialize,
    onUserCreate: onUserCreate
};

function initialize(_admin, _db) {
    admin = _admin;
    db = _db;
}

// ---------------- Main methods ----------------
// Whenever a new user is created, we need to add him/her to the Users collection
// and setup basic data
async function onUserCreate(user) {
    let usersReference = db.collection(global.COLLECTIONS.USERS);

    await usersReference.doc(user.uid).create({
        dni: "",
        name: "",
        surname: "",
        phone: "",
        address: null,
        birthday: null,
        mail: user.mail,
        rating_avg: 0,
        ratings: [],
        walks: 0
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
}
