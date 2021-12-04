import '../day.dart';

class Day04 implements Day {
  final List<int> draws;
  final List<Board> boards;

  Day04(List<String> input)
      : draws = input[0].split(',').map(int.parse).toList(),
        boards = toBoards(input.getRange(2, input.length).toList());

  static List<Board> toBoards(List<String> input) {
    var boardList = List<Board>.empty(growable: true);
    for (int i = 0; i < input.length; i += 6) {
      var thisBoard = [
        input[i],
        input[i + 1],
        input[i + 2],
        input[i + 3],
        input[i + 4],
      ];
      boardList.add(Board(thisBoard));
    }
    return boardList;
  }

  @override
  part1() {
    for (var draw in draws) {
      for (var board in boards) {
        board.markNumber(draw);
        board.markWon();
        if (board.won) {
          return draw * board.flatNumbers().where((element) => !element.marked).map((e) => e.number).reduce((value, element) => value+element);
        }
      }
    }
  }

  @override
  part2() {
    var last = 0;
    for (var draw in draws) {
      var missingBoards = boards.where((element) => !element.won).toList();
      for (var board in missingBoards) {
        board.markNumber(draw);
        board.markWon();
        if (board.won) {
          last = draw * board.flatNumbers().where((element) => !element.marked).map((
              e) => e.number).reduce((value, element) => value + element);
        }
      }
    }
    return last;
  }
}

class Board {
  final List<List<BoardNumber>> numbers;
  bool won = false;

  Board(List<String> thisBoard)
      : numbers = thisBoard
            .map((e) {
              var foo = e.trim().split(RegExp('\\s+'));
              return foo.map((a) =>
                  BoardNumber(int.parse(a)))
                .toList();
            })
            .toList();

  List<BoardNumber> flatNumbers() => numbers.expand((e) => e).toList();

  void markNumber(int draw) {
    for (var value in flatNumbers().where((e) => e.number == draw)) {
      value.marked = true;
    }
  }

  void markWon() {
    for (int i = 0; i < 5; i++) {
      if (numbers[i].where((e) => e.marked).length == 5) {
        won = true;
      }
      if (numbers.map((e) => e[i]).where((e) => e.marked).length == 5) {
        won = true;
      }
    }
  }
}

class BoardNumber {
  final int number;
  bool marked = false;

  BoardNumber(this.number);
}
