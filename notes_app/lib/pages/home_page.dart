import 'package:flutter/material.dart';

import 'package:notes_app/pages/add_new_note.dart';
import 'package:notes_app/providers/notes_provider.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';

class HomePage extends StatefulWidget {
  const HomePage({key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    NotesProvider notesProvider = Provider.of<NotesProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('My Notes APP')),
      body: (notesProvider.isloading == false)
          ? SafeArea(
              child: Container(
                child: (notesProvider.notes.length > 0)
                    ? ListView(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(12.0),
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  searchQuery = value;
                                });
                              },
                              decoration: const InputDecoration(
                                hintText: 'Search',
                              ),
                            ),
                          ),
                          (notesProvider.getFilteredNotes(searchQuery).length >
                                  0)
                              ? GridView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                  ),
                                  itemCount: notesProvider
                                      .getFilteredNotes(searchQuery)
                                      .length,
                                  itemBuilder: (context, index) {
                                    Note currentNote = notesProvider
                                        .getFilteredNotes(searchQuery)[index];
                                    return GestureDetector(
                                      onTap: () {
                                        // to open the same page
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                AddNewNotePage(
                                                    isUpdate: true,
                                                    note: currentNote),
                                          ),
                                        );
                                        // to update
                                      },
                                      onLongPress: () {
                                        // to delete
                                        notesProvider.deleteNOte(currentNote);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        margin: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.blue,
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              currentNote.title!,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              currentNote.content!,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: Colors.blueGrey),
                                              maxLines: 5,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : const Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Text(
                                    'No Notes Found!!!',
                                    textAlign: TextAlign.center,
                                  )),
                        ],
                      )
                    : const Center(
                        child: Text("No Notes yet"),
                      ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) => AddNewNotePage(isUpdate: false),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
