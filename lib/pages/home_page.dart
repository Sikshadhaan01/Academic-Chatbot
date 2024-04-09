import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new/pages/chat_page.dart';
import 'package:flutter_new/pages/teacher_page.dart';
import 'package:flutter_new/pages/topics_page.dart';
import 'package:stories_for_flutter/stories_for_flutter.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  String userType = "Teacher";
  List departments = [
    "Computer Science",
    "Information Technology",
    "B.Com",
    "BBA",
    "BA.Malayalam",
    "BA.English"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  userType == "Teacher"
                      ? FloatingActionButton(
                          shape: const CircleBorder(side: BorderSide()),
                          backgroundColor: const Color(0xffeecfff),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const TeacherPage(),
                              ),
                            );
                          },
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        )
                      : const SizedBox(),
                  Expanded(
                    child: Stories(
                      displayProgress: true,
                      storyItemList: [
                        // First group of stories
                        StoryItem(
                            name: "",
                            thumbnail: const NetworkImage(
                              "https://wallpaperaccess.com/full/16568.png",
                            ),
                            stories: [
                              // First story
                              Scaffold(
                                body: Container(
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        "https://wallpaperaccess.com/full/16568.png",
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // Second story in first group
                              const Scaffold(
                                body: Center(
                                  child: Text(
                                    "Second story in first group !",
                                    style: TextStyle(
                                      color: Color(0xff777777),
                                      fontSize: 25,
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                        // Second story group
                        StoryItem(
                          name: "",
                          thumbnail: const NetworkImage(
                            "https://www.shareicon.net/data/512x512/2017/03/29/881758_cup_512x512.png",
                          ),
                          stories: [
                            const Scaffold(
                              body: Center(
                                child: Text(
                                  "That's it, Folks !",
                                  style: TextStyle(
                                    color: Color(0xff777777),
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                            ),
                          ],
                          //3rd story group
                        ),
                        StoryItem(
                          name: "",
                          thumbnail: const NetworkImage(
                            "https://www.shareicon.net/data/512x512/2017/03/29/881758_cup_512x512.png",
                          ),
                          stories: [
                            const Scaffold(
                              body: Center(
                                child: Text(
                                  "That's it, Folks !",
                                  style: TextStyle(
                                    color: Color(0xff777777),
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
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
                      const SizedBox(height: 20),
                      const Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          'Departments',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: ListView.builder(
                            itemCount: departments.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: GestureDetector(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const TopicsPage(),
                                    ),
                                  ),
                                  child: SizedBox(
                                    height: 65,
                                    child: Card(
                                      child: ListTile(
                                        leading: const Icon(Icons.album),
                                        trailing:
                                            const Icon(CupertinoIcons.forward),
                                        title: Padding(
                                          padding: const EdgeInsets.all(7.0),
                                          child: Text(
                                            departments[index],
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ChatPage(),
            ),
          );
        },
        child: const Icon(
          CupertinoIcons.chat_bubble_2_fill,
          color: Colors.white,
        ),
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
