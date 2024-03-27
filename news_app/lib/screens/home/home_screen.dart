import 'package:news_app/data/models/get_news_model.dart';
import 'package:news_app/data/repositories/get_news_repo.dart';
import 'package:news_app/screens/detail/news_detail.dart';
import 'package:news_app/screens/home/components/widget_bottom_navigations_bar.dart';
import 'package:news_app/screens/home/components/widget_last_news.dart';
import 'package:news_app/screens/notification/notifications.dart';
import 'package:news_app/screens/search/search.dart';
import 'package:news_app/screens/widgets/categories.dart';
import 'package:news_app/screens/widgets/list.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GetNewsModel? myNews;

  @override
  void initState() {
    super.initState();
    getUpdates();
  }

  getUpdates() async {
    setState(() {
      myNews = null;
    });
    myNews = await GetNewsRepo().getNews();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await getUpdates();
        },
        child: SafeArea(
          child: myNews == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Stack(children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xffF0F1FA)),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(55))),
                                    enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xffF0F1FA)),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(55))),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const SearchScreen()),
                                          );
                                        },
                                        icon: const Icon(Icons.search)),
                                    border: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xffF0F1FA)),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(55))),
                                    hintStyle: const TextStyle(
                                      color: Color(0xff818181),
                                      fontFamily: 'NunitoSans',
                                    ),
                                    hintText: 'Dogecoin to the Moon...',
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const NotificationScreen()),
                                  );
                                },
                                child: ClipOval(
                                  child: Container(
                                    width: 33,
                                    height: 32,
                                    decoration: const BoxDecoration(
                                        color: Color(0xffFF3A44)),
                                    child: Stack(
                                      children: [
                                        Center(
                                          child: Image.asset(
                                            'assets/notification.png',
                                            scale: 0.8,
                                          ),
                                        ),
                                        Positioned(
                                          top: 6,
                                          left: 19,
                                          child: Container(
                                            width: 5.88,
                                            height: 5.65,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                              color: const Color(0xffFFE600),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Latest News',
                                style: TextStyle(
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18),
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      myNews = await GetNewsRepo().getNews();
                                    },
                                    child: const Text(
                                      'See All',
                                      style: TextStyle(
                                          fontFamily: 'NunitoSans',
                                          color: Color(0xff0080FF),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Icon(
                                    Icons.arrow_forward,
                                    color: Color(0xff0080FF),
                                  )
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                for (int i = 0;
                                    i < myNews!.articles.length;
                                    i++)
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: WidgetLastNew(
                                      image:
                                          myNews!.articles[i].urlToImage ?? "",
                                      text1: myNews!.articles[i].title,
                                      text2:
                                          myNews!.articles[i].description ?? "",
                                      opacity: 0.9,
                                      fun: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const NewsDetailScreen()),
                                        );
                                      },
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                WidgetCategory(
                                  text: 'Healthy',
                                  color: Color(0xffFF3A44),
                                  textColor: Color(0xffFFFFFF),
                                  width: 75,
                                  height: 32,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                WidgetCategory(
                                  text: 'Technology',
                                  color: Colors.transparent,
                                  textColor: Color(0xff2E0505),
                                  width: 95,
                                  height: 32,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                WidgetCategory(
                                  text: 'Finance',
                                  color: Colors.transparent,
                                  textColor: Color(0xff2E0505),
                                  width: 75,
                                  height: 32,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                WidgetCategory(
                                  text: 'Arts',
                                  color: Colors.transparent,
                                  textColor: Color(0xff2E0505),
                                  width: 56,
                                  height: 32,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                WidgetCategory(
                                  text: 'Sports',
                                  color: Colors.transparent,
                                  textColor: Color(0xff2E0505),
                                  width: 69,
                                  height: 32,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const WidgetListInfo(
                              image: 'assets/image1_home.jpeg',
                              text1: '5 things to know about the '
                                  'conundrum'
                                  ' of \nlupus',
                              text2: 'Matt Villano',
                              text3: 'Sunday, 9 May 2021',
                              height: 40,
                              width: 139),
                          const SizedBox(
                            height: 10,
                          ),
                          const WidgetListInfo(
                            image: 'assets/image2_home.jpeg',
                            text1: '4 ways families can ease anxiety together',
                            text2: 'Zain Korsgaard',
                            text3: 'Sunday, 9 May 2021',
                            height: 60,
                            width: 122,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const WidgetListInfo(
                              image: 'assets/image3_home.png',
                              text1: 'What to do if you'
                                  're planning or attending a \nwedding during the pandemic'
                                  '',
                              text2: 'Matt Villano',
                              text3: 'Sunday, 9 May 2021',
                              height: 40,
                              width: 139),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        width: 289,
                        height: 66,
                        decoration: const BoxDecoration(
                            color: Color(0xffFFFFFF),
                            borderRadius: BorderRadius.all(
                              Radius.circular(32),
                            )),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: 32,
                              height: 4,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  color: Color(0xffE0E0E0)),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                WidgetBottomNavigationBar(
                                  image: 'assets/homeIcon.png',
                                  text: 'Home',
                                  textColor: Color(0xff2E0505),
                                ),
                                WidgetBottomNavigationBar(
                                  image: 'assets/favoriteIcon.png',
                                  text: 'Favorite',
                                  textColor: Color(0xffA6A6A6),
                                ),
                                WidgetBottomNavigationBar(
                                  image: 'assets/profileIcon.png',
                                  text: 'Profile',
                                  textColor: Color(0xffA6A6A6),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ]),
                ),
        ),
      ),
    );
  }
}