import 'package:animated_sliced_button/piece_types.dart';
import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/material.dart';

class Piece extends StatelessWidget {
  final Color backgroundColor;
  final String char;
  final TextStyle charStyle;
  final double width;
  final double height;
  final double clipHeight;
  final dynamic shape;
  Widget renderWidget;
  final int index;
  final Radius borderRadius;
  Piece(
      {this.shape,
      this.width,
      this.height,
      this.char,
      this.charStyle,
      this.backgroundColor,
      this.clipHeight,
      this.index, this.borderRadius,
      }) {
    final Widget shapeContainer = Container(
      decoration: BoxDecoration(
        color: this.backgroundColor,
      ),
      alignment: Alignment.center,
      width: this.width,
      height: this.height,
      child: Text(
        this.char,
        style: this.charStyle,
      ),
    );

    if (this.shape.runtimeType == DIAGONAL) {
      this.renderWidget = ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: this.shape == DIAGONAL.TOP_RIGHT || this.shape == DIAGONAL.BOTTOM_RIGHT ? this.borderRadius ?? Radius.circular(0) : Radius.circular(0),
            bottomLeft: this.shape == DIAGONAL.TOP_RIGHT || this.shape == DIAGONAL.BOTTOM_RIGHT ? this.borderRadius ?? Radius.circular(0) : Radius.circular(0),
            bottomRight: this.shape == DIAGONAL.TOP_LEFT || this.shape == DIAGONAL.BOTTOM_LEFT ? this.borderRadius ?? Radius.circular(0):Radius.circular(0),
            topRight: this.shape == DIAGONAL.TOP_LEFT || this.shape == DIAGONAL.BOTTOM_LEFT ? this.borderRadius ?? Radius.circular(0):Radius.circular(0)),
        child: Diagonal(
          axis: Axis.vertical,
          clipHeight: this.clipHeight,
          position: (this.shape as DIAGONAL).EDGE,
          child: shapeContainer,
        ),
      );
    } else {
      SHAPE_WIDGET _shapeBody = (this.shape as SHAPE_BODY).WIDGET;
      if (_shapeBody == SHAPE_WIDGET.PARALLEL) {
        this.renderWidget = Parallelogram(
          cutLength: this.clipHeight,
          edge: (this.shape as SHAPE_BODY).EDGE,
          child: shapeContainer,
        );
      }
      if (_shapeBody == SHAPE_WIDGET.TRIPAZOID) {
        this.renderWidget = Trapezoid(
          cutLength: this.clipHeight,
          edge: (this.shape as SHAPE_BODY).EDGE,
          child: shapeContainer,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return this.renderWidget;
  }
}
