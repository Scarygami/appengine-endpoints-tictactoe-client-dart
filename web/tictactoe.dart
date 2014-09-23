import 'dart:html';
import 'package:myapi/tictactoe/v1.dart';
import 'package:googleapis/plus/v1.dart';
import 'package:googleapis_auth/auth_browser.dart';

const List STATUS = const ['NOT_DONE', 'WON', 'LOST', 'TIE'];
const List MESSAGE = const ['', 'You win!', 'You lost!', 'You tied!'];
const int NOT_DONE = 0;
const int WON = 1;
const int LOST = 2;
const int TIE = 3;

final clientId = new ClientId('YOUR-CLIENT-ID', null);
final scopes = ['profile', 'email'];
PlusApi plus;
TictactoeApi tictactoe;

bool waiting = true;

String getBoard() => querySelectorAll('#board td').map((td) => td.innerHtml).join();

void setBoard(String state) {
  querySelectorAll('#board td').asMap().forEach((i, td) {
    td.innerHtml = state[i];
  });
}


void startGame() {
  querySelector('#board').classes.remove('hidden');
  querySelector('#gameHistoryWrapper').classes.remove('hidden');
  querySelector('#warning').classes.add('hidden');
  querySelector('#victory').innerHtml = '';
  queryScores();
}

void stopGame() {
  querySelector('#board').classes.add('hidden');
  querySelector('#gameHistoryWrapper').classes.add('hidden');
  querySelector('#warning').classes.remove('hidden');
}

void resetGame() {
  waiting = true;
  querySelectorAll('#board td').forEach((td) => td.innerHtml = '-');
  querySelector('#victory').innerHtml = '';
}

void queryScores() {
  tictactoe.scores.list().then((TictactoeApiMessagesScoresListResponse list) {
    var history = querySelector('#gameHistory');
    history.innerHtml = '';
    if (list != null && list.items != null) {
      list.items.forEach((TictactoeApiMessagesScoreResponseMessage score) {
        var li = new LIElement();
        li.innerHtml = score.outcome;
        history.append(li);
      });
    }
  });
}

int checkVictory(String board) {
  var state;

  // Check rows
  for (int i = 0; i < 3; i++) {
    state = checkRowVictory([board[i * 3], board[i * 3 + 1], board[i * 3 + 2]]);
    if (state != NOT_DONE) { return state; }
  }

  // Check columns
  for (int i = 0; i < 3; i++) {
    state = checkRowVictory([board[i], board[i + 3], board[i + 6]]);
    if (state != NOT_DONE) { return state; }
  }

  // Check diagonal 1
  state = checkRowVictory([board[0], board[4], board[8]]);
  if (state != NOT_DONE) { return state; }

  // Check diagonal 2
  state = checkRowVictory([board[2], board[4], board[6]]);
  if (state != NOT_DONE) { return state; }

  if (board.indexOf('-') < 0) {
    return TIE;
  }

  return NOT_DONE;
}

int checkRowVictory(List<String> row) {
  if (row[0] == row[1] && row[0] == row[2]) {
    if (row[0] == 'X') {
      return WON;
    }
    if (row[0] == 'O') {
      return LOST;
    }
  }
  return NOT_DONE;
}

void handleClick(MouseEvent e) {
  if (!waiting) { return; }

  Element td = e.target;

  if (td.innerHtml != '-') { return; }

  td.innerHtml = 'X';

  waiting = false;

  var board = getBoard();
  var status = checkVictory(board);
  if (status == NOT_DONE) {
    var request = new TictactoeApiMessagesBoardMessage();
    request.state = board;
    tictactoe.board.getmove(request).then((TictactoeApiMessagesBoardMessage response) {
      setBoard(response.state);
      var status = checkVictory(response.state);
      if (status == NOT_DONE) {
        waiting = true;
      } else {
        handleVictory(status);
      }
    });
  } else {
    handleVictory(status);
  }
}

void handleVictory(int status) {
  querySelector('#victory').innerHtml = MESSAGE[status];
  var result = new TictactoeApiMessagesScoreRequestMessage();
  result.outcome = STATUS[status];
  tictactoe.scores.insert(result).then((_) {
    queryScores();
  });
}

void handleAuth(AuthClient client) {
  if (client != null) {
    querySelector('#signinButtonContainer').classes.remove('visible');
    querySelector('#signout').classes.add('visible');
    plus = new PlusApi(client);
    tictactoe = new TictactoeApi(client);
    plus.people.get('me').then((p) {
      querySelector('#userLabel').innerHtml = p.displayName;
      startGame();
    });
  } else {
    plus = null;
    tictactoe = null;
    querySelector('#signinButtonContainer').classes.add('visible');
    querySelector('#signout').classes.remove('visible');
    querySelector('#userLabel').innerHtml = '(not signed in)';
    stopGame();
  }
}

void main() {
  createImplicitBrowserFlow(clientId, scopes).then((BrowserOAuth2Flow flow) {
    // Try am immediate sign-in first
    flow.clientViaUserConsent(forceUserConsent: false).then(handleAuth).catchError((_) => handleAuth(null));
    querySelector('#signInButton').onClick.listen((_) {
      flow.clientViaUserConsent().then(handleAuth).catchError((_) => handleAuth(null));
    });
  });
  querySelector('#signout').onClick.listen((_) {
    handleAuth(null);
  });
  querySelector('#restartButton').onClick.listen((_) => resetGame());

  querySelectorAll('#board td').forEach((td) {
    td.onClick.listen(handleClick);
  });
}

