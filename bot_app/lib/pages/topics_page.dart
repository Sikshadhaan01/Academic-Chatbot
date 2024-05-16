import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopicsPage extends StatefulWidget {
  const TopicsPage({super.key});

  @override
  State<TopicsPage> createState() => _TopicsPageState();
}

class _TopicsPageState extends State<TopicsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(""), backgroundColor: Colors.white),
      body: ExpansionPanelListExample(),
      // body:SafeArea(child: Card(
      //   child: ListView.separated(itemBuilder: (ctx,index){
      //   return ListTile(
      //     title: Text('Semester${index+1}'),
      //     trailing: const Icon(CupertinoIcons.forward),

      //   );
      // }, separatorBuilder: (ctx,index){

      //   return Divider();

      // }, itemCount:6 ),
      // ) ,
      // ),
      // body: const SingleChildScrollView(
      //   child: Padding(
      //     padding: EdgeInsets.only(left: 16.0, right: 16.0),
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [

      //       ],
      //       // children: [
      //       //   Text(
      //       //     "SEMESTER I",
      //       //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      //       //   ),
      //       //   SizedBox(height: 20),
      //       //   Text(
      //       //     "COMPUTER FUNDAMENTALS AND HTML",
      //       //     style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
      //       //   ),
      //       //   SizedBox(height: 15),
      //       //   Text("UNIT I"),
      //       //   SizedBox(height: 15),
      //       //   Text(
      //       //       "Concepts of Hardware and Software: Computer Languages, Language Translators, Features of good language, Basics Computer Organization: Von Neumann Model, Input Unit, Output Unit, Storage Unit, Control Unit, Memory Hierarchy, Primary Storage, Cache Memory, Registers, Secondary Storage Devices, Basics of Hardware Components – SMPS, Motherboard, Add-on Cards, Ports, Memory, Adapters, Network cables, Basic Computer Configuration"),
      //       //   SizedBox(
      //       //     height: 15,
      //       //   ),
      //       //   Text("UNIT II"),
      //       //   SizedBox(height: 15),
      //       //   Text(
      //       //       "Number Systems and Boolean Algebra – Decimal, Binary, Octal and Hexadecimal Numbers, Arithmetic involving Number Systems, Inter Conversions of Number Systems, 1‟s and 2‟s Complements, Complement Subtractions, Digital Codes – Binary Coded Decimal (BCD), ASCII Code ,Unicode, Gray Code, Excess-3 Code. Boolean Algebra: Boolean Operations, Logic Expressions, Postulates, Rules and Laws of Boolean Algebra, DeMorgan's Theorem, Minterms, Maxterms, SOP and POS form of Boolean Expressions for Gate Network, Simplification of Boolean Expressions using Boolean Algebra and Karnaugh Map Techniques (up to 4 variables)"),
      //       //   SizedBox(
      //       //     height: 15,
      //       //   ),
      //       //   Text("UNIT III"),
      //       //   SizedBox(height: 15),
      //       //   Text(
      //       //       "Fundamentals of Problem Solving – The Problem Solving Aspect, Top-down Design, Definition – Algorithm, Flowchart, Program - Properties of Flowcharts – Flowchart Symbols for Designing Application Programs, Sample Algorithms – Sum, Average, Finding Smallest Number, Checking Odd/Even Number, Prime Number, Quadratic Equation"),
      //       //   SizedBox(
      //       //     height: 15,
      //       //   ),
      //       //   Text("UNIT IV"),
      //       //   SizedBox(height: 15),
      //       //   Text(
      //       //       "Number Systems and Boolean Algebra – Decimal, Binary, Octal and Hexadecimal Numbers, Arithmetic involving Number Systems, Inter Conversions of Number Systems, 1‟s and 2‟s Complements, Complement Subtractions, Digital Codes – Binary Coded Decimal (BCD), ASCII Code ,Unicode, Gray Code, Excess-3 Code. Boolean Algebra: Boolean Operations, Logic Expressions, Postulates, Rules and Laws of Boolean Algebra, DeMorgan's Theorem, Minterms, Maxterms, SOP and POS form of Boolean Expressions for Gate Network, Simplification of Boolean Expressions using Boolean Algebra and Karnaugh Map Techniques (up to 4 variables)"),
      //       // ],
      //     ),
      //   ),
      // ),
    );
  }
}

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });
  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
      headerValue: 'semester${index + 1}',
      expandedValue: 'subjects${index + 1}',
    );
  });
}

class ExpansionPanelListExample extends StatefulWidget {
  const ExpansionPanelListExample({super.key});

  @override
  State<ExpansionPanelListExample> createState() =>
      _ExpansionPanelListExampleState();
}

class _ExpansionPanelListExampleState extends State<ExpansionPanelListExample> {
  final List<Item> _data = generateItems(6);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: _buildPanel(),
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headerValue),
            );
          },
          body: ListTile(
            title: Text(item.expandedValue),
            // subtitle:
            //     const Text('To delete this panel, tap the trash can icon'),
            // trailing: const Icon(Icons.delete),
            // onTap: () {
            //   setState(() {
            //     _data.removeWhere((Item currentItem) => item == currentItem);
            //   }
            //   );
            // }
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}
