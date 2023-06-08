import 'package:unica_cybercoffee/domain/models/computer.dart';
import 'package:unica_cybercoffee/domain/models/computer_lab.dart';
import 'package:unica_cybercoffee/domain/models/room.dart';

class DataStatic {
  String jwt;
  List<ComputerLab> allComputerLabs = [];
  List<Room> roomsOfComputerLab = [];
  List<Computer> computerOfRoom = [];
  String userName;
  int idComputerLab;
  int idRoomCurrent;

  DataStatic(
      {this.jwt = '',
      this.userName = '',
      this.idComputerLab = -1,
      this.idRoomCurrent = -1});
}

DataStatic dataStatic = DataStatic();
