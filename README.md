<h2 itemprop="name">appengine-endpoints-tictactoe-client-dart</h2>

<p itemprop="description">A simple client for a Tic Tac Toe game using Google Cloud Endpoints and Dart.</p>

<img src="https://lh3.googleusercontent.com/-GrxTG9h2fnw/VCFpQM4zKCI/AAAAAAACS7M/uFD4s-75UP8/w1024/tictactoe.png" itemprop="image" alt="Tic Tac Toe">


### Setup

##### 1. Deploy or run the Tic Tac Toe backend

For this example I used the Python version.
Follow the instructions here: https://github.com/GoogleCloudPlatform/appengine-endpoints-tictactoe-python

In addition to those instructions you will also have to enter the Client ID you created in [web/tictactoe.dart](web/tictactoe.dart#L13).

##### 2. Create client library

To create the Dart Client Library to access the Tic Tac Toe API, you will need to download/clone the client generator,
then fetch the discovery document from the App Engine instance (either deployed or running on dev server),
and use this discovery document to generate the client library:

```
git clone https://github.com/dart-lang/discovery_api_dart_client_generator
cd discovery_api_dart_client_generator
pub get
mkdir input
URL='http://localhost:8080/_ah/api/discovery/v1/apis/tictactoe/v1/rest'
curl -s -o input/tictactoe.json $URL
bin/generate.dart generate --input-dir=input --output-dir=../myapi --package-name=myapi
```

You then either have to copy the created myapi folder over to `dependencies` or change the path reference in [pubspec.yaml](pubspec.yaml#L12).

This project includes a [pre-generated client library](dependencies/myapi). If you want to use it without generating your own you will possibly have to change the server URL in [lib/tictactoe/v1.dart](dependencies/myapi/lib/tictactoe/v1.dart#L28).


### How it all works

##### Authentication

For authentication the new and shiny [googleapis_auth package](https://pub.dartlang.org/packages/googleapis_auth) is used. It offers several flows for different scenarios on clients and servers. In this case we are interested in the `BrowserOAuth2Flow`.
Internally the [Google APIs Client Library for JavaScript](https://developers.google.com/api-client-library/javascript/) is used, which needs to be loaded before you can initiate a flow, which is done via the `createImplicitBrowserFlow` method. After you have the flow method you can either retrieve the `AccessCredentials` object or request a HTTP client that will automatically add the authorization header to all requests sent via it. For the API client library we will need the HTTP client which we can pass into the library to be used for the API requests.

```
var id = new ClientId("....apps.googleusercontent.com", null);
var scopes = [...];

createImplicitBrowserFlow(id, scopes).then((BrowserOAuth2Flow flow) {
  flow.clientViaUserConsent().then((AuthClient client) {
    ...
  });
});
```

It's important to note that the `clientViaUserConsent()` method should not be called without user interaction (unless you set `forceUserConsent: false`) because this will trigger a pop-up warning in most browsers. This also means that you already need a `BrowserOAuth2Flow` object before you expect the user interaction to happen.

This will result in a pop-up warning:
```
querySelector('#signInButton').onClick.listen((_) {
  createImplicitBrowserFlow(id, scopes).then((BrowserOAuth2Flow flow) {
    flow.clientViaUserConsent().then(...);
  });
});
```

This will work without pop-up warning:
```
createImplicitBrowserFlow(id, scopes).then((BrowserOAuth2Flow flow) {
  querySelector('#signInButton').onClick.listen((_) {
    flow.clientViaUserConsent().then(...);
  });
});
```

In this demo I also check for "immediate" authentication first to automatically sign-in users who have signed-in before:

```
createImplicitBrowserFlow(id, scopes).then((BrowserOAuth2Flow flow) {
  // Try am immediate sign-in first
  flow.clientViaUserConsent(forceUserConsent: false).then(...);

  querySelector('#signInButton').onClick.listen((_) {
    // Start flow that will open the auth-popup if necessary
    flow.clientViaUserConsent().then(...);
  });
});
```
