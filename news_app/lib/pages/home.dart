import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_app/model/category_model.dart';
import 'package:news_app/model/slider_model.dart';
import 'package:news_app/services/data.dart';
import 'package:news_app/services/slider_data.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = [];
  List<SliderModel> sliderData = [];
  int activeIndex = 0;
  @override
  void initState() {
    categories = getCotegories();
    sliderData = getSliderData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: RichText(
          text: const TextSpan(
              text: "News",
              style: TextStyle(
                  fontWeight: FontWeight.w800, color: Colors.blueAccent),
              children: [
                TextSpan(
                    text: "App",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w400)),
              ]),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
              height: 70,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return CategoryTile(
                        image: categories[index].image!,
                        categoryName: categories[index].categoryName!,
                      );
                    }),
              )),
          const SizedBox(
            height: 30,
          ),
          Container(
            padding: const EdgeInsets.all(8),
            alignment: Alignment.topLeft,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Breaking News!",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                InkWell(
                  child: Text("View All",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.blueAccent)),
                )
              ],
            ),
          ),
          CarouselSlider.builder(
              itemCount: sliderData.length,
              itemBuilder: (context, index, realIndex) {
                final res = sliderData[index];
                return buildImage(res.image!, index, res.name!);
              },
              options: CarouselOptions(
                  height: 200,
                  // viewportFraction: 1,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      activeIndex = index;
                    });
                  })),
          const SizedBox(
            height: 5,
          ),
          buildIndicator(),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Trending News!",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                InkWell(
                  child: Text("View All",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.blueAccent)),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              borderRadius: BorderRadius.circular(15),
              elevation: 3,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: const Image(
                          image: AssetImage("assets/images/science.jpg"),
                          height: 150,
                          fit: BoxFit.cover,
                          width: 150,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(8),
                          width: MediaQuery.sizeOf(context).width / 1.90,
                          child: const Text("Imran Khan ran from Jail at night",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                        Container(
                          margin: const EdgeInsets.all(8),
                          width: MediaQuery.sizeOf(context).width / 1.90,
                          child: const Text("Imran Khan ran from Jail at night",
                              style: TextStyle(
                                  fontWeight: FontWeight.w100,
                                  color: Color.fromARGB(206, 0, 0, 0),
                                  fontSize: 13)),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              borderRadius: BorderRadius.circular(15),
              elevation: 3,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: const Image(
                          image: AssetImage("assets/images/science.jpg"),
                          height: 150,
                          fit: BoxFit.cover,
                          width: 150,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(8),
                          width: MediaQuery.sizeOf(context).width / 1.90,
                          child: const Text("Imran Khan ran from Jail at night",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                        Container(
                          margin: const EdgeInsets.all(8),
                          width: MediaQuery.sizeOf(context).width / 1.90,
                          child: const Text("Imran Khan ran from Jail at night",
                              style: TextStyle(
                                  fontWeight: FontWeight.w100,
                                  color: Color.fromARGB(206, 0, 0, 0),
                                  fontSize: 13)),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      )),
    );
  }

  Widget buildImage(String imageUrl, int index, String name) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 7.0),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image(
                fit: BoxFit.cover,
                height: 200,
                width: MediaQuery.sizeOf(context).width,
                image: AssetImage(
                  imageUrl,
                )),
          ),
          Container(
            margin: const EdgeInsets.only(top: 150),
            width: MediaQuery.sizeOf(context).width,
            height: 250,
            decoration: const BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(6),
                  bottomRight: Radius.circular(6),
                )),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                name,
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: sliderData.length,
        effect: const WormEffect(),
      );
}

class CategoryTile extends StatelessWidget {
  final String image;
  final String categoryName;
  const CategoryTile(
      {super.key, required this.image, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image(
                fit: BoxFit.fill,
                width: 120,
                height: 70,
                image: AssetImage(
                  image,
                )),
          ),
          Container(
            width: 120,
            height: 70,
            decoration: BoxDecoration(
                color: Colors.black26, borderRadius: BorderRadius.circular(6)),
            child: Center(
              child: Text(
                categoryName,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ),
          )
        ],
      ),
    );
  }
}
