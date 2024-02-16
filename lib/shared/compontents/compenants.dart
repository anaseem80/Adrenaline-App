import 'package:arabmedicine/layout/cubit/home_layout_cubit.dart';
import 'package:arabmedicine/moduels/courses/course_screen/course_screen.dart';
import 'package:arabmedicine/moduels/courses/courses_screen/courses_screen.dart';
import 'package:arabmedicine/moduels/instructors/instructor_view/instructor_view.dart';
import 'package:arabmedicine/moduels/instructors/instructors_module/instructors_module.dart';
import 'package:arabmedicine/shared/app_cubit.dart';
import 'package:arabmedicine/shared/compontents/conestans.dart';
import 'package:arabmedicine/shared/styles/styles.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:carousel_slider/carousel_slider.dart';

Widget TextFormFieldMain ({
  /*required String iconName,*/
  final void Function(String?)? onSubmit,
  final void Function()? obscureShow,
  final void Function()? onTap,
  final IconData? suffix,
  required IconData prefix,
  context,
  required validator,
  required String text,
  required TextEditingController controller,
  required TextInputType type,
  required String error,
  bool obscureText = false,
}) => TextFormField(
  controller: controller,
  obscureText: obscureText,
  onTap: onTap,
  style: Theme.of(context).textTheme.bodyText1,
  decoration: InputDecoration(
    labelText: text,
    labelStyle: Theme.of(context).textTheme.bodyText1,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(width: .8, color: whiteColor),
      borderRadius: BorderRadius.circular(30)
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(width: 60, color: Colors.greenAccent),
      borderRadius: BorderRadius.circular(30)
    ),
    prefixIcon: Icon(
      prefix,
      color: whiteColor,
    ),
    suffixIcon: IconButton(
        onPressed: obscureShow,
        icon: Icon(
          suffix,
          color: whiteColor,
        )
    )
  ),
  keyboardType: type,
  onFieldSubmitted: onSubmit,
  validator: validator,
);

Widget DefaultButton ({
  double width = double.infinity,
  Color background = Colors.teal,
  Color textColor = Colors.white,
  double radius = 30.0,
  required String text,
  context,
  required Function function,
}) => Container(
  height: 50.0,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
    color: background,
  ),
  width: width,
  child: MaterialButton(
    child: Text(
      text,
      style: TextStyle(
        color: textColor,
        fontWeight: FontWeight.bold,
      ),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius),
    ),
    height: 50.0,
    onPressed: () => function(),
  ),
);

Widget CourseItem({
  required course,
  required context,
  }) => Container(
    width: 230.0,
    child: Material(
      borderRadius: BorderRadius.circular(15.0),
      color: lowWhiteColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(20.0),
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => course_screen(
              courseId: course['id'],
            )),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: CachedNetworkImage(
                imageUrl: course["image"],
                imageBuilder: (context, imageProvider) => Container(
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context,url) => Container(
                  height: 200,
                  child: Container(
                    height: 15,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ),
                errorWidget: (context,url,error) => Container(
                  height: 200,
                  child: Container(
                    height: 15,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      course["name"],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: font_size,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    child: course.containsKey('owner') ? Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(course['owner']['profile_photo_path']),
                          radius: 10.0,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Expanded(
                          child: Text(
                            "By " + course['owner']['firstname'] + " " + course['owner']['lastname'],
                            style: Theme.of(context).textTheme.bodyText1,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ) : Container(),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: [
                      RatingBar.builder(
                        initialRating: double.parse(course['rate']),
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        ignoreGestures: true,
                        itemSize: font_size!,
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        '( '+course['rate']+'.0 )',
                        style: TextStyle(
                          color: whiteColor,
                          fontSize: 11
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: HexColor("#124baf"),
                      borderRadius: BorderRadius.circular(10.0)
                    ),
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      course["price"] != null ? course["price"] + " EGP" : "Free",
                      style: TextStyle(
                        fontSize: price_size,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
),
      ),
    ),
  );

Widget instructors(instructor, context, dynamic moduleName) => Material(
  borderRadius: BorderRadius.circular(15.0),
  color: lowWhiteColor,
  child: InkWell(
    onTap: () {
      var instructorId = instructor['id'].toString();
      if(instructor.containsKey('pivot')){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Courses_screen(
            moduleId: int.parse(instructor['pivot']['module_id']),
            instructorId: instructorId,
            moduleName: moduleName,
            instructorFirstName: instructor['firstname'],
            instructorLastName: instructor['lastname'],
          )),
        );
      }else{
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => InstructorView(
            instructorId: instructor['id'],
            instructorFirstName: instructor['firstname'],
            instructorLastName: instructor['lastname'],
          )),
        );
      }
    },
    customBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // instructor['profile_photo_path']
          CircleAvatar(
            backgroundImage: NetworkImage(instructor['profile_photo_path']),
            radius: 30.0,
          ),
          SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  instructor['firstname'] + " " + instructor['lastname'],
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "Faculty, Lecturer",
                  style: Theme.of(context).textTheme.bodyText1,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              var instructorId = instructor['id'].toString();
              if(instructor.containsKey('pivot')){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Courses_screen(
                    moduleId: int.parse(instructor['pivot']['module_id']),
                    instructorId: instructorId,
                    moduleName: moduleName,
                    instructorFirstName: instructor['firstname'],
                    instructorLastName: instructor['lastname'],
                  )),
                );
              }else{
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InstructorView(
                    instructorId: instructor['id'],
                    instructorFirstName: instructor['firstname'],
                    instructorLastName: instructor['lastname'],
                  )),
                );
              }
            },
            icon: Icon(
              Icons.arrow_circle_right_rounded,
              color: whiteColor,
            ),
          )
        ],
      ),
    ),
  ),
);

