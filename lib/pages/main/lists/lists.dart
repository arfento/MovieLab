import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:movie_lab/pages/main/lists/sections/navbar.dart';
import 'package:movie_lab/pages/userlist_body.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: UserListsNavbar(),
          body: const TabBarView(
            physics: BouncingScrollPhysics(),
            children: [
              UserlistBody(listName: "watchlist"),
              UserlistBody(listName: "history"),
              UserlistBody(listName: "collection")
            ],
          ),
        ));
  }
}
