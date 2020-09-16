library animated_sliced_button;

import 'package:animated_sliced_button/piece.dart';
import 'package:animated_sliced_button/piece_types.dart';
import 'package:flutter/material.dart';

class SlicedButton extends StatefulWidget {
  final String text;
  final TextStyle textStyle;

  final Color backgroundColor;

  final double width;
  final double height;
  final double crashDistance;

  final Duration crashDuration;

  List<Widget> _buttonPieces;

  final VoidCallback onTap;

  final VoidCallback onEnd;

  SlicedButton(
      {
        @required this.width,
        @required this.height,
        @required this.text,
        this.backgroundColor = Colors.black87,
        this.crashDistance = 14,
        this.crashDuration,
        this.textStyle,
        @required this.onTap,
        this.onEnd
      }) {

    SHAPE_BODY _choosedNext;
    DIAGONAL _starter;
    dynamic _choosed;

    _buttonPieces = List<Widget>.generate(this.text.length, (charIndex) {
      if (charIndex == 0) {
        _starter = (PIECE_TYPE.START.SHAPES..shuffle()).first;
        _choosed = _starter;
      } else if (charIndex == 1) {
        _choosedNext = (_starter.NEXT..shuffle()).first;
        _choosed = _choosedNext;
      } else if (charIndex == this.text.length - 1) {
        DIAGONAL _end = _choosedNext.END;
        _choosed = _end;
      } else {
        List<SHAPE_BODY> _body = _choosedNext.NEXT;
        _choosedNext = (_body..shuffle()).first;
        _choosed = _choosedNext;
      }
      return Piece(
          index: charIndex,
          height: this.height,
          width: ((this.width+(this.crashDistance*(this.text.length-1)))/this.text.length),
          clipHeight: this.crashDistance,
          shape: _choosed,
          char: this.text[charIndex],
          backgroundColor: this.backgroundColor,
          charStyle: this.textStyle == null ? TextStyle(color: Colors.cyanAccent,fontSize: 30) : this.textStyle
      );
    });
  }

  @override
  _SlicedButtonState createState() => _SlicedButtonState();

}

class _SlicedButtonState extends State<SlicedButton> {
  bool animate = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (){
          setState(() {
            this.animate = !this.animate;
          });
          widget.onTap();
        },
        child:
        AnimatedContainer(
          duration: widget.crashDuration == null ? Duration(milliseconds: 150) : widget.crashDuration,
          curve: Curves.easeOutBack,
          height: widget.height,
          width: widget.width,
          transform: Matrix4.translationValues( this.animate == true ? -((widget.crashDistance*(widget.text.length-1))/2 ) : 0  ,0, 0),
          child: Stack(
            clipBehavior: Clip.antiAlias,
            overflow: Overflow.visible,
            children: List<Widget>.generate(widget._buttonPieces.length, (index) {
              return AnimatedPositioned(
                onEnd: (){
                  setState(() {
                    this.animate = false;
                  });
                },
                duration: Duration(milliseconds: 150),
                curve: Curves.easeOutBack,
                left: this.animate == true ? ((widget.width+(widget.crashDistance*(widget.text.length-1)))/widget.text.length)*index : (((widget.width/widget.text.length)-widget.crashDistance/widget.text.length) * index)*0.995,
                top:  this.animate == true ? (index % 2 == 0 ? widget.crashDistance : -widget.crashDistance) : 0,
                //transform: Matrix4.translationValues(this.animate == true ? -(widget.crashDistance*widget.text.length*0.35) : -(index * widget.crashDistance), this.animate == true ? (index % 2 == 0 ? 20 : -20) : 0, 0),
                child: widget._buttonPieces[index],
              );
            }),
          ),
        )

    );
  }

}

