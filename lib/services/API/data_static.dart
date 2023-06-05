import 'package:unica_cybercoffee/domain/models/computer_lab.dart';

class DataStatic {
  String jwt;
  List<ComputerLab> allComputerLabs = [];

  DataStatic({this.jwt = ''});
}

DataStatic dataStatic = DataStatic();
