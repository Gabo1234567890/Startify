import 'package:flutter/material.dart';
import 'package:startify/data/notifiers.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ValueListenableBuilder(
        valueListenable: ideaSearchNotifier,
        builder: (context, ideaSearch, child) {
          return Row(
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_rounded)),
              Expanded(
                child: SizedBox(
                  height: 45,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      hintText:
                          ideaSearch ? 'Search Ideas...' : 'Search People...',
                      contentPadding: EdgeInsets.all(10),
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  ideaSearchNotifier.value = !ideaSearchNotifier.value;
                },
                icon: Icon(
                  ideaSearch ? Icons.person_search_outlined : Icons.lightbulb,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
