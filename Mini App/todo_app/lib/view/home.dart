import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/auth.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Column(children: [
        Container(
          height: 100,
          padding: const EdgeInsets.only(left: 18.0, bottom: 15),
          color: Colors.purple,
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.purple[200],
                radius: 40,
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Consumer<AuthProvider>(builder: (context, bloc, _) {
                return StreamBuilder<User?>(
                    stream: bloc.streamAuthStatus,
                    builder: (context, snapshot) {
                      var dataUser = snapshot.data;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Halo, ${dataUser?.displayName}",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          const Text(
                            "2 Task For today",
                            style: TextStyle(
                                color: Colors.yellow,
                                fontSize: 20,
                                fontWeight: FontWeight.w900),
                          )
                        ],
                      );
                    });
              })
            ],
          ),
        ),
        Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(top: 18, left: 16, bottom: 15),
            child: Text(
              DateFormat("EE, MMMM dd yyyy").format(DateTime.now()),
              style: const TextStyle(
                  color: Colors.purple,
                  fontWeight: FontWeight.w700,
                  fontSize: 16),
            ))
      ]),
    );
  }
}
