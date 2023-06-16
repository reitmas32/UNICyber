import 'dart:async';
import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:unica_cybercoffee/ui/providers/editable_ui_provider.dart';

class ComputerView extends StatefulWidget {
  const ComputerView({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.idState,
    required this.sesionStart,
  });

  final String name;
  final String imageUrl;
  final DateTime sesionStart;
  final int idState;

  @override
  State<ComputerView> createState() => _ComputerViewState();
}

class _ComputerViewState extends State<ComputerView> {
  late Timer timer;
  String diferenciaTiempo = '00:00';
  int seconds = 0;

  String hours = '';
  String minutes = '';

  @override
  void initState() {
    super.initState();
    if (widget.idState == 6) {
      timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
        final ahora = DateTime.now();
        final diferencia = ahora.difference(widget.sesionStart);
        setState(() {
          diferenciaTiempo = formatDuration(diferencia);
          seconds = diferencia.inSeconds;
        });
      });
    } else {
      timer = Timer.periodic(const Duration(days: 1), (timer) {});
    }
  }

  @override
  void dispose() {
    if (widget.idState == 6) {
      timer.cancel();
    }
    super.dispose();
  }

  String formatDuration(Duration duration) {
    hours = duration.inHours.toString().padLeft(2, '0');
    minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    return '$hours:$minutes';
  }

  getLoan() {
    if (widget.idState == 6 && seconds >= 7200) {
      return Stack(
        children: [
          BlinkingWidgets(
            second: SimpleShadow(
              child: Image.network(
                widget.imageUrl,
              ),
              opacity: 0.99, // Default: 0.5
              color: Colors.red,

              /// Default: Offset(2, 2)
              sigma: 7, // Default: 2
            ),
            first: Image.network(
              widget.imageUrl,
            ),
          ),
          Positioned(
            top: 10,
            left: 11,
            child: Container(
              height: 60,
              width: 100,
              child: Center(
                  child: BlinkingText(
                text: diferenciaTiempo,
                style: const TextStyle(
                  fontSize: 25.0,
                ),
              )),
            ),
          ),
        ],
      );
    } else if (widget.idState == 6) {
      return Stack(
        children: [
          Image.network(
            widget.imageUrl,
          ),
          Positioned(
            top: 10,
            left: 11,
            child: Container(
              height: 60,
              width: 100,
              child: Center(
                  child: BlinkingText(
                text: diferenciaTiempo,
                style: const TextStyle(
                  fontSize: 25.0,
                ),
              )),
            ),
          ),
        ],
      );
    }
    return Image.network(
      widget.imageUrl,
    );
  }

  @override
  Widget build(BuildContext context) {
    final editableProvider = Provider.of<EditableUIProvider>(context);

    return Container(
      decoration: BoxDecoration(
        border: editableProvider.editable
            ? Border.all(
                color: Colors.blue,
                width: 2.0,
              )
            : null,
      ),
      width: 120,
      child: Column(
        children: [
          Text(widget.name),
          getLoan(),
        ],
      ),
    );
  }
}

class BlinkingText extends StatefulWidget {
  final String text;
  final TextStyle style;

  BlinkingText({required this.text, required this.style});

  @override
  _BlinkingTextState createState() => _BlinkingTextState();
}

class _BlinkingTextState extends State<BlinkingText>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget? child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Text(
            widget.text,
            style: widget.style,
          ),
        );
      },
    );
  }
}
////////////////////////

// ignore: must_be_immutable
class BlinkAnimated extends StatefulWidget {
  Widget first;
  Widget second;
  Duration duration;

  BlinkAnimated(
      {super.key,
      required this.first,
      required this.second,
      this.duration = const Duration(seconds: 1)});

  @override
  // ignore: library_private_types_in_public_api
  _BlinkAnimatedState createState() => _BlinkAnimatedState();
}

class _BlinkAnimatedState extends State<BlinkAnimated> {
  bool _showInit = true;
  bool _stateShow = false;
  Timer? _timer;
  // ignore: non_constant_identifier_names
  Timer? _timer_periodic;

  @override
  void initState() {
    _timer = Timer(widget.duration, () {
      setState(() {
        _showInit = false;
        _stateShow = true;
      });
    });

    _timer_periodic = Timer.periodic(widget.duration, (t) {
      setState(() {
        _stateShow = !_stateShow;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer_periodic?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Visibility(visible: _showInit, child: widget.second),
        Visibility(
          visible: !_showInit,
          child: AnimatedCrossFade(
            duration: widget.duration,
            firstChild: widget.first,
            secondChild: widget.second,
            crossFadeState: _stateShow
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            alignment: Alignment.topCenter,
          ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class BlinkingWidgets extends StatefulWidget {
  Widget first;
  Widget second;
  Duration duration;

  BlinkingWidgets({
    super.key,
    required this.first,
    required this.second,
    this.duration = const Duration(seconds: 1),
  });

  @override
  // ignore: library_private_types_in_public_api
  _BlinkingWidgetsState createState() => _BlinkingWidgetsState();
}

class _BlinkingWidgetsState extends State<BlinkingWidgets> {
  bool _showFirstWidget = true;
  Timer? _timer;

  @override
  void initState() {
    _timer = Timer.periodic(widget.duration, (t) {
      setState(() {
        _showFirstWidget = !_showFirstWidget;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: widget.duration,
      child: _showFirstWidget ? widget.first : widget.second,
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}
