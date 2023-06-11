import 'package:unica_cybercoffee/domain/models/computer.dart';
import 'package:unica_cybercoffee/domain/models/computer_lab.dart';
import 'package:unica_cybercoffee/domain/models/room.dart';
import 'package:unica_cybercoffee/domain/models/state.dart';
import 'package:unica_cybercoffee/domain/models/university_program.dart';

class DataStatic {
  String jwt;
  List<ComputerLab> allComputerLabs = [];
  List<Room> roomsOfComputerLab = [];
  List<Computer> computerOfRoom = [];
  List<StateComputer> states = [];
  List<UniversityProgram> universityPrograms = [];
  String userName;
  int idComputerLab;
  int idRoomCurrent;

  DataStatic({
    this.jwt = '',
    this.userName = '',
    this.idComputerLab = -1,
    this.idRoomCurrent = -1,
  });
}

DataStatic dataStatic = DataStatic();
