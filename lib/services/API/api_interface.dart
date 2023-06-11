import 'package:unica_cybercoffee/domain/models/computer.dart';
import 'package:unica_cybercoffee/domain/models/computer_lab.dart';
import 'package:unica_cybercoffee/domain/models/room.dart';
import 'package:unica_cybercoffee/domain/models/student.dart';
import 'package:unica_cybercoffee/domain/models/user.dart';

abstract class ApiInterface {
  AccountAPI get accounts;
  ComputerLabAPI get computerLabs;
  ComputerAPI get computers;
  RoomAPI get rooms;
  StateAPI get states;
  StudentAPI get students;
  UniversityProgramAPI get universityProgram;

  //ComputerLabAPI get computerLab;
  // Otras secciones de la API

  Future<void> initialize(); // Método para inicializar la conexión
}

abstract class AccountAPI {
  Future<bool> signUp(User user);
  Future<bool> signIn(User user);
}

abstract class ComputerLabAPI {
  Future<bool> createComputerLab(ComputerLab computerLab);
  Future<bool> getComputerLabs();
  Future<bool> linkComputerLab(ComputerLab computerLab, String userName);
  Future<bool> linkComputerLabConfirm(String code, String userName);
  Future<bool> getComputerLabsOfUser();
  // Otros métodos relacionados con mensajes
}

abstract class ComputerAPI {
  Future<bool> createComputer(Computer computer);
  Future<bool> updateComputer(Computer computer);
  Future<bool> getComputersOfRoom(int idRoom);
  // Otros métodos relacionados con mensajes
}

abstract class RoomAPI {
  Future<bool> createRoom(Room computerLab);
  Future<bool> getRoomsOfComputerLab(int idComputerLab);
  // Otros métodos relacionados con mensajes
}

abstract class StateAPI {
  Future<bool> getStates();
  Future<bool> setStateOfComputer(int idComputer, int idState);
  // Otros métodos relacionados con mensajes
}

abstract class StudentAPI {
  Future<Student> getStudent(String accountNumber);
  // Otros métodos relacionados con mensajes
}

abstract class UniversityProgramAPI {
  Future<bool> getUniversityPrograms();
  // Otros métodos relacionados con mensajes
}
