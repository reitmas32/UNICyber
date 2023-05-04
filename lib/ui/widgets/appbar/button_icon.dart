import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ButtonIcon extends StatelessWidget {
  const ButtonIcon({
    super.key,
    required this.url,
    this.external = false,
    required this.iconData,
  });

  final String url;
  final bool external;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10.0),
      onTap:(){
        context.go(url);
      },
      hoverColor: Theme.of(context).colorScheme.secondary,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25.0),
          child: Icon(
            iconData,
            size: 35.0,
          ),
        ),
      ),
    );
  }
}