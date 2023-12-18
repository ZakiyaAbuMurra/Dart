import 'dart:io' ; 

void main() {
  List<List<String>> board = initializeBoard();
  String currentPlayer = 'X';
  bool isWinner = false;
  bool isDraw = false;

  do {
    displayBoard(board);
    makeMove(board, currentPlayer);
    isWinner = checkWin(board, currentPlayer);
    isDraw = !isWinner && checkDraw(board);

    if (isWinner || isDraw) {
      displayBoard(board);
      print(isWinner ? '$currentPlayer wins!' : "It's a draw!");
    }

    currentPlayer = isWinner || isDraw ? currentPlayer : switchPlayer(currentPlayer);
  } while (!isWinner && !isDraw);
}


List<List<String>> initializeBoard() {
  return [
    [' ', ' ', ' '],
    [' ', ' ', ' '],
    [' ', ' ', ' ']
  ];
}

void displayBoard(List<List<String>> board) {
  print('\n  1 2 3');
  for (int i = 0; i < board.length; i++) {
    String rowDisplay = '${i + 1} ';
    for (int j = 0; j < board[i].length; j++) {
      rowDisplay += '|${board[i][j]}';
    }
    print('$rowDisplay|');
  }
  print('');
}

void makeMove(List<List<String>> board, String player) {
  while (true) {
    stdout.write("Player $player, enter your move (1-9): ");
    String? input = stdin.readLineSync();
    int move = input != null && int.tryParse(input) != null ? int.parse(input) : 0;

    if (move < 1 || move > 9) {
      print("Invalid input. Please enter a number between 1 and 9.");
      continue;
    }

    int row = (move - 1) ~/ 3;
    int col = (move - 1) % 3;

    if (board[row][col] == ' ') {
      board[row][col] = player;
      break;
    } else {
      print("That cell is already occupied. Try again.");
    }
  }
}

String switchPlayer(String currentPlayer) {
  return currentPlayer == 'X' ? 'O' : 'X';
}

bool checkWin(List<List<String>> board, String player) {
  // Check rows
  for (var row in board) {
    if (isLineWinning(row, player)) return true;
  }

  // Check columns
  for (int col = 0; col < 3; col++) {
    if (isColumnWinning(board, col, player)) return true;
  }

  // Check diagonals
  return isDiagonalWinning(board, player);
}

bool isLineWinning(List<String> line, String player) {
  return line.every((cell) => cell == player);
}

bool isColumnWinning(List<List<String>> board, int col, String player) {
  for (int row = 0; row < 3; row++) {
    if (board[row][col] != player) return false;
  }
  return true;
}

bool isDiagonalWinning(List<List<String>> board, String player) {
  bool diag1 = true, diag2 = true;
  for (int i = 0; i < 3; i++) {
    if (board[i][i] != player) diag1 = false;
    if (board[i][2 - i] != player) diag2 = false;
  }
  return diag1 || diag2;
}

bool checkDraw(List<List<String>> board) {
  for (var row in board) {
    for (var cell in row) {
      if (cell == ' ') {
        return false;
      }
    }
  }
  return true;
}

