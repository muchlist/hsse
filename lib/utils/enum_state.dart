/// Enum status document
enum enumStatus { draft, ready, approved, send }

extension ParseToString on enumStatus {
  String toShortString() {
    return toString().split('.').last;
  }
}

/// enum state screen
enum ViewState { idle, busy }
