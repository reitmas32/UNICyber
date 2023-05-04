import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ButtonImage extends StatelessWidget {
  const ButtonImage({
    super.key,
    required this.url,
    this.external = false,
    required this.imageUrl,
  });

  final String url;
  final bool external;
  final String imageUrl;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10.0),
      onTap: (){
        context.go(url);
      },
      hoverColor: Theme.of(context).colorScheme.secondary,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25.0),
          child: Image.network(
            imageUrl,
            height: 40.0,
          ),
        ),
      ),
    );
  }
}
