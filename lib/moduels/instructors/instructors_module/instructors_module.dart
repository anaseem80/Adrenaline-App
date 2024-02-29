import 'package:adrenaline/moduels/instructors/instructors.dart';
import 'package:adrenaline/shared/compontents/compenants.dart';
import 'package:flutter/material.dart';

class instructorsModule extends StatelessWidget {

  String? moduleName;
  List<dynamic>? moduleInstructors = [];
  instructorsModule({
    this.moduleName,
    this.moduleInstructors,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(moduleName.toString()),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            screen_items_length(
              title: "الاقسام",
              length:  moduleInstructors!.length, context: context,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: 7.0,
                  left: 7.0
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => instructors(moduleInstructors![index], context,moduleName),
                separatorBuilder: (context, index) => SizedBox(
                  height: 15.0,
                ),
                itemCount: moduleInstructors!.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
