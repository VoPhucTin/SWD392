import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:swd_project/login.dart';
import 'package:swd_project/services/firebase_services.dart';
import 'package:swd_project/widgets/grid_product.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List imagesList = [
    {"id": 1, "image_path": "assets/images/macbook-air.png"},
    {"id": 2, "image_path": 'assets/images/14-promax.png'},
  ];

  List<Map> events = [
    {"img": "assets/images/macbook-air.png", "name": "Event 1"},
    {"img": "assets/images/14-promax.png", "name": "Event 2"},
    {
      "img": "assets/images/macbook-air.png",
      "name": "Event 1 going aroung vietnam from coc sg"
    },
    {"img": "assets/images/14-promax.png", "name": "Event 2"},
  ];

  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Home Page"),
        centerTitle: true,
      ),
      endDrawer: Drawer(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Ok"),
        ),
      ),
      body: ListView(
        children: [
          Stack(
            children: [
              InkWell(
                onTap: () {
                  print(currentIndex);
                },
                child: CarouselSlider(
                  items: imagesList
                      .map(
                        (item) => Image.asset(
                          item['image_path'],
                          fit: BoxFit.contain,
                          width: double.infinity,
                        ),
                      )
                      .toList(),
                  carouselController: carouselController,
                  options: CarouselOptions(
                    scrollPhysics: const BouncingScrollPhysics(),
                    autoPlay: true,
                    aspectRatio: 1.0,
                    viewportFraction: 1.0,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, left: 10, right: 10),
            // child: GridView.count(
            //   crossAxisCount: 2, // Số lượng cột
            //   mainAxisSpacing: 30,
            //   childAspectRatio: 1,
            //   crossAxisSpacing: 20,
            //   shrinkWrap: true,
            //   physics: NeverScrollableScrollPhysics(),
            //   children: [
            //     // ListView(
            //     //   children: imagesList.map((img) {
            //     //     return Container()
            //     //   }),
            //     // ),
            //     Container(
            //       color: Colors.green,
            //     ),
            //     Container(
            //       color: Colors.blue,
            //     ),
            //     Container(
            //       color: Colors.yellow,
            //     ),
            //     for (var i = 0; i < 10; i++)
            //       Image.network("https://picsum.photos/250?image=$i")
            //   ],
            // ),
            child: GridView.builder(
              shrinkWrap: true,
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.25),
              ),
              itemCount: events == null ? 0 : events.length,
              itemBuilder: (BuildContext context, int index) {
//                Food food = Food.fromJson(foods[index]);
                Map event = events[index];
//                print(foods);
//                print(foods.length);
                return GridEvents(
                  img: event['img'],

                  name: event['name'],
                  // rating: 5.0,
                  // raters: 23,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
