let LOCALE = {
    ARGENTINA: {
        phoneNumber: {
            prefixes: ['0054', '+54'],
            length: {
                max: 14,
                min: 6
            }
        }
    }
}

export default {
    validateString: validateString,
    validatePhoneNumber: validatePhoneNumber,
    validateArray: validateArray,

    LOCALE: LOCALE
}

// Returns true if string is valid, else false.
function validateString(string, locale) {
    return !(!(string instanceof String) || string.length === 0)
}

// Returns true if phone number is valid, else false.
function validatePhoneNumber(phoneNumber, locale) {
    if (locale === LOCALE.ARGENTINA) {
        let stringPhoneNumber = String(phoneNumber)
        if (stringPhoneNumber.startsWith('0') || stringPhoneNumber.startsWith('+')) {
            for (let prefix of locale.phoneNumber.prefixes) {
                if (!stringPhoneNumber.startsWith(prefix)) {
                    return false
                }
            }
        }
        return !(stringPhoneNumber.length < locale.phoneNumber.length.min || stringPhoneNumber.length > locale.phoneNumber.length.max)
    }

    return false
}

// Returns true if array and every subelement are valid, else false.
function validateArray(array, locale, validator) {
    if (!(array instanceof Array) || array.length === 0) {
        return false
    }
    for (let a of array) {
        if (!validator(a, locale))
            return false
    }

    return true
}
