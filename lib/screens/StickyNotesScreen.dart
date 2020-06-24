import 'package:actual/widgets/StickyNotes/NoteWidget.dart';
import 'package:flutter/material.dart';
import 'package:actual/models/Note.dart';
import '../widgets/StickyNotes/NewNote.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'dart:math';

class StickNotesScreen extends StatefulWidget {
  static const routeName = "/Stick-Notes";
  final List<Note> notes;
  StickNotesScreen(this.notes);

  @override
  State<StatefulWidget> createState() {
    return _StickNoteState();
  }
}

class _StickNoteState extends State<StickNotesScreen> {
  void startAddNewNote(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewNote(addNewNote),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void addNewNote(String title, String body) {
    final List<Color> colours = [
      Color.fromRGBO(252, 252, 154, 1),
      Color.fromRGBO(252, 252, 252, 1),
      Color.fromRGBO(252, 183, 249, 1),
      Color.fromRGBO(252, 222, 183, 1),
      Color.fromRGBO(252, 196, 183, 1),
      Color.fromRGBO(159, 242, 156, 1),
      Color.fromRGBO(242, 156, 156, 1),
      Colors.redAccent,
      Colors.blue[50],
      Colors.blueGrey,
      Colors.amberAccent
    ];
    int x = Random().nextInt(11);
    setState(() {
      widget.notes
          .add(Note(DateTime.now().toString(), title, body, colours[x]));
    });
  }

  void delete(String id) {
    setState(() {
      widget.notes.removeWhere((item) => id == item.id);
    });
  }

  num calcNoteHeight(String title, String body) {
    int length = title.length + body.length;
    if (body.contains('\n')) {
      length += 50;
    }

    if (length < 30) return 1;
    if (length < 50) return 1.5;
    if (length < 100) return 2;
    if (length > 100) return 2.5;
    else {
      return 2.5;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          elevation: 20,
          child: Icon(Icons.add),
          onPressed: () => startAddNewNote(context)),
      backgroundColor: Colors.grey[100],
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPadding(
            padding: EdgeInsets.only(bottom: 20),
            sliver: SliverAppBar(
              backgroundColor: Colors.transparent,
              centerTitle: false,
              forceElevated: false,
              expandedHeight: 250,
              floating: false,
              pinned: false,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50)),
                  child: Stack(
                    children: <Widget>[
                      Image.asset(
                        'assets/images/whiteBackground.jpg',
                        fit: BoxFit.cover, //can be Boxfit.fill
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 80, left: 20),
                        height: MediaQuery.of(context).size.height * 0.35,
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Text(
                          'Sticky Notes',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverStaggeredGrid.count(
            crossAxisCount: 4,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
            children: <Widget>[
              for (var i = 0; i < widget.notes.length; i++)
                NoteWidget(widget.notes[widget.notes.length - i - 1], delete)
            ],
            staggeredTiles: <StaggeredTile>[
              for (var i = 0; i < widget.notes.length; i++)
                StaggeredTile.count(
                    2,
                    calcNoteHeight(
                        widget.notes[widget.notes.length - i - 1].title,
                        widget.notes[widget.notes.length - i - 1].body))
            ],
          )
        ],
      ),
    );
  }
}
