import 'package:clippy_flutter/clippy_flutter.dart';

enum PIECE_TYPE { START, END, BODY }

enum SHAPE_WIDGET { DIAGONAL, TRIPAZOID, PARALLEL }

enum DIAGONAL { TOP_LEFT, TOP_RIGHT, BOTTOM_LEFT, BOTTOM_RIGHT }


enum SHAPE_BODY {
  TRIPAZOID_TOP,
  TRIPAZOID_BOTTOM,
  PARALLEL_LEFT,
  PARALLEL_RIGHT
}

extension PIECE_OPS on PIECE_TYPE {
  List<DIAGONAL>? get SHAPES {
    switch (this) {
      case PIECE_TYPE.START:
        return [DIAGONAL.BOTTOM_RIGHT, DIAGONAL.TOP_RIGHT];

      case PIECE_TYPE.END:
        return [DIAGONAL.BOTTOM_LEFT, DIAGONAL.TOP_LEFT];
    }
  }
}

extension DIAGONAL_OPS on DIAGONAL {
  List<SHAPE_BODY>? get NEXT {
    switch (this) {
      case DIAGONAL.TOP_RIGHT:
        return [SHAPE_BODY.TRIPAZOID_TOP, SHAPE_BODY.PARALLEL_RIGHT];
      case DIAGONAL.BOTTOM_RIGHT:
        return [SHAPE_BODY.TRIPAZOID_BOTTOM, SHAPE_BODY.PARALLEL_LEFT];
    }
  }

  DiagonalPosition? get EDGE {
    switch (this) {
      case DIAGONAL.TOP_RIGHT:
        return DiagonalPosition.TOP_RIGHT;
      case DIAGONAL.BOTTOM_RIGHT:
        return DiagonalPosition.BOTTOM_RIGHT;
      case DIAGONAL.TOP_LEFT:
        return DiagonalPosition.TOP_LEFT;
      case DIAGONAL.BOTTOM_LEFT:
        return DiagonalPosition.BOTTOM_LEFT;
    }
  }

  get WIDGET {
    return SHAPE_WIDGET.DIAGONAL;
  }
}

extension SHAPE_BODY_OPS on SHAPE_BODY {
  List<SHAPE_BODY>? get NEXT {
    switch (this) {
      case SHAPE_BODY.TRIPAZOID_TOP:
        return [SHAPE_BODY.PARALLEL_LEFT, SHAPE_BODY.TRIPAZOID_BOTTOM];

      case SHAPE_BODY.TRIPAZOID_BOTTOM:
        return [SHAPE_BODY.PARALLEL_RIGHT, SHAPE_BODY.TRIPAZOID_TOP];

      case SHAPE_BODY.PARALLEL_LEFT:
        return [SHAPE_BODY.TRIPAZOID_BOTTOM];

      case SHAPE_BODY.PARALLEL_RIGHT:
        return [SHAPE_BODY.TRIPAZOID_TOP];
    }
  }

  DIAGONAL? get END {
    switch (this) {
      case SHAPE_BODY.TRIPAZOID_TOP:
      case SHAPE_BODY.PARALLEL_LEFT:
        return DIAGONAL.TOP_LEFT;

      case SHAPE_BODY.TRIPAZOID_BOTTOM:
      case SHAPE_BODY.PARALLEL_RIGHT:
        return DIAGONAL.BOTTOM_LEFT;
    }
  }

  Edge? get EDGE {
    switch (this) {
      case SHAPE_BODY.TRIPAZOID_TOP:
        return Edge.TOP;

      case SHAPE_BODY.TRIPAZOID_BOTTOM:
        return Edge.BOTTOM;

      case SHAPE_BODY.PARALLEL_LEFT:
        return Edge.LEFT;

      case SHAPE_BODY.PARALLEL_RIGHT:
        return Edge.RIGHT;
    }
  }

  SHAPE_WIDGET? get WIDGET {
    switch (this) {
      case SHAPE_BODY.TRIPAZOID_BOTTOM:
      case SHAPE_BODY.TRIPAZOID_TOP:
        return SHAPE_WIDGET.TRIPAZOID;

      case SHAPE_BODY.PARALLEL_RIGHT:
      case SHAPE_BODY.PARALLEL_LEFT:
        return SHAPE_WIDGET.PARALLEL;
    }
  }
}
