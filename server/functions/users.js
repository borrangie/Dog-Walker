let global = require("./global");
let db = null;
let admin = null;

let DOG_OWNER = 0;
let DOG_WALKER = 1;

module.exports = {
    initialize: initialize,
    onUserCreate: onUserCreate,
    setUpAccount: setUpAccount,
    setAccountType: setAccountType,
    setPhoneNumber: setPhoneNumber
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
        birthday: null,
        mail: user.email,
        rating_avg: 0,
        ratings: [],
        walks: 0
    });

    let customClaims = {
        admin: false,
        walker: false,
        owner: false,
        verified: false,
        walker_verified: false
    };

    await admin
        .auth()
        .setCustomUserClaims(user.uid, customClaims);
}

async function setUpAccount(data, context) {
    if (context.auth.uid === null || context.auth.uid === undefined) {
        return global.formatError(global.ERRORS.AUTH);
    }

    let safeData = {};
    let type = data.type;
    data = data.data;
    if (type !== DOG_OWNER && type !== DOG_WALKER) {
        return global.formatError(global.ERRORS.UNSUPPORTED_USER_TYPE);
    }
    if (type === DOG_OWNER || type === DOG_WALKER) {
        if (data["name"] == null || data["surname"] == null || data["phone"] == null) {
            return global.formatError(global.ERRORS.ARGS);
        }

        safeData["name"] = data["name"];
        safeData["surname"] = data["surname"];
        safeData["phone"] = data["phone"];
    } 
    if (type === DOG_WALKER) {
        if (data["dni"] == null || data["birthday"] == null) {
            return global.formatError(global.ERRORS.ARGS);
        }

        safeData["dni"] = data["dni"];
        safeData["birthday"] = data["birthday"];
    }

    user = await admin.auth().getUser(context.auth.uid);
    if ((type === DOG_OWNER && user.customClaims.verified) || (type === DOG_WALKER && user.customClaims.walker_verified)) {
        return global.formatError(global.ERRORS.USER_ALREADY_VERIFIED);
    }

    if (!await setAccountTypeUser(user, type)) {
        return global.formatError(global.ERRORS.SET_UP_USER_TYPE);
    }

    try {
        await db.collection(global.COLLECTIONS.USERS).doc(context.auth.uid).set(safeData, {merge: true});
        user.customClaims.walker_verified = type === DOG_WALKER;
        user.customClaims.verified = true;
        
        await admin
        .auth()
        .setCustomUserClaims(context.auth.uid, user.customClaims);
        return global.formatData({
            result: true
        });
    } catch (e) {
        return global.formatError(emessage);
    }
}

async function setAccountType(data, context) {
    if (context.auth.uid === null || context.auth.uid === undefined) {
        return global.formatError(global.ERRORS.AUTH);
    }

    user = await admin.auth().getUser(context.auth.uid);
    return global.formatData({
        result: await setAccountTypeUser(user, data.type)
    });
}

async function setPhoneNumber(data, context) {
    if (context.auth.uid === null || context.auth.uid === undefined) {
        return global.formatError(global.ERRORS.AUTH);
    }

    try {
        await db.collection(global.COLLECTIONS.USERS).doc(context.auth.uid).set({
            "phone": data.phone
        }, {merge: true});
        return global.formatData({
            result: true
        });
    } catch (e) {
        return global.formatError(e.message);
    }
}

async function setAccountTypeUser(user, type) {
    if (type === DOG_WALKER) {
        if (!user.customClaims.walker) {
            user.customClaims.walker = true;
            user.customClaims.owner = true;
            user.customClaims.walker_verified = false;
        }
    } else if (type === DOG_OWNER) {
        if (!user.customClaims.owner) {
            user.customClaims.owner = true;
            user.customClaims.verified = false;
        }
    } else {
        return false;
    }

    await admin
    .auth()
    .setCustomUserClaims(user.uid, user.customClaims);
    return true;
}
