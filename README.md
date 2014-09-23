##appengine-endpoints-tictactoe-client-dart

A simple client for a Tic Tac Toe game using Google Cloud Endpoints and Dart.


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

