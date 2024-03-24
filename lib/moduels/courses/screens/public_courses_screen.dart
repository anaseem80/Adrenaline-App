import 'package:adrenaline/models/universites/universites.dart';
import 'package:adrenaline/moduels/banners/cubit/banners_state.dart';
import 'package:adrenaline/moduels/courses/models/course_model.dart';
import 'package:adrenaline/shared/compontents/imports.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../banners/cubit/banners_cubit.dart';
import 'course_screen/course_screen.dart';



class PublicCoursesScreen extends StatelessWidget {
  final CourseModel publicCoursesModel;
  const PublicCoursesScreen({super.key,required, required this.publicCoursesModel});

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context) => BannersCubit()..getUniversitiesBannersData(),
      child: BlocBuilder<BannersCubit, BannersState>(
        builder: (context, state) {
          var bannersCubit = BannersCubit.get(context);
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(backgroundColor: Colors.transparent,title: Text("الكورسات العامة"),),
              body: Padding(
                padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                child: Column(
                  children: [
                    CarouselSlider.builder(
                      itemCount: bannersCubit.universitiesBannersModel!.banners!.length,
                      options: CarouselOptions(
                        height: 230,
                        aspectRatio: 16/9,
                        viewportFraction: 0.8,
                        initialPage: 0,
                        autoPlay: true,
                        reverse: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                      ),
                      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                          InkWell(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(builder: (context) => CourseScreen(
                              //       courseId: coursesCubit.courses[itemIndex]['id'],
                              //     ))
                              // );
                            },
                            child: Stack(
                              children: [
                                Container(
                                    width: double.infinity,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15.0),
                                      child: CachedNetworkImage(
                                        imageUrl: bannersCubit.universitiesBannersModel!.banners![itemIndex].image!,
                                        imageBuilder: (context, imageProvider) => Container(
                                          height: 200,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.fill,
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

                                    )
                                ),
                                Container(
                                  padding: EdgeInsets.all(7.0),
                                  width: 60.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    color: Colors.green,
                                  ),
                                  child: Text(
                                    "Top",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                    ),
                    SizedBox(height: 20,),
                    GridView.count(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: (MediaQuery.of(context).orientation == Orientation.landscape) ? 4 : 2,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                      childAspectRatio: 0.62,
                      children: List.generate(
                        publicCoursesModel.data!.length,
                            (index) {
                          var course=publicCoursesModel.data![index];
                          return Container(
                              width: 200.0,
                              child: Material(
                                borderRadius: BorderRadius.circular(15.0),
                                color: lowWhiteColor,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(20.0),
                                  splashColor: Colors.blue.withAlpha(30),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => CourseScreen(
                                        courseId: course.id,
                                      )),
                                    );
                                  },
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(20.0),
                                        child: CachedNetworkImage(
                                          imageUrl: course.image!,
                                          imageBuilder: (context, imageProvider) => Container(
                                            height: 180,
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
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              child: Text(
                                                course.name!,
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
                                              child: course.owner!=null ? Row(
                                                children: [
                                                  CircleAvatar(
                                                    backgroundImage: NetworkImage(course.owner!.profilePhotoPath!),
                                                    radius: 10.0,
                                                  ),
                                                  SizedBox(
                                                    width: 5.0,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      "By " + course.owner!.firstname! + " " + course.owner!.lastname!,
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
                                                  initialRating: double.parse(course.rate!),
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
                                                  '( '+course.rate!+'.0 )',
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
                                                course.price != null ? course.price.toString() + " EGP" : "Free",
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
                            );},
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
