let global = require("./global");
let db = null;
let admin = null;

module.exports = {
    initialize: initialize,
    addDog: addDog,
    editDog: editDog,
    removeDog: removeDog
};

function initialize(_admin, _db) {
    admin = _admin;
    db = _db;
}

// ---------------- Main methods ----------------
// This method handles the creation of a Dog.
// params: {
//      name: String,
//      years: Number,
//      breed: String
// }
// returns id or error
async function addDog(data, context) {
    if (context.auth.uid === null || context.auth.uid === undefined) {
        return global.formatError(global.ERRORS.AUTH);
    }
    if (typeof data.name !== 'string' ||
        typeof data.years !== "number" ||
        data.years <= 0 ||
        !BREEDS.includes(data.breed))
        return global.formatError(global.ERRORS.ARGS);

    let timestamp = Date.now() - global.toMillis(data.years, typeof data.months === 'number' ? data.months : 0);

    let dogReference = db.collection(global.COLLECTIONS.USERS).doc(context.auth.uid).collection(global.COLLECTIONS.DOGS);
    let dogQuery = dogReference.where('name', '==', data.name).limit(1);
    try {
        return await db.runTransaction(async transaction => {
            let doc = await transaction.get(dogQuery);
            if (doc.exists) {
                return global.formatError(global.ERRORS.DOG_ALREADY_EXISTS);
            }

            let dog = {
                birthday: timestamp,
                breed: data.breed,
                name: data.name,
                rating_avg: 0,
                ratings: []
            };
        
            let result = await transaction.set(dogReference.doc(), dog);
            return global.formatData({
                id: result.id
            });
        });
    } catch (e) {
        console.error(e);
        return global.formatError(ERRORS.UNKNOWN);
    }
}

// This method handles the modification of a Dog.
// params: {
//      id: String (documentId),
//      name: String (newName),
//      years: Number (newBirthdate)
// }
// returns {
//      result: true
// } or error
async function editDog(data, context) {
    if (context.auth.uid === null || context.auth.uid === undefined) {
        return global.formatError(global.ERRORS.AUTH);
    }
    if (data.id !== "string" || (typeof data.years === "number" && data.years <= 0))
        return global.formatError(global.ERRORS.ARGS);

    let dogReference = db.collection(global.COLLECTIONS.USERS).doc(context.auth.uid).collection(global.COLLECTIONS.DOGS).doc(data.id);
    try {
        return await db.runTransaction(async transaction => {
            let doc = await transaction.get(dogReference);
            if (!doc.exists) {
                return global.formatError(global.ERRORS.DOG_ALREADY_EXISTS);
            }

            let dog = {};
            let docData = doc.data();

            if (typeof data.name === "string" && data.name !== docData.name) {
                let dogQuery = db.collection(global.COLLECTIONS.USERS).doc(context.auth.uid).collection(global.COLLECTIONS.DOGS).where('name', '==', data.name).limit(1);
                let doc = await transaction.get(dogQuery);
                if (doc.exists) {
                    return global.formatError(global.ERRORS.DOG_ALREADY_EXISTS);
                }
            }
            if (typeof data.years === "number")
                dog.birthday = Date.now() - global.toMillis(data.years, typeof data.months === 'number' ? data.months : 0);
        
            if (Object.keys(dog) > 0)
                await dogReference.update(dog);
            return global.formatData({
                result: true
            });
        });
    } catch (e) {
        console.error(e);
        return global.formatError(ERRORS.UNKNOWN);
    }
}

// This method handles the removal of a Dog.
// params: {
//      id: String
// }
// returns {
//      result: true
// } or error
async function removeDog(data, context) {
    if (context.auth.uid === null || context.auth.uid === undefined) {
        return global.formatError(global.ERRORS.AUTH);
    }
    if (typeof data.id !== 'string') {
        return global.formatError(global.ERRORS.ARGS);
    }

    try {
        await db.collection(global.COLLECTIONS.USERS).doc(context.auth.uid).collection(global.COLLECTIONS.DOGS).doc(data.id).delete();
        return global.formatData({result: true});
    } catch (e) {
        console.error(e);
        return global.formatError(global.ERRORS.UNKNOWN);
    }
}
