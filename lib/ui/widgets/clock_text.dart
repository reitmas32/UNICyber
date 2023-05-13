import 'dart:async';
import 'package:flutter/material.dart';
import "package:intl/intl.dart";

class ClockText extends StatefulWidget {
  const ClockText({
    super.key,
  });

  @override
  State<ClockText> createState() => _ClockTextState();
}

class _ClockTextState extends State<ClockText> {
  late String _timeString;

  @override
  void initState() {
    _timeString = _formatDateTime(DateTime.now());
    Timer.periodic(const Duration(seconds: 1), (Timer t) => _getTime());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _timeString,
      style: TextStyle(
        fontSize: 25.0,
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('hh:mm:ss').format(dateTime);
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    if (mounted) {
      setState(() {
        _timeString = formattedDateTime;
      });
    }
  }
}
