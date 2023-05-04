// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:unica_cybercoffee/ui/theme_preference.dart';
import 'package:unica_cybercoffee/ui/widgets/appbar/button_app_bar.dart';
import 'package:unica_cybercoffee/ui/widgets/appbar/button_icon.dart';
import 'package:unica_cybercoffee/ui/widgets/appbar/button_image.dart';
import 'package:unica_cybercoffee/ui/widgets/appbar/theme_button.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class UnicaAppBar extends StatelessWidget implements PreferredSizeWidget {
  const UnicaAppBar({
    super.key,
  });

  List<Widget> getActions(double width,BuildContext context, String lable) {
    // ignore: no_leading_underscores_for_local_identifiers
    List<Widget> _actions = [];

    _actions.add(Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(10.0),
        hoverColor: Theme.of(context).colorScheme.secondary,
        // ignore: avoid_print
        onTap: () {
          //context.go('/${lable.toLowerCase()}');
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            lable,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 22.0,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
    ));

    _actions.add(const SizedBox(
      width: 40.0,
    ));
    _actions.add(
      const ThemeButton(
        nameTheme: ThemePreference.LIGHT,
      ),
    );
    _actions.add(
      const ThemeButton(
        nameTheme: ThemePreference.DARK,
      ),
    );
    _actions.add(
      const SizedBox(
        width: 40.0,
      ),
    );

    return _actions;
  }

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      actions: [
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: getActions(MediaQuery.of(context).size.width, context, 'Usuarios'))
      ],
      title: Row(
        children: const [
          ButtonImage(
            url: '/',
            imageUrl:
                'https://raw.githubusercontent.com/reitmas32/unica_cybercoffee/main/public/assets/unica_logo.jpeg',
          ),
          //ButtonAppBar(lable: 'About'),
        ],
      ),
      toolbarHeight: MediaQuery.of(context).size.height / 12,
      //toolbarHeight: MediaQuery.of(context).size.height / 12,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100.0);
}