Widget modules({
  required module,
  required context
}) => SizedBox(
  width: MediaQuery.of(context).size.width * 0.85,
  child: Material(
    borderRadius: BorderRadius.circular(15.0),
    color: lowWhiteColor,
    child: InkWell(
      borderRadius: BorderRadius.circular(20.0),
      splashColor: Colors.blue.withAlpha(30),
      onTap: () {
        if(module.containsKey("instructors")){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => instructorsModule(
              moduleName: module['name'],
              moduleInstructors: module['instructors'],
            ))
          );
        }else{
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Courses_screen(
              moduleId: module['id'],
              createdBy: module['created_by'],
              instructorId: module['instructorId'],
              moduleName: module['name'],
            )),
          );
        }
      },
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: CachedNetworkImage(
              imageUrl: module["image"],
              imageBuilder: (context, imageProvider) => Container(
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context,url) => Container(
                height: 200,
                child: Container(
                  height: 15,
                  child: Center(child: CircularProgressIndicator()),
                ),
              ),
              errorWidget: (context,url,error) => Container(
                height: 200,
                child: Container(
                  height: 15,
                  child: Center(child: CircularProgressIndicator()),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  module['name'],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  child: module['instructors'] != null ? ListView.separated(
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) => Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(module['instructors'][index]['profile_photo_path']),
                                  radius: 20.0,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  module['instructors'][index]['firstname'] + " " + module['instructors'][index]['lastname'],
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: HexColor("#124baf"),
                                  borderRadius: BorderRadius.circular(10.0)
                              ),
                              padding: EdgeInsets.all(8.0),
                              child: module['instructors'][index]['module_price'] != null ? Text(
                                module['instructors'][index]['module_price'] + ".00 EGP",
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ) : Container(),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  separatorBuilder: (context,index) => SizedBox(
                    height: 15.0,
                  ),
                  itemCount: module['instructors']!.length,
                ) : Container(),
                )
              ],
            ),
          ),
        ],
      ),
    ),
  ),
);

Widget screen_items_length({
  required length,
  required title,
  required context,
}) => Column(
  children: [
    SizedBox(
      height: 15.0,
    ),
    Text(
      "يتم عرض " + length.toString()  + " من " + title,
      style: TextStyle(
        color: whiteColor,
        fontFamily: 'Almarai',
        fontSize: font_size,
        fontWeight: FontWeight.bold,
      ),
    ),
    SizedBox(
      height: 15.0,
    ),
  ],
);


Widget ErrorIntrnet() => Center(
  child: Text(
    "حدث خطأ غير متوقع رجاء التحقق من اتصال الانترنت ",
    style: TextStyle(
      color: whiteColor,
      fontSize: 17,
    ),
    textAlign: TextAlign.center,
  ),
);


Widget ExpansionTileWidget({
  required section,
  required lesson,
  required lessonsCount,
  required context,
}) => ExpansionTile(
  textColor: whiteColor,
  collapsedTextColor: whiteColor,
  iconColor: whiteColor,
  collapsedIconColor: whiteColor,
  onExpansionChanged: (test) {
    lesson = section['lesson'];
  },
  title: Text(
    section['section_name'],
    style: TextStyle(
      fontSize: main_size,
    ),
  ),
  children: <Widget>[
    ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index){
          return ListTile(
              title: Row(
                children: [
                  Text(
                    (1 + index).toString(),
                    style: TextStyle(
                      color: whiteColor,
                    ),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Expanded(
                    child: Text(
                      lesson[index]['lesson_name'],
                      style: TextStyle(
                        color: whiteColor,
                        fontSize: main_size,
                      ),
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              )
          );
        },
        separatorBuilder: (context, index) => SizedBox(
          height: 15.0,
        ),
        itemCount: lessonsCount!
    )
  ],
);

Widget UserSettingsWidget({
  required IconData,
  required textSetting,
  required Function()? onTap,
  required context,
  final iconColor,
}) => Material(
  color: lowWhiteColor,
  borderRadius: BorderRadius.circular(15.0),
  child: InkWell(
    borderRadius: BorderRadius.circular(15.0),
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(19.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            IconData,
            color: iconColor,
          ),
          Row(
            children: [
              SizedBox(
                width: 15.0,
              ),
              Text(
                textSetting,
                style: Theme.of(context).textTheme.headline3,
              ),
            ],
          ),
        ],
      ),
    ),
  ),
);

Widget AppSettings({
  required context,
  required title,
  required icon,
  required color,
  required Function()? onTap,
}) => Material(
  color: lowWhiteColor,
  borderRadius: BorderRadius.circular(15.0),
  child: Container(
    padding: EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: onTap,
            icon: Icon(
              icon,
              color: color,
            )
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.headline3,
        ),
      ],
    ),
  ),
);

void showToast({
  required message,
  required Color color,
}) => Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: color,
    textColor: Colors.white,
    fontSize: 16.0
);