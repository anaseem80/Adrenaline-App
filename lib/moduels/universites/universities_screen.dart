import 'package:adrenaline/models/universites/universites.dart';
import 'package:adrenaline/moduels/banners/cubit/banners_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../shared/compontents/compenants.dart';
import '../../shared/compontents/imports.dart';
import '../banners/cubit/banners_cubit.dart';

class UniversitiesScreen extends StatelessWidget {
  final Universites universitiesModel;
  const UniversitiesScreen({super.key,required this.universitiesModel});

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
  create: (context) => BannersCubit()..getUniversitiesBannersData(),
  child: BlocBuilder<BannersCubit, BannersState>(
  builder: (context, state) {
    var bannersCubit = BannersCubit.get(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.transparent,title: Text("الجامعات"),),
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
              children: List.generate(
                universitiesModel.data!.length,
                    (index) => UniversitesComponent(
                  context: context,
                  universityData: universitiesModel.data![index],
                ),
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
