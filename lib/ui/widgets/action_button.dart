import 'package:flutter/material.dart';

class ActionButton extends StatefulWidget {
  const ActionButton({super.key, this.onTap, required this.lable});

  final void Function()? onTap;
  final String lable;

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  bool isInit = false;
  late Color colorText;
  @override
  Widget build(BuildContext context) {
    if (!isInit) {
      setState(() {
        colorText = Theme.of(context).colorScheme.onPrimary;
        isInit = true;
      });
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        elevation: 10.0,
        borderRadius: BorderRadius.circular(10.0),
        shadowColor: Colors.blueAccent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10.0),
          onTap: widget.onTap,
          onHover: (value) {
            setState(() {
              if (value) {
                colorText = Colors.blue;
              } else {
                colorText = Theme.of(context).colorScheme.onPrimary;
              }
            });
          },
          hoverColor: Theme.of(context).colorScheme.secondary,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              widget.lable,
              style: TextStyle(fontSize: 20.0, color: colorText),
            ),
          ),
        ),
      ),
    );
  }
}
