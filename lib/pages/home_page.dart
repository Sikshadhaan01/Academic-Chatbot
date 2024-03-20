import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new/pages/chat_page.dart';
import 'package:flutter_new/pages/teacher_page.dart';
import 'package:flutter_new/pages/topics_page.dart';

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
      body: Container(color: const Color(0xffbe74ff),
        width: double.infinity,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container( 
                //decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/19199098.jpg"),fit: BoxFit.cover)),
               height: 200,),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFeecfff),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ListView.builder(
                      itemCount: departments.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
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
                                  trailing: const Icon(CupertinoIcons.forward),
                                  title: Padding(
                                    padding: const EdgeInsets.all(7.0),
                                    child: Text(
                                      departments[index],
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
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
              ),
            ]),
      ),
      floatingActionButton: Wrap(
        direction: Axis.vertical,
        children: <Widget>[
          userType == "Teacher"
              ? FloatingActionButton(
                  backgroundColor: const Color(0xffb152e8),
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
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: FloatingActionButton(
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
          )
        ],
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
