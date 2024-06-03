# Google Calender API Demo

Built on Swift using GoogleSignIn and GoogleAPIClientForREST
This app is built to show all the events associated with a google account.
Events can be added to google calender.

# Features
* Sign in via Google
* Accept Calendar Permissions
* Users can view all the events associated with a calendar for each day
* Users can add new event and sync to google calender
* Users can see the details for other events
* Supports iOS

# Tech
This demo uses a number of open source projects to work properly:

* GoogleSignIn-iOS - Enables iOS apps to sign in with Google.
* GoogleAPIClientForRest - Google API Client in ObjC to fetch API data for google services
* FSCalender - A fully customizable iOS calendar library, compatible with Objective-C and Swift
* Firebase - Added Firebase Authentication

And of course this demo app itself is open source with a public repository on GitHub.

# Installation
* Fetch Google Auth 2.0 token from Google cloud console.
* Enable Calendar API
* Modify OAuth 2.0 token and add calendar scopes, as required.
* Add testers to the OAuth token
* Create API key with the app bundle identifier
* Download the OAuth 2.0 plist file and add to project
* Rename the Plist file to GoogleInfo.plist
* Install the packages via SPM (Swift Package Manager) or Wait for the packages to be resolved automatically
* Install the dependencies and devDependencies and build the application.
