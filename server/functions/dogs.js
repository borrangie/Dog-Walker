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
// This method handles the creation of a Dog.
async function addDog(data, context) {
    if (context.auth.uid === null || context.auth.uid === undefined) {
        return global.formatError(global.ERRORS.AUTH);
    }
    if (typeof data.name !== 'string' ||
        typeof data.years !== "number" ||
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
        
            let result = await dogReference.add(dog);

            return global.formatData({
                id: result.id
            });
        });
    } catch (e) {
        console.error(e);
        return global.formatError(ERRORS.UNKNOWN);
    }
}

// This method handles the removal of a Dog.
// n represents its name
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
