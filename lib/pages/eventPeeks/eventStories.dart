import 'package:flutter/material.dart';

class EventStories extends StatefulWidget {
  const EventStories({Key? key}) : super(key: key);

  @override
  _EventStoriesState createState() => _EventStoriesState();
}

class _EventStoriesState extends State<EventStories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(("No Stories Available"))),
    );
  }
}
