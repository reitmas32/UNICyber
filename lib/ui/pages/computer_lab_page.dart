import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:unica_cybercoffee/services/API/data_static.dart';
import 'package:unica_cybercoffee/ui/providers/editable_ui_provider.dart';
import 'package:unica_cybercoffee/ui/widgets/appbar/unicaAppBar.dart';
import 'package:unica_cybercoffee/ui/widgets/bottom_navy_bar.dart';
import 'package:unica_cybercoffee/ui/widgets/custom_tab_view.dart';
import 'package:unica_cybercoffee/ui/widgets/dialogs/add_computer_dialog.dart';
import 'package:unica_cybercoffee/ui/widgets/dialogs/add_room_dialog.dart';
import 'package:unica_cybercoffee/ui/widgets/dialogs/search_student_dialog.dart';
import 'package:unica_cybercoffee/ui/widgets/expandable_fab.dart';
import 'package:unica_cybercoffee/ui/widgets/table_computers.dart';
import 'package:unica_cybercoffee/services/API/api_connection.dart';

class ComputersPage extends StatefulWidget {
  const ComputersPage({super.key});

  @override
  ComputersPageState createState() => ComputersPageState();
}

class ComputersPageState extends State<ComputersPage> {
  int initPosition = 0;
  int lastPos = 0;
  bool activeDialog = false;

  @override
  void deactivate() async {
    super.deactivate();
  }

  bool isLoading = true;

