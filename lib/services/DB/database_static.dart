import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:unica_cybercoffee/domain/models/user_admin.dart';
import 'package:unica_cybercoffee/tools/randomID.dart';

class DataBaseStatic {
  List<UserAdmin> usersAdmin = [];
  UserAdmin activeUserAdmin = UserAdmin(userName: '', password: '', id: '');
  //List<ComputerRoomUI> computerRooms = [];

  Future<bool> loadData() async {
    final directory = await getApplicationSupportDirectory();

    //Get Dir of File
    final collectionUsersAdmin = File('${directory.path}/users_admin.json');

    //If Not Exist Create
    if (!await collectionUsersAdmin.exists()) {
      await collectionUsersAdmin.create();
    } else {
      //Read Data
      final collectionUsersAdminJson = collectionUsersAdmin.readAsStringSync();

      //If Exist Data
      if (collectionUsersAdminJson.isNotEmpty) {
        //Load Data
        final List<dynamic> collectionUsersAdminList =
            jsonDecode(collectionUsersAdminJson);

        //Decode Data
        usersAdmin = collectionUsersAdminList
            .map(
              (json) => UserAdmin.fromJson(json),
            )
            .toList();
      } else {}
    }

    return Future(() => true);
  }

  Future<bool> saveData() async {
    final directory = await getApplicationSupportDirectory();

    //Get File
    final collectionUsersAdmin = File('${directory.path}/users_admin.json');

    //OpenFile to Write
    final sinkCollectionUsersAdmin = collectionUsersAdmin.openWrite();

    // Write File
    sinkCollectionUsersAdmin.write(
        jsonEncode(usersAdmin.map((computer) => computer.toJson()).toList()));

    //Close Data
    await sinkCollectionUsersAdmin.flush();
    await sinkCollectionUsersAdmin.close();

    return Future(() => true);
  }

  Future<UserAdmin> signupUserAdmin(String userName, String password) async {
    final randomID = randomString();
    if(userName.isEmpty || password.isEmpty){
      return Future(() => UserAdmin(id: '', userName: '', password: ''));
    }
    var userAdmin = UserAdmin(
      userName: userName,
      password: password,
      id: randomID,
    );
    usersAdmin.add(
      userAdmin,
    );
    return Future(() => userAdmin);
  }

  Future<bool> signinUserAdmin(String userName, String password) async {
    for(UserAdmin userAdmin in usersAdmin){
      if(userAdmin.userName == userName && userAdmin.password == password){
        activeUserAdmin = userAdmin;
        return true;
      }
    }

    return Future(() => false);
  }
}

DataBaseStatic databaseStatic = DataBaseStatic();
