library myapi.tictactoe.v1.test;

import "dart:core" as core;
import "dart:collection" as collection;
import "dart:async" as async;
import "dart:convert" as convert;

import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as http_testing;
import 'package:unittest/unittest.dart' as unittest;
import 'package:myapi/common/common.dart' as common;
import 'package:myapi/src/common_internal.dart' as common_internal;
import '../common/common_internal_test.dart' as common_test;

import 'package:myapi/tictactoe/v1.dart' as api;



core.int buildCounterTictactoeApiMessagesBoardMessage = 0;
buildTictactoeApiMessagesBoardMessage() {
  var o = new api.TictactoeApiMessagesBoardMessage();
  buildCounterTictactoeApiMessagesBoardMessage++;
  if (buildCounterTictactoeApiMessagesBoardMessage < 3) {
    o.state = "foo";
  }
  buildCounterTictactoeApiMessagesBoardMessage--;
  return o;
}

checkTictactoeApiMessagesBoardMessage(api.TictactoeApiMessagesBoardMessage o) {
  buildCounterTictactoeApiMessagesBoardMessage++;
  if (buildCounterTictactoeApiMessagesBoardMessage < 3) {
    unittest.expect(o.state, unittest.equals('foo'));
  }
  buildCounterTictactoeApiMessagesBoardMessage--;
}

core.int buildCounterTictactoeApiMessagesScoreRequestMessage = 0;
buildTictactoeApiMessagesScoreRequestMessage() {
  var o = new api.TictactoeApiMessagesScoreRequestMessage();
  buildCounterTictactoeApiMessagesScoreRequestMessage++;
  if (buildCounterTictactoeApiMessagesScoreRequestMessage < 3) {
    o.outcome = "foo";
  }
  buildCounterTictactoeApiMessagesScoreRequestMessage--;
  return o;
}

checkTictactoeApiMessagesScoreRequestMessage(api.TictactoeApiMessagesScoreRequestMessage o) {
  buildCounterTictactoeApiMessagesScoreRequestMessage++;
  if (buildCounterTictactoeApiMessagesScoreRequestMessage < 3) {
    unittest.expect(o.outcome, unittest.equals('foo'));
  }
  buildCounterTictactoeApiMessagesScoreRequestMessage--;
}

core.int buildCounterTictactoeApiMessagesScoreResponseMessage = 0;
buildTictactoeApiMessagesScoreResponseMessage() {
  var o = new api.TictactoeApiMessagesScoreResponseMessage();
  buildCounterTictactoeApiMessagesScoreResponseMessage++;
  if (buildCounterTictactoeApiMessagesScoreResponseMessage < 3) {
    o.id = "foo";
    o.outcome = "foo";
    o.played = "foo";
  }
  buildCounterTictactoeApiMessagesScoreResponseMessage--;
  return o;
}

checkTictactoeApiMessagesScoreResponseMessage(api.TictactoeApiMessagesScoreResponseMessage o) {
  buildCounterTictactoeApiMessagesScoreResponseMessage++;
  if (buildCounterTictactoeApiMessagesScoreResponseMessage < 3) {
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.outcome, unittest.equals('foo'));
    unittest.expect(o.played, unittest.equals('foo'));
  }
  buildCounterTictactoeApiMessagesScoreResponseMessage--;
}

buildUnnamed0() {
  var o = new core.List<api.TictactoeApiMessagesScoreResponseMessage>();
  o.add(buildTictactoeApiMessagesScoreResponseMessage());
  o.add(buildTictactoeApiMessagesScoreResponseMessage());
  return o;
}

checkUnnamed0(core.List<api.TictactoeApiMessagesScoreResponseMessage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkTictactoeApiMessagesScoreResponseMessage(o[0]);
  checkTictactoeApiMessagesScoreResponseMessage(o[1]);
}

core.int buildCounterTictactoeApiMessagesScoresListResponse = 0;
buildTictactoeApiMessagesScoresListResponse() {
  var o = new api.TictactoeApiMessagesScoresListResponse();
  buildCounterTictactoeApiMessagesScoresListResponse++;
  if (buildCounterTictactoeApiMessagesScoresListResponse < 3) {
    o.items = buildUnnamed0();
  }
  buildCounterTictactoeApiMessagesScoresListResponse--;
  return o;
}

