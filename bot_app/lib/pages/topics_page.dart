import 'package:accordion/accordion.dart';
import 'package:accordion/accordion_section.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:flutter_new/project/routes/app_route_constants.dart';
import 'package:flutter_new/providers/subject_provider.dart';
import 'package:flutter_new/services/subject_service.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class TopicsPage extends StatefulWidget {
  final String? department;
  TopicsPage({super.key, this.department});

  @override
  State<TopicsPage> createState() => _TopicsPageState();
}

class _TopicsPageState extends State<TopicsPage> {
  ExpandedTileController _controller = ExpandedTileController(isExpanded: true);
  final List semesterList = [
    'Semester 1',
    'Semester 2',
    'Semester 3',
    'Semester 4',
    'Semester 5',
    'Semester 6'
  ];
  final List<Item> _data = generateItems(6);
  List subjectList = [];
  String selectedSem = '';
  getSubjects(String semester) async {
    Provider.of<SubjectProvider>(context, listen: false)
        .getSubjects(widget.department, semester.split(' ')[1]);
  }

  ScrollController scrollController = ScrollController();
  static const headerStyle = TextStyle(
      color: Color(0xffffffff), fontSize: 18, fontWeight: FontWeight.bold);
  static const contentStyleHeader = TextStyle(
      color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.w700);
  static const contentStyle = TextStyle(
      color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.normal);
  static const loremIpsum =
      '''Lorem ipsum is typically a corrupted version of 'De finibus bonorum et malorum', a 1st century BC text by the Roman statesman and philosopher Cicero, with words altered, added, and removed to make it nonsensical and improper Latin.''';
  static const slogan =
      'Do not forget to play around with all sorts of colors, backgrounds, borders, etc.';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Semesters & Subjects',
            style: TextStyle(
                letterSpacing: 1, fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
          ),
          backgroundColor: Color(0xffbe74ff),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Accordion(
                headerBorderColor: Colors.blueGrey,
                headerBorderColorOpened: Colors.transparent,
                // headerBorderWidth: 1,
                headerBackgroundColorOpened: Color(0xffbe74ff),
                contentBackgroundColor: Colors.white,
                contentBorderColor: Color(0xffbe74ff),
                contentBorderWidth: 3,
                contentHorizontalPadding: 20,
                scaleWhenAnimating: true,
                openAndCloseAnimation: true,
                headerPadding:
                    const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
                sectionClosingHapticFeedback: SectionHapticFeedback.light,
                children: semesterList.map((semester) {
                  return AccordionSection(
                    // index: semesterList.indexOf(semester),
                    // isOpen: false,
                    contentVerticalPadding: 20,
                    leftIcon: const Icon(Icons.text_fields_rounded,
                        color: Colors.white),
                    header: Text(semester, style: headerStyle),
                    onOpenSection: () {
                      getSubjects(semester);
                    },
                    content: Consumer<SubjectProvider>(
                      builder: (context, provider, child) {
                        return ListView.builder(
                          // controller: scrollController,
                          itemCount: provider.getSubjectList.length,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: GestureDetector(
                                onTap: () {
                                  GoRouter.of(context).pushNamed(
                                      MyAppRouteConstant.notes_pageRouteName,
                                      pathParameters: {
                                        "department": widget.department!,
                                        "semester": semester,
                                        "subject":provider.getSubjectList[index]['subjectName']
                                      });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.purple[100],
                                      borderRadius: BorderRadius.circular(5)),
                                  child: ListTile(
                                    splashColor: Colors.blue,
                                    leading: Icon(Icons.abc),
                                    title: Text(provider.getSubjectList[index]
                                        ['subjectName']),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  );
                }).toList()),
          ),
        ),
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        // getSubjects(_data[index]);
        setState(() {
          _data[index].isExpanded = isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.semester),
            );
          },
          body: ListTile(
            title: Text(item.expandedValue),
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}

class Item {
  Item({
    required this.expandedValue,
    required this.semester,
    this.isExpanded = false,
  });
  String expandedValue;
  String semester;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
      semester: 'Semester ${index + 1}',
      expandedValue: 'subjects${index + 1}',
    );
  });
}
