import 'package:unica_cybercoffee/domain/models/computer_lab.dart';

class DataStatic {
  String jwt;
  List<ComputerLab> allComputerLabs = [];
  String userName;

  DataStatic({this.jwt = '', this.userName = ''});
}

DataStatic dataStatic = DataStatic();
