import 'package:flutter/material.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/providers/notes_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddNewNotePage extends StatefulWidget {
  final bool isUpdate;
  final Note? note;
  const AddNewNotePage({key, required this.isUpdate, this.note});

  @override
  State<AddNewNotePage> createState() => _AddNewNotePageState();
}

class _AddNewNotePageState extends State<AddNewNotePage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  FocusNode nodeFocus = FocusNode();

  void addNewNote() {
    Note newNote = Note(
        id: Uuid().v1(),
        userid: "krishanwalia",
        title: _titleController.text,
        content: _contentController.text,
        dateadded: DateTime.now());
    Provider.of<NotesProvider>(context, listen: false).addNote(newNote);
    Navigator.pop(context);
  }

  void updateNote() {
    widget.note!.title = _titleController.text;
    widget.note!.content = _contentController.text;
    widget.note!.dateadded = DateTime.now();
    Provider.of<NotesProvider>(context, listen: false).updateNote(widget.note!);
    Navigator.pop(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isUpdate) {
      _titleController.text = widget.note!.title!;
      _contentController.text = widget.note!.content!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),
        actions: [
          IconButton(
            onPressed: () {
              if (widget.isUpdate) {
                updateNote();
              } else {
                addNewNote();
              }
            },
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _titleController,
              onSubmitted: (val) {
                if (val.isNotEmpty) {
                  nodeFocus.requestFocus();
                }
              },
              autofocus: (widget.isUpdate == true) ? false : true,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Title',
              ),
            ),
            TextField(
              controller: _contentController,
              focusNode: nodeFocus,
              maxLines: null,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 18,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Note',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
