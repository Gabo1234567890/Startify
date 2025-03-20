import 'package:flutter/material.dart';

class IdeaPreviewWidget extends StatelessWidget {
  const IdeaPreviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: SizedBox(
        height: 218,
        width: 362,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: GridView.count(
            crossAxisCount: 2,
            children: [Text('Idea name'), Text('Status')],
          ),
        ),
      ),
    );
  }
}
