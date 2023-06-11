import 'package:unica_cybercoffee/services/API/api_interface.dart';
import 'package:unica_cybercoffee/services/API/production/accounts.dart';
import 'package:unica_cybercoffee/services/API/production/computer.dart';
import 'package:unica_cybercoffee/services/API/production/computer_lab.dart';
import 'package:unica_cybercoffee/services/API/production/room.dart';
import 'package:unica_cybercoffee/services/API/production/states.dart';
import 'package:unica_cybercoffee/services/API/production/students.dart';
import 'package:unica_cybercoffee/services/API/production/university_programs.dart';

class ProductionApi implements ApiInterface {
  late ProductionAccountAPI _accountsApi;
  late ProductionComputerLabAPI _computerLabApi;
  late ProductionComputerAPI _computerApi;
  late ProductionRoomAPI _roomsApi;
  late ProductionStateAPI _stateApi;
  late ProductionStudentAPI _studentApi;
  late ProductionUniversityProgramAPI _universityProgramApi;

  @override
  Future<void> initialize() {
    _accountsApi = ProductionAccountAPI();
    _computerLabApi = ProductionComputerLabAPI();
    _computerApi = ProductionComputerAPI();
    _roomsApi = ProductionRoomAPI();
    _stateApi = ProductionStateAPI();
    _studentApi = ProductionStudentAPI();
    _universityProgramApi = ProductionUniversityProgramAPI();

    return Future(() => true);
  }

  @override
  AccountAPI get accounts => _accountsApi;

  @override
  ComputerLabAPI get computerLabs => _computerLabApi;

  @override
  ComputerAPI get computers => _computerApi;

  @override
  RoomAPI get rooms => _roomsApi;

  @override
  StateAPI get states => _stateApi;

  @override
  StudentAPI get students => _studentApi;

  @override
  UniversityProgramAPI get universityProgram => _universityProgramApi;
}