checkTictactoeApiMessagesScoresListResponse(api.TictactoeApiMessagesScoresListResponse o) {
  buildCounterTictactoeApiMessagesScoresListResponse++;
  if (buildCounterTictactoeApiMessagesScoresListResponse < 3) {
    checkUnnamed0(o.items);
  }
  buildCounterTictactoeApiMessagesScoresListResponse--;
}


main() {
  unittest.group("obj-schema-TictactoeApiMessagesBoardMessage", () {
    unittest.test("to-json--from-json", () {
      var o = buildTictactoeApiMessagesBoardMessage();
      var od = new api.TictactoeApiMessagesBoardMessage.fromJson(o.toJson());
      checkTictactoeApiMessagesBoardMessage(od);
    });
  });


  unittest.group("obj-schema-TictactoeApiMessagesScoreRequestMessage", () {
    unittest.test("to-json--from-json", () {
      var o = buildTictactoeApiMessagesScoreRequestMessage();
      var od = new api.TictactoeApiMessagesScoreRequestMessage.fromJson(o.toJson());
      checkTictactoeApiMessagesScoreRequestMessage(od);
    });
  });


  unittest.group("obj-schema-TictactoeApiMessagesScoreResponseMessage", () {
    unittest.test("to-json--from-json", () {
      var o = buildTictactoeApiMessagesScoreResponseMessage();
      var od = new api.TictactoeApiMessagesScoreResponseMessage.fromJson(o.toJson());
      checkTictactoeApiMessagesScoreResponseMessage(od);
    });
  });


  unittest.group("obj-schema-TictactoeApiMessagesScoresListResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildTictactoeApiMessagesScoresListResponse();
      var od = new api.TictactoeApiMessagesScoresListResponse.fromJson(o.toJson());
      checkTictactoeApiMessagesScoresListResponse(od);
    });
  });


  unittest.group("resource-BoardResourceApi", () {
    unittest.test("method--getmove", () {

      var mock = new common_test.HttpServerMock();
      api.BoardResourceApi res = new api.TictactoeApi(mock).board;
      var arg_request = buildTictactoeApiMessagesBoardMessage();
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.TictactoeApiMessagesBoardMessage.fromJson(json);
        checkTictactoeApiMessagesBoardMessage(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("/_ah/api/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 13), unittest.equals("tictactoe/v1/"));
        pathOffset += 13;
        unittest.expect(path.substring(pathOffset, pathOffset + 5), unittest.equals("board"));
        pathOffset += 5;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildTictactoeApiMessagesBoardMessage());
        return new async.Future.value(common_test.stringResponse(200, h, resp));
      }), true);
      res.getmove(arg_request).then(unittest.expectAsync(((api.TictactoeApiMessagesBoardMessage response) {
        checkTictactoeApiMessagesBoardMessage(response);
      })));
    });

  });


  unittest.group("resource-ScoresResourceApi", () {
    unittest.test("method--insert", () {

      var mock = new common_test.HttpServerMock();
      api.ScoresResourceApi res = new api.TictactoeApi(mock).scores;
      var arg_request = buildTictactoeApiMessagesScoreRequestMessage();
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.TictactoeApiMessagesScoreRequestMessage.fromJson(json);
        checkTictactoeApiMessagesScoreRequestMessage(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("/_ah/api/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 13), unittest.equals("tictactoe/v1/"));
        pathOffset += 13;
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("scores"));
        pathOffset += 6;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildTictactoeApiMessagesScoreResponseMessage());
        return new async.Future.value(common_test.stringResponse(200, h, resp));
      }), true);
      res.insert(arg_request).then(unittest.expectAsync(((api.TictactoeApiMessagesScoreResponseMessage response) {
        checkTictactoeApiMessagesScoreResponseMessage(response);
      })));
    });

    unittest.test("method--list", () {

      var mock = new common_test.HttpServerMock();
      api.ScoresResourceApi res = new api.TictactoeApi(mock).scores;
      var arg_limit = "foo";
      var arg_order = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("/_ah/api/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 13), unittest.equals("tictactoe/v1/"));
        pathOffset += 13;
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("scores"));
        pathOffset += 6;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["limit"].first, unittest.equals(arg_limit));
        unittest.expect(queryMap["order"].first, unittest.equals(arg_order));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildTictactoeApiMessagesScoresListResponse());
        return new async.Future.value(common_test.stringResponse(200, h, resp));
      }), true);
      res.list(limit: arg_limit, order: arg_order).then(unittest.expectAsync(((api.TictactoeApiMessagesScoresListResponse response) {
        checkTictactoeApiMessagesScoresListResponse(response);
      })));
    });

  });


}

