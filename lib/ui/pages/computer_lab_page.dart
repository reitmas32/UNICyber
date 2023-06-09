import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unica_cybercoffee/services/API/data_static.dart';
import 'package:unica_cybercoffee/ui/providers/editable_ui_provider.dart';
import 'package:unica_cybercoffee/ui/widgets/appbar/unicaAppBar.dart';
import 'package:unica_cybercoffee/ui/widgets/custom_tab_view.dart';
import 'package:unica_cybercoffee/ui/widgets/dialogs/add_computer_dialog.dart';
import 'package:unica_cybercoffee/ui/widgets/dialogs/add_room_dialog.dart';
import 'package:unica_cybercoffee/ui/widgets/expandable_fab.dart';
import 'package:unica_cybercoffee/ui/widgets/table_computers.dart';
import 'package:unica_cybercoffee/services/API/room.dart' as room;
import 'package:unica_cybercoffee/services/API/computer.dart' as computer;

class ComputersPage extends StatefulWidget {
  const ComputersPage({super.key});

  @override
  ComputersPageState createState() => ComputersPageState();
}

class ComputersPageState extends State<ComputersPage> {
  int initPosition = 0;
  int lastPos = 0;

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

  TextEditingController nameNewComputer = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final editableUIProvider = Provider.of<EditableUIProvider>(context);
    return Scaffold(
      appBar: const UnicaAppBar(),
      body: Padding(
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
    await room.getRoomsOfComputerLab(dataStatic.idComputerLab);
    setState(() {});
  }

  getComputers() async {
    await computer.getComputersOfRoom(dataStatic.idRoomCurrent);
    setState(() {});
  }
}
