let functions = require("firebase-functions");
let admin = require("firebase-admin");
let users = require("./users");
let dogs = require("./dogs");

admin.initializeApp();
let db = admin.firestore();
users.initialize(admin, db);
dogs.initialize(admin, db);

// ---------------- Main methods ----------------
// Whenever a new user is created, we need to add him/her to the Users collection
// and setup basic data
exports.onUserCreate = functions.auth.user().onCreate(users.onUserCreate);

// Handle the initial account setup
exports.setUpAccount = functions.https.onCall(users.setUpAccount);

// Set account as DogWalker
exports.setDogWalker = functions.https.onCall(users.setDogWalker);

// Set account's phone number
exports.setPhoneNumber = functions.https.onCall(users.setPhoneNumber);

// This method handles the creation of a Dog.
exports.addDog = functions.https.onCall(dogs.addDog);

// This method handles the modification of a Dog.
exports.editDog = functions.https.onCall(dogs.editDog);

// This method handles the removal of a Dog.
exports.removeDog = functions.https.onCall(dogs.removeDog);
