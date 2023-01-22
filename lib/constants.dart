const stravaClientId = '53914';
const stravaClientSecret = 'a933481332a3a6cc34a7f2d64b1e5366d706e86c';
const stravaAuthorizationEndpoint =
    "https://www.strava.com/oauth/mobile/authorize";
const stravaAuthRedirectScheme = 'http';
const stravaAuthRedirectHost = 'localhost';
const stravaAuthRedirectPath = '/stravafy';
const stravaAuthUrl =
    '$stravaAuthorizationEndpoint?client_id=$stravaClientId&redirect_uri=$stravaAuthRedirectScheme://$stravaAuthRedirectHost$stravaAuthRedirectPath&response_type=code&approval_prompt=auto&scope=read,activity:read';
