import 'package:flutter/material.dart';
import 'package:startify/data/notifiers.dart';

class SearchBarWidget extends StatefulWidget {
  final Function(String) onChanged;

  const SearchBarWidget({super.key, required this.onChanged});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
                    controller: _controller,
                    onChanged: widget.onChanged,
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
