import 'package:flutter/material.dart';
import 'dart:math' as math;

class PandaBarFabButton extends StatefulWidget {

  final double size;
  final VoidCallback? onTap;
  final List<Color>? colors;
  final Widget? icon;

  const PandaBarFabButton({
    Key? key,
    required this.size,
    required this.onTap,
    this.colors,
    this.icon,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PandaBarFabButtonState createState() => _PandaBarFabButtonState();
}

class _PandaBarFabButtonState extends State<PandaBarFabButton> {
  bool _touched = false;

  @override
  Widget build(BuildContext context) {
    final colors = widget.colors ??
        [
          const Color(0xFF0286EA),
          const Color(0xFF27A1FE),
        ];

    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: InkResponse(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: widget.onTap as void Function(),
        onHighlightChanged: (touched) {
          setState(() {
            _touched = touched;
          });
        },
        child: Transform.rotate(
          angle: 45 * math.pi / 180,
          child: Container(
            width: _touched ? widget.size - 1 : widget.size,
            height: _touched ? widget.size - 1 : widget.size,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.size / 3),
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: _touched ? colors : colors.reversed.toList()),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black38,
                      blurRadius: 5,
                      offset: Offset(3, 3))
                ]),
            child: Center(
              child: Transform.rotate(
                  angle: -45 * math.pi / 180,
                  child: widget.icon ??
                      Icon(
                        Icons.add,
                        size: widget.size / 1.5,
                        color: Colors.white,
                      )),
            ),
          ),
        ),
      ),
    );
  }
}