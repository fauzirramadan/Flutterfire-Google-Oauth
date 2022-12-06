import 'package:flutter/material.dart';

Widget get loadingView => Center(
      child: Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(20), boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 0), // changes position of shadow
          ),
        ]),
        child: CircleAvatar(
            backgroundColor: Colors.purple[400],
            child: const Padding(
              padding: EdgeInsets.all(4),
              child: CircularProgressIndicator(
                color: Colors.purple,
              ),
            )),
      ),
    );
