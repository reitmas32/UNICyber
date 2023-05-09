import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unica_cybercoffee/domain/models/computerUI.dart';
import 'package:unica_cybercoffee/domain/models/computer_room.dart';
import 'package:unica_cybercoffee/services/DB/database_static.dart';
import 'package:unica_cybercoffee/services/DB/idatabase_UI.dart';
import 'package:unica_cybercoffee/ui/providers/editable_ui_provider.dart';
import 'package:unica_cybercoffee/ui/widgets/appbar/unicaAppBar.dart';
import 'package:unica_cybercoffee/ui/widgets/custom_tab_view.dart';
import 'package:unica_cybercoffee/ui/widgets/table_computers.dart';

class ComputersPage extends StatefulWidget {
  const ComputersPage({super.key});

  @override
  ComputersPageState createState() => ComputersPageState();
}

class ComputersPageState extends State<ComputersPage> {
  //List<String> data = ['Aula 0', 'Aula 1', 'Nueva Aula'];
  int initPosition = 1;
  int lastPos = 1;
  //List<List<Position>> unica = [[], [], []];
  List<ComputerRoomUI> computerRooms = [];
  List<ComputerUI> computers = [];
  IDataBaseUI databaseUI = DataBaseStaticUI();

  _loadComputerRooms(IDataBaseUI database) async {
    List<ComputerRoomUI> computerRoomsTmp = await database.getComputerRooms();
    setState(() {
      computerRooms = computerRoomsTmp;
    });
  }

  _createComputerRooms(IDataBaseUI database) async {
    setState(() {
      //database.createComputerRooms('Aula 1');
      //database.createComputerRooms('Aula 2');
      database.createComputerRooms('Nueva Aula');
    });
  }

  _addNewComputerRoom(IDataBaseUI database, String nameNewAula) async {
    setState(
      () {
        database.deleteComputerRooms('Nueva Aula');
        database.createComputerRooms(nameNewAula);
        database.createComputerRooms('Nueva Aula');
      },
    );
  }

  _addNewComputer(IDataBaseUI database, String nameComputerRoom,
      String nameComputer) async {
    await database.createComputer(nameComputerRoom, nameComputer);
    // ignore: no_leading_underscores_for_local_identifiers
    List<ComputerUI> _computers = await database.getComputers();
    setState(() {
      computers = _computers;
    });
  }

  @override
  void initState() {
    _createComputerRooms(databaseUI);

    _loadComputerRooms(databaseUI);

    super.initState();
  }

  TextEditingController nameNewComputer = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final editableUIProvider = Provider.of<EditableUIProvider>(context);
    return Scaffold(
      appBar: const UnicaAppBar(),
      body: SafeArea(
        child: CustomTabView(
          initPosition: initPosition,
          itemCount: computerRooms.length,
          tabBuilder: (context, index) => Tab(text: computerRooms[index].name),
          pageBuilder: (context, index) {
            return TableComputers(
              computers: computers
                  .where((element) =>
                      element.idComputerRoom == computerRooms[index].id)
                  .toList(),
            );
          },
          onPositionChange: (index) {
            if (index == computerRooms.length - 1) {
              if (computerRooms.length == 1) {
                _addNewComputerRoom(databaseUI, 'Aula ${index + 1}');
                _loadComputerRooms(databaseUI);
                initPosition = computerRooms.length - 2;
              } else if (editableUIProvider.editable) {
                _addNewComputerRoom(databaseUI, 'Aula ${index + 1}');
                _loadComputerRooms(databaseUI);
                initPosition = computerRooms.length - 2;
              } else {
                initPosition = lastPos;
                return;
              }
            } else {
              initPosition = index;
            }
            lastPos = index;
          },
          onScroll: (position) {},
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //setState(() {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Datos de la Compitadora'),
              content: TextField(
                controller: nameNewComputer,
              ),
              actions: [
                InkWell(
                  borderRadius: BorderRadius.circular(10.0),
                  onTap: () {
                    _addNewComputer(databaseUI, computerRooms[lastPos].name,
                        nameNewComputer.text);
                    setState(() {
                      nameNewComputer.text = '';
                    });
                    Navigator.of(context).pop();
                  },
                  hoverColor: Theme.of(context).colorScheme.secondary,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25.0),
                      child: const Text('Añadir Computadora'),
                    ),
                  ),
                )
              ],
            ),
          );
          //unica[lastPos].add(Position(x: 0, y: 0));
          //});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
