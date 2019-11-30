let global = require("./global");
let db = null;
let admin = null;

let DOG_WALKER = 1;

module.exports = {
    initialize: initialize,
    onUserCreate: onUserCreate,
    setAccountType: setAccountType
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

async function setAccountType(userId, type) {
    user = await admin.getUser(userId);

    if (type === DOG_WALKER) {
        if (!user.customClaims.walker) {
            user.customClaims.walker = true;
            user.customClaims.walker_verified = false;

            await admin
                .auth()
                .setCustomUserClaims(userId, customClaims);
        }
    }
}
