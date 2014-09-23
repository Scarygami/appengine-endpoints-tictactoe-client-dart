library myapi.tictactoe.v1;

import "dart:core" as core;
import "dart:collection" as collection;
import "dart:async" as async;
import "dart:convert" as convert;

import "package:crypto/crypto.dart" as crypto;
import 'package:http/http.dart' as http;
import '../src/common_internal.dart' as common_internal;
import '../common/common.dart' as common;

export '../common/common.dart' show ApiRequestError;
export '../common/common.dart' show DetailedApiRequestError;

/** Tic Tac Toe API */
class TictactoeApi {
  /** View your email address */
  static const UserinfoEmailScope = "https://www.googleapis.com/auth/userinfo.email";


  final common_internal.ApiRequester _requester;

  BoardResourceApi get board => new BoardResourceApi(_requester);
  ScoresResourceApi get scores => new ScoresResourceApi(_requester);

  TictactoeApi(http.Client client) : 
      _requester = new common_internal.ApiRequester(client, "http://localhost:8080/_ah/api/", "tictactoe/v1/");
}


/** Not documented yet. */
class BoardResourceApi {
  final common_internal.ApiRequester _requester;

  BoardResourceApi(common_internal.ApiRequester client) : 
      _requester = client;

  /**
   * Exposes an API endpoint to simulate a computer move in tictactoe. Args:
   * request: An instance of BoardMessage parsed from the API request. Returns:
   * An instance of BoardMessage with a single 'O' added to the board passed in.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [TictactoeApiMessagesBoardMessage].
   *
   * Completes with a [common.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method  will complete with the same error.
   */
  async.Future<TictactoeApiMessagesBoardMessage> getmove(TictactoeApiMessagesBoardMessage request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = common.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }


    _url = 'board';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new TictactoeApiMessagesBoardMessage.fromJson(data));
  }

}


/** Not documented yet. */
class ScoresResourceApi {
  final common_internal.ApiRequester _requester;

  ScoresResourceApi(common_internal.ApiRequester client) : 
      _requester = client;

  /**
   * Exposes an API endpoint to insert a score for the current user. Args:
   * request: An instance of ScoreRequestMessage parsed from the API request.
   * Returns: An instance of ScoreResponseMessage containing the score inserted,
   * the time the score was inserted and the ID of the score.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [TictactoeApiMessagesScoreResponseMessage].
   *
   * Completes with a [common.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method  will complete with the same error.
   */
  async.Future<TictactoeApiMessagesScoreResponseMessage> insert(TictactoeApiMessagesScoreRequestMessage request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = common.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }


    _url = 'scores';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new TictactoeApiMessagesScoreResponseMessage.fromJson(data));
  }

  /**
   * Exposes an API endpoint to query for scores for the current user. Args:
   * request: An instance of ScoresListRequest parsed from the API request.
   * Returns: An instance of ScoresListResponse containing the scores for the
   * current user returned in the query. If the API request specifies an order
   * of WHEN (the default), the results are ordered by time from most recent to
   * least recent. If the API request specifies an order of TEXT, the results
   * are ordered by the string value of the scores.
   *
   * Request parameters:
   *
   * [limit] - null
   *
   * [order] - null
   * Possible string values are:
   * - "TEXT"
   * - "WHEN"
   *
   * Completes with a [TictactoeApiMessagesScoresListResponse].
   *
   * Completes with a [common.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method  will complete with the same error.
   */
  async.Future<TictactoeApiMessagesScoresListResponse> list({core.String limit, core.String order}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = common.DownloadOptions.Metadata;
    var _body = null;

    if (limit != null) {
      _queryParams["limit"] = [limit];
    }
    if (order != null) {
      _queryParams["order"] = [order];
    }


    _url = 'scores';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new TictactoeApiMessagesScoresListResponse.fromJson(data));
  }

}



/** ProtoRPC message definition to represent a board. */
class TictactoeApiMessagesBoardMessage {
  /** Not documented yet. */
  core.String state;


  TictactoeApiMessagesBoardMessage();

  TictactoeApiMessagesBoardMessage.fromJson(core.Map _json) {
    if (_json.containsKey("state")) {
      state = _json["state"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (state != null) {
      _json["state"] = state;
    }
    return _json;
  }
}


/** ProtoRPC message definition to represent a score to be inserted. */
class TictactoeApiMessagesScoreRequestMessage {
  /** Not documented yet. */
  core.String outcome;


  TictactoeApiMessagesScoreRequestMessage();

  TictactoeApiMessagesScoreRequestMessage.fromJson(core.Map _json) {
    if (_json.containsKey("outcome")) {
      outcome = _json["outcome"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (outcome != null) {
      _json["outcome"] = outcome;
    }
    return _json;
  }
}


/** ProtoRPC message definition to represent a score that is stored. */
class TictactoeApiMessagesScoreResponseMessage {
  /** Not documented yet. */
  core.String id;

  /** Not documented yet. */
  core.String outcome;

  /** Not documented yet. */
  core.String played;


  TictactoeApiMessagesScoreResponseMessage();

  TictactoeApiMessagesScoreResponseMessage.fromJson(core.Map _json) {
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("outcome")) {
      outcome = _json["outcome"];
    }
    if (_json.containsKey("played")) {
      played = _json["played"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (id != null) {
      _json["id"] = id;
    }
    if (outcome != null) {
      _json["outcome"] = outcome;
    }
    if (played != null) {
      _json["played"] = played;
    }
    return _json;
  }
}


/** ProtoRPC message definition to represent a list of stored scores. */
class TictactoeApiMessagesScoresListResponse {
  /** ProtoRPC message definition to represent a score that is stored. */
  core.List<TictactoeApiMessagesScoreResponseMessage> items;


  TictactoeApiMessagesScoresListResponse();

  TictactoeApiMessagesScoresListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new TictactoeApiMessagesScoreResponseMessage.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (items != null) {
      _json["items"] = items.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}


