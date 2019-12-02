module.exports = {
    COLLECTIONS: {
        USERS: 'Users',
        DOGS: 'Dogs',
        WALKS: 'Walks'
    },
    ERRORS: {
        AUTH: "This function is only available to authenticated users",
        ARGS: "Invalid arguments. May be of the wrong type or unspecified",
        UNKNOWN: "Unknown error. Please, try again later",
        DOC_NOT_FOUND: "Document not found in DB",
        DOG_ALREADY_EXISTS: "Dog already exists",
        USER_IS_ACTIVE: "This action cannot be performed when a transaction is in place",
        USER_ALREADY_VERIFIED: "User is already verified",
        UNSUPPORTED_USER_TYPE: "Unsupported user type",
        SET_UP_USER_TYPE: "Setting up user type"
    },
    BREEDS: [

    ],
    formatResult: formatResult,
    formatError: formatError,
    formatData: formatData,
    toMillis: toMillis
} 

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