  @override
  void initState() {
    getRooms();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        isLoading = false;
      });
      if (dataStatic.roomsOfComputerLab.isNotEmpty) {
        dataStatic.idRoomCurrent = dataStatic.roomsOfComputerLab[0].id;
        getComputers();
      }
    });
    super.initState();
  }

  final _controller = SidebarXController(selectedIndex: 0, extended: true);
  final _key = GlobalKey<ScaffoldState>();

  TextEditingController nameNewComputer = TextEditingController();
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final editableUIProvider = Provider.of<EditableUIProvider>(context);
    return RawKeyboardListener(
      autofocus: true,
      focusNode: FocusNode(),
      onKey: (event) {
        if (!activeDialog && event.logicalKey == LogicalKeyboardKey.f5) {
          setState(() {
            activeDialog = true;
          });
          showDialog(
            context: context,
            builder: (context) => const SearchUserDialog(),
          ).then((value) {
            setState(() {
              activeDialog = false;
            });
          });
        }
      },
      child: Scaffold(
        key: _key,
        appBar: const UnicaAppBar(),
        drawer: ExampleSidebarX(controller: _controller),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                    )
                  : CustomTabView(
                      initPosition: initPosition,
                      itemCount: dataStatic.roomsOfComputerLab.length,
                      tabBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          dataStatic.roomsOfComputerLab[index].name,
                          style: const TextStyle(fontSize: 20.0),
                        ),
                      ),
                      pageBuilder: (context, index) {
                        //Load COmputers
                        return TableComputers(
                          computers: dataStatic.computerOfRoom,
                        );
                      },
                      onPositionChange: (index) async {
                        initPosition = index;

                        lastPos = index;

                        dataStatic.idRoomCurrent =
                            dataStatic.roomsOfComputerLab[index].id;

                        getComputers();
                      },
                      onScroll: (position) {},
                    ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: BottomNavyBar(
                selectedIndex: _currentIndex,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                backgroundColor: Theme.of(context).colorScheme.onSecondary,
                itemCornerRadius: 24,
                containerWidth: MediaQuery.of(context).size.width / 2,
                curve: Curves.easeIn,
                onItemSelected: (index) =>
                    setState(() => _currentIndex = index),
                items: <BottomNavyBarItem>[
                  BottomNavyBarItem(
                    icon: const Icon(Icons.apps),
                    title: const Text('Home'),
                    activeColor: Colors.red,
                    textAlign: TextAlign.center,
                  ),
                  BottomNavyBarItem(
                    icon: const Icon(Icons.people),
                    title: const Text('Users'),
                    activeColor: Colors.purpleAccent,
                    textAlign: TextAlign.center,
                  ),
                  BottomNavyBarItem(
                    icon: const Icon(Icons.message),
                    title: const Text(
                      'Messages test for mes teset test test ',
                    ),
                    activeColor: Colors.pink,
                    textAlign: TextAlign.center,
                  ),
                  BottomNavyBarItem(
                    icon: const Icon(Icons.settings),
                    title: const Text('Settings'),
                    activeColor: Colors.blue,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: editableUIProvider.editable
            ? ExpendableFab(
                distance: 112.0,
                children: [
                  ActionButton(
                    onPressed: () => onAddComputer(),
                    icon: Tooltip(
                      message: 'Nueva Computadora',
                      child: Icon(
                        Icons.desktop_windows,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    backgroundColor: const Color.fromARGB(255, 84, 164, 230),
                  ),
                  ActionButton(
                    onPressed: () => onAddRoom(),
                    icon: Tooltip(
                      message: 'Nueva Aula',
                      enableFeedback: true,
                      child: Icon(
                        Icons.door_back_door,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    backgroundColor: const Color.fromARGB(255, 84, 164, 230),
                  ),
                ],
              )
            : const Tooltip(
                message: 'Activa la Edición de la UI',
                child: FloatingActionButton(
                  onPressed: null,
                  backgroundColor: Colors.blueGrey,
                  child: Icon(
                    Icons.add,
                  ),
                ),
              ),
      ),
    );
  }

  onAddRoom() {
    showDialog(
      context: context,
      builder: (context) => const AddRoomDialog(),
    ).then((value) {
      getRooms();
    });
  }

  onAddComputer() {
    showDialog(
      context: context,
      builder: (context) => const AddComputerDialog(),
    ).then((value) {
      getComputers();
    });
  }

  getRooms() async {
    await api.rooms.getRoomsOfComputerLab(dataStatic.idComputerLab);
    setState(() {});
  }

  getComputers() async {
    await api.computers.getComputersOfRoom(dataStatic.idRoomCurrent);
    setState(() {});
  }
}

class ExampleSidebarX extends StatelessWidget {
  const ExampleSidebarX({
    Key? key,
    required SidebarXController controller,
  })  : _controller = controller,
        super(key: key);

  final SidebarXController _controller;

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: _controller,
      theme: SidebarXTheme(
        hoverTextStyle:
            TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 25.0),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: canvasColor,
          borderRadius: BorderRadius.circular(20),
        ),
        hoverColor: scaffoldBackgroundColor,
        textStyle:
            TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 25.0),
        selectedTextStyle:
            TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 25.0),
        itemTextPadding: const EdgeInsets.only(left: 30),
        selectedItemTextPadding: const EdgeInsets.only(left: 30),
        itemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: canvasColor),
        ),
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: actionColor.withOpacity(0.37),
          ),
          gradient: const LinearGradient(
            colors: [accentCanvasColor, canvasColor],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.28),
              blurRadius: 30,
            )
          ],
        ),
        iconTheme: IconThemeData(
          color: Colors.white.withOpacity(0.7),
          size: 20,
        ),
        selectedIconTheme: const IconThemeData(
          color: Colors.white,
          size: 20,
        ),
      ),
      extendedTheme: const SidebarXTheme(
        width: 450,
      ),
      footerDivider: divider,
      headerBuilder: (context, extended) {
        return SizedBox(
          height: 350,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.network(
                'https://raw.githubusercontent.com/reitmas32/unica_cybercoffee/main/public/assets/unica_logo.jpeg'),
          ),
        );
      },
      items: [
        SidebarXItem(
          icon: Icons.home,
          label: 'Home',
          onTap: () {
            context.go('/signin');
          },
        ),
        const SidebarXItem(
          icon: Icons.search,
          label: 'Search',
        ),
        const SidebarXItem(
          icon: Icons.people,
          label: 'People',
        ),
        const SidebarXItem(
          icon: Icons.favorite,
          label: 'Favorites',
        ),
        const SidebarXItem(
          iconWidget: FlutterLogo(size: 20),
          label: 'Flutter',
        ),
      ],
    );
  }
}

const primaryColor = Colors.blue;
const canvasColor = Color.fromARGB(255, 56, 53, 53);
const scaffoldBackgroundColor = Color(0xFF464667);
const accentCanvasColor = Color(0xFF3E3E61);
const white = Colors.white;
final actionColor = const Color(0xFF5F5FA7).withOpacity(0.6);
final divider = Divider(color: white.withOpacity(0.3), height: 1);
