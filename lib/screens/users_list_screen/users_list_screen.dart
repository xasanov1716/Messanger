import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../data/api_service.dart';
import '../../models/arguments.dart';
import '../../utils/constanst/constants.dart';
import '../chateo_group/widgets/user_list.dart';
import '../connection.dart';

class UsersListScreen extends StatelessWidget {
  UsersListScreen({super.key});
  ApiService apiService = ApiService();
  User user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Connectivity().onConnectivityChanged,
      builder: (context, snapshot) {
        if (snapshot.data == ConnectivityResult.none) {
          return NoInternetScreen();
        }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: const Text(
              "Чаты",
              style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),
            ),
          ),
          body: StreamBuilder(
              stream: apiService.getUsers(user.uid),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const LinearProgressIndicator();
                var users = snapshot.data!;
                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) => UsersList(
                    users: users,
                    index: index,
                    onTap: () async {
                      var currentUser = FirebaseAuth.instance.currentUser;
                      var isEmpty = await apiService
                          .check(users[index].id + currentUser!.uid);
                      Navigator.pushNamed(
                        context,
                        Constants.privateChatScreen,
                        arguments: isEmpty
                            ?  Arguments(collectionName: currentUser.uid + users[index].id, name: users[index].name)
                            : Arguments(collectionName: users[index].id + currentUser.uid, name: users[index].name),
                      );
                    },
                  ),
                );
              }),
        );
      },
    );
  }
}
