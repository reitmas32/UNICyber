// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unica_cybercoffee/ui/providers/editable_ui_provider.dart';
import 'package:unica_cybercoffee/ui/theme_preference.dart';
import 'package:unica_cybercoffee/ui/widgets/appbar/button_image.dart';
import 'package:unica_cybercoffee/ui/widgets/appbar/theme_button.dart';
import 'package:unica_cybercoffee/ui/widgets/clock_text.dart';
import 'package:unica_cybercoffee/ui/widgets/dialogs/search_student_dialog.dart';

class UnicaAppBar extends StatelessWidget implements PreferredSizeWidget {
  const UnicaAppBar({super.key, this.route = ''});

  final String? route;

  List<Widget> getActions(double width, BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    List<Widget> _actions = [];
    final editableProvider = Provider.of<EditableUIProvider>(context);

    if (editableProvider.editable) {
      _actions.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
              backgroundColor: Colors.red),
          onPressed: () async {
            editableProvider.seteditable();
          },
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'SaveUI',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ));
    }
    if (route != '/') {
      _actions.add(Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Edit UI'),
          Switch(
            // This bool value toggles the switch.
            value: editableProvider.editable,
            activeColor: Colors.red,
            onChanged: (bool value) async {
              // This is called when the user toggles the switch.
              editableProvider.seteditable();
            },
          ),
        ],
      ));
    }

    if (route != '/') {
      _actions.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(10.0),
          hoverColor: Theme.of(context).colorScheme.secondary,
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => const SearchUserDialog(),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'Usuarios',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 22.0,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ),
      ));
    }

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
            children: getActions(MediaQuery.of(context).size.width, context))
      ],
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: const [
              ButtonImage(
                url: '/',
                imageUrl:
                    'https://raw.githubusercontent.com/reitmas32/unica_cybercoffee/main/public/assets/unica_logo.jpeg',
              ),
              SizedBox(
                width: 30,
              ),
              Text('UNICA CyberCoffee'),
            ],
          ),
          const ClockText(),
          const SizedBox(
            width: 30,
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
