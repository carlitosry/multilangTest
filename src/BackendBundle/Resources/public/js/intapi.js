/**
 * Created by EREYES on 28/02/2017.
 */

// Setup an event listener to make an API call once auth is complete
function onLinkedInLoad() {
    IN.Event.on(IN, "auth", getProfileData);
}
// Setup an event listener to make an API call once auth is complete
function onLinkedInLoadOthe() {
    IN.Event.on(IN, "auth", getpageData);
}

// Handle the successful return from the API call
function onSuccess(data) {
    console.log(data);
}

// Handle an error response from the API call
function onError(error) {
    console.log(error);
}

// Use the API call wrapper to request the member's basic profile data
//ID 11052900
function getProfileData() {
    IN.API.Raw("/people/~").result(onSuccess).error(onError);
}

function getpageData() {
    IN.API.Raw("/people/~/following/companies?format=json").result(onSuccess).error(onError);
}


////////// PROBAND





