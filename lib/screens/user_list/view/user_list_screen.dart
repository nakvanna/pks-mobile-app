import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pks_mobile/constants/app_colors.dart';
import 'package:pks_mobile/controllers/db_controller.dart';
import 'package:pks_mobile/helper/text-styles/title_text.dart';
import 'package:pks_mobile/screens/user_list/controller/user_list_controller.dart';
import 'package:pks_mobile/widgets/app_background.dart';
import 'package:pks_mobile/widgets/list_menu.dart';

class UserList extends GetView<UserListController> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return AppBackground(
        appBar: AppBar(
          centerTitle: true,
          title: TitleText(
            label: 'personal-info',
            color: kPrimaryColor,
          ),
        ),
        widget: StreamBuilder<QuerySnapshot>(
          stream: controller.usersStream(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData) {
              return Text('Have no data!');
            }
            List _listItem = snapshot.data!.docs;
            return ListView.builder(
                itemCount: _listItem.length,
                itemBuilder: (context, index) {
                  return ListMenu(
                    image: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: _listItem[index]['photoURL'] == ''
                          ? Image.asset(
                              'assets/images/png/profile-placeholder.png')
                          : Image.network(_listItem[index]['photoURL']),
                    ),
                    titleLabel: _listItem[index]['displayName'] == ''
                        ? 'username-empty'
                        : _listItem[index]['displayName'],
                    subtitleLabel: (_listItem[index]['emails'] as List).isEmpty
                        ? _listItem[index]['phoneNumbers'][0]['phoneNumber']
                        : _listItem[index]['emails'][0]['email'],
                    onTap: () {
                      print('User uid is: ${_listItem[index]['uid']}');
                    },
                    icon: Icons.arrow_forward_ios,
                  );
                });
          },
        ));
  }
}
