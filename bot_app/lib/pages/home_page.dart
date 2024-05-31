import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new/pages/chat_page.dart';
// import 'package:flutter_new/pages/teacher_page.dart';
import 'package:flutter_new/pages/topics_page.dart';
import 'package:flutter_new/project/routes/app_route_constants.dart';
import 'package:flutter_new/providers/announcement_provider.dart';
import 'package:flutter_new/providers/user_provider.dart';
import 'package:flutter_new/services/common_service.dart';
import 'package:flutter_new/services/subject_service.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stories_for_flutter/stories_for_flutter.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userInfo;
  List departments = [
    "BSc CS",
    "BSc IT",
    "B.Com",
    "BBA",
    "BA.Malayalam",
    "BA.English"
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      userInfo = Provider.of<UserProvider>(context, listen: false).getUserInfo;
    });
    print(userInfo);
    Provider.of<AnnouncementProvider>(context, listen: false)
        .getAllAnnouncements();
    // getAllAnnouncements();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //     title: const Text("Home"),
        //     automaticallyImplyLeading: false,
        //     centerTitle: true,
        //     backgroundColor: Color.fromARGB(255, 70, 192, 151)),
        body: Container(
          color: const Color(0xffbe74ff),
          width: double.infinity,
          child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 20),
                Consumer<UserProvider>(
                  builder: (context, provider, child) {
                    return Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        provider.getUserInfo['userRole']
                                    .toString()
                                    .toLowerCase() ==
                                "teacher"
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      height: 60,
                                      width: 60,
                                      child: FloatingActionButton(
                                        shape: const CircleBorder(
                                            side: BorderSide()),
                                        backgroundColor:
                                            const Color(0xffeecfff),
                                        onPressed: () {
                                          GoRouter.of(context).pushNamed(
                                              MyAppRouteConstant
                                                  .teacher_pageRouteName);
                                          // MaterialPageRoute(
                                          //   builder: (context) => const TeacherPage(),
                                          // ),
                                        },
                                        child: const Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text("Add")
                                  ],
                                ),
                              )
                            : const SizedBox(),
                        SizedBox(width: 5),
                        Consumer<AnnouncementProvider>(
                          builder: (context, provider, child) {
                            return Expanded(
                                child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: provider.announcements.map((story) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => AnnouncementViewer(
                                              provider
                                                  .getAllAnnouncementsFromIndex(
                                                      story),
                                              provider.announcements
                                                  .indexOf(story)),
                                        ),
                                      );
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.green,
                                          radius: 33,
                                          child: CircleAvatar(
                                            // foregroundColor: Colors.red,
                                            radius: 30,
                                            // child: Text(story['userName']),
                                            backgroundImage: NetworkImage(
                                                story['storyImagePath']),
                                          ),
                                        ),
                                        SizedBox(
                                            width: 100,
                                            child: Text(
                                              story['userName'],
                                              maxLines: 1,
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                            ))
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ));
                          },
                        ),
                      ],
                    );
                  },
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFFeecfff),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 25),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'DEPARTMENTS',
                                style: TextStyle(
                                  letterSpacing: 1,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    logout();
                                  },
                                  icon: Icon(
                                    Icons.logout_outlined,
                                    color: Colors.red,
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: ListView.builder(
                              itemCount: departments.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      GoRouter.of(context).pushNamed(
                                          MyAppRouteConstant
                                              .topics_pageRouteName,
                                          pathParameters: {
                                            "department": departments[index]
                                          });
                                    },
                                    child: SizedBox(
                                      height: 65,
                                      child: Card(
                                        child: ListTile(
                                          leading: const Icon(Icons.album),
                                          trailing: const Icon(
                                              CupertinoIcons.forward),
                                          title: Padding(
                                            padding: const EdgeInsets.all(7.0),
                                            child: Text(
                                              departments[index],
                                              style: const TextStyle(
                                                // letterSpacing: 1,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xffb152e8),
          onPressed: () {
            GoRouter.of(context)
                .pushNamed(MyAppRouteConstant.chat_pageRouteName);
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => const ChatPage(),
            //   ),
            // );
          },
          child: const Icon(
            CupertinoIcons.chat_bubble_2_fill,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  deleteAnnouncement(story) async {
    var response = await SubjectService().deleteAnnouncement(story['id']);
    CommonService().handleResponseMessage(context, response);
  }

  logout() async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    userProvider.removeUserInfo();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    GoRouter.of(context).goNamed(MyAppRouteConstant.login_pageRouteName);
  }
}

class AnnouncementViewer extends StatefulWidget {
  List imageList;
  int _currentIndex;
  AnnouncementViewer(this.imageList, this._currentIndex) {}
  @override
  State<AnnouncementViewer> createState() => _AnnouncementViewerState();
}

class _AnnouncementViewerState extends State<AnnouncementViewer> {
  List imageList = [];
  CarouselController carouselController = CarouselController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imageList = widget.imageList;
    _currentIndex = widget._currentIndex;
    print("initial index " + widget._currentIndex.toString());
  }

  int _currentIndex = 0;
  bool isDeleting = false;
  deleteAnnouncement() async {
    AnnouncementProvider provider =
        Provider.of<AnnouncementProvider>(context, listen: false);
    setState(() {
      isDeleting = true;
    });
    var response = await SubjectService()
        .deleteAnnouncement(provider.announcements[_currentIndex]['id']);
    provider.removeAnnouncement(_currentIndex);
    GoRouter.of(context).pop(context);
    setState(() {
      isDeleting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    AnnouncementProvider provider =
                          Provider.of<AnnouncementProvider>(context,
                              listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(provider.announcements[_currentIndex]['userName']),
        backgroundColor: const Color(0xffbe74ff),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {
                  deleteAnnouncement();
                },
                iconSize: 30,
                icon: Icon(Icons.delete_outline_outlined)),
          )
        ],
      ),
      body: !isDeleting
          ? Builder(
              builder: (context) {
                final double height = MediaQuery.of(context).size.height;
                return CarouselSlider(
                  options: CarouselOptions(
                    height: height,
                    viewportFraction: 1.0,
                    enlargeCenterPage: false,
                    enableInfiniteScroll: false,
                    onPageChanged: (index, reason) {
                      _currentIndex = index;
                      AnnouncementProvider provider =
                          Provider.of<AnnouncementProvider>(context,
                              listen: false);
                      _currentIndex = provider.announcements.indexOf(imageList[index]);
                      print(index);
                      setState(() {});
                    },
                    // autoPlay: false,
                  ),
                  items: imageList
                      .map((item) => Scaffold(
                            appBar: AppBar(automaticallyImplyLeading: false),
                            body: Container(
                              child: Center(
                                  child: Image.network(
                                item['storyImagePath'],
                                fit: BoxFit.cover,
                                height: height,
                              )),
                            ),
                          ))
                      .toList(),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
// backgroundColor: Colors.white,
// appBar: AppBar(
//   title: Text("Home"),
//   backgroundColor: Color.fromARGB(255, 70, 192, 151),
// ),
// body: const SafeArea(
//       //   child: Center(
//       //     child: Column(
//       //       children: [
//       //         SizedBox(
//       //           height: 20,
//       //         ),
//       // Text("Topics",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,fontFamily: AutofillHints.countryCode),)
//       //       ],
//       //     ),
//       //   ),
//       // ),
//       floatingActionButton: Wrap(
//         direction: Axis.vertical,
//         children: <Widget>[
//           userType == "Teacher"
//               ? Container(
//                   child: FloatingActionButton(
//                     backgroundColor: Color.fromARGB(255, 70, 192, 151),
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => TeacherPage(),
//                         ),
//                       );
//                     },
//                     child: const Icon(
//                       Icons.add,
//                       color: Colors.white,
//                     ),
//                   ),
//                 )
//               : SizedBox(),
//           Container(
//             margin: EdgeInsets.symmetric(vertical: 10),
//             child: FloatingActionButton(
//               backgroundColor: Color.fromARGB(255, 70, 192, 151),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => ChatPage(),
//                   ),
//                 );
//               },
//               child: const Icon(
//                 Icons.message,
//                 color: Colors.white,
//               ),
//             ),
//           )
//         ],
//       ),

//     );
//   }
// }
