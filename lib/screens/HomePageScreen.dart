import 'package:actual/screens/StickyNotesScreen.dart';
import 'package:flutter/material.dart';

import '../widgets/HomePage/InspirationalQuote.dart';
import '../widgets/HomePage/HomePageBlock.dart';
import '../screens/ToDoScreen.dart';
import 'TimeTableScreen.dart';

class HomePageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/LightBlue2.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.transparent,
              centerTitle: false,
              forceElevated: false,
              expandedHeight: 290,
              floating: true,
              pinned: false,
              title: Text(
                'Welcome to Rocket Study!',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
              ),
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Stack(
                  children: <Widget>[
                    Positioned.fill(
                        child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50)),
                      child: Image.asset(
                        'assets/images/Rocket.jpg',
                        fit: BoxFit.cover, //can be Boxfit.fill
                      ),
                    )),
                    Padding(
                        padding: EdgeInsets.only(top: 50, left: 100),
                        child: InspirationalQuote()),
                  ],
                ),
              ),
            ),
            SliverGrid.count(
              crossAxisCount: 2,
              children: <Widget>[
                HomePageBlock(
                  blockName: 'To-Do List',
                  blockColor: Colors.blueAccent,
                  iconDisplay: Icon(
                    Icons.assignment_turned_in,
                  ),
                  routingLocation: ToDoScreen.routeName,
                ),
                HomePageBlock(
                  blockName: 'Timetable',
                  blockColor: Colors.greenAccent,
                  iconDisplay: Icon(Icons.schedule),
                  routingLocation: TimeTableScreen.routeName
                ),
                HomePageBlock(
                    blockName: 'Sticky Notes',
                    blockColor: Colors.limeAccent,
                    iconDisplay: Icon(Icons.note),
                    routingLocation: StickNotesScreen.routeName,),
                    
                HomePageBlock(
                  blockName: 'Email',
                  blockColor: Colors.redAccent,
                  iconDisplay: Icon(Icons.mail_outline),
                  urlLocation: 'https://login.microsoftonline.com/',
                ),
                HomePageBlock(
                    blockName: 'Luminus',
                    blockColor: Colors.purpleAccent,
                    iconDisplay: Icon(Icons.lightbulb_outline),
                    urlLocation: 'https://luminus.nus.edu.sg/'),
                HomePageBlock(
                    blockName: 'Coming Soon...',
                    blockColor: Colors.orangeAccent,
                    iconDisplay: Icon(Icons.refresh)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// return Scaffold(
//         appBar: AppBar(
//             title: Text(
//           'Welcome to Rocket Study!',
//           style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
//           textAlign: TextAlign.end,
//         )),
//         body: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             InspirationalQuote(),
//             Container(
//               height: 350,
//               child: GridView.count(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 40,
//                 mainAxisSpacing: 10,
//                 padding: EdgeInsets.all(20),
//                 children: <Widget>[
//                   HomePageBlock('To-Do List', ToDoScreen.routeName,
//                       Colors.redAccent, Icon(Icons.assignment_turned_in)),
//                   HomePageBlock('Timetable', TimeTableScreen.routeName,
//                       Colors.blueAccent, Icon(Icons.schedule)),
//                   HomePageBlock('Sticky Notes', TimeTableScreen.routeName,
//                       Colors.greenAccent, Icon(Icons.note))
//                 ],
//               ),
//             ),
//           ],
//         ));
