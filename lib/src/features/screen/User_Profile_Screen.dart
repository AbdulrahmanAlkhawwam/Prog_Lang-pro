import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path/path.dart';
import 'package:program_language_project/src/core/components/buttons/App_button.dart';
import 'package:program_language_project/src/core/components/widgets/bounded_list_view.dart';
import 'package:program_language_project/src/core/constants/colors.dart';
import 'package:program_language_project/src/core/constants/res.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColorScheme.surface,
      body: SafeArea(
          child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 22, top: 24),
                child: IconButton(
                    onPressed: () {}, icon: Icon(Icons.arrow_back_ios_new)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24, left: 260),
                child:
                    IconButton(onPressed: () {}, icon: Icon(Icons.mode_edit)),
              )
            ],
          ),
          SizedBox(
            height: 42,
          ),
          Container(
            height: 120,
            width: 120,
            child: CircleAvatar(
              radius: 100,
              child: SvgPicture.asset(Res.unknownUserLight),
            ),
          ),
          SizedBox(
            height: 42,
          ),
          Container(
            color: Colors.white,
            width: 358,
            height: 56,
            padding: EdgeInsets.only(left: 16),
            margin: EdgeInsets.symmetric(horizontal: 36),
            child: Row(
              children: [Icon(Icons.person)],
            ),
          ),
          SizedBox(height: 24),
          Container(
            color: Colors.white,
            width: 358,
            height: 56,
            padding: EdgeInsets.only(left: 16),
            margin: EdgeInsets.symmetric(horizontal: 36),
            child: Row(
              children: [Icon(Icons.person)],
            ),
          ),
          SizedBox(height: 24),
          Container(
            color: Colors.white,
            width: 358,
            height: 56,
            padding: EdgeInsets.only(left: 16),
            margin: EdgeInsets.symmetric(horizontal: 36),
            child: Row(
              children: [Icon(Icons.phone)],
            ),
          ),
          SizedBox(height: 24),
          Container(
            color: Colors.white,
            width: 360,
            height: 231,
            child: Column(
              children: [
                Row(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 25, top: 16),
                        child: Icon(
                          Icons.map,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Container(
                    height: 190,
                    width: 344,
                    color: Colors.blue,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 24,
          ),
          AppButton(isLoading: false, text: 'Logout'),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 4,
            width: 108,
            child: Divider(
              color: Color(0xFF202124),
            ),
          ),
        ],
      )),
    );
  }
}
