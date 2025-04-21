import 'package:flutter/material.dart';
import 'package:startify/data/notifiers.dart';
import 'package:startify/services/auth_service.dart';
import 'package:startify/services/startup_service.dart';
import 'package:startify/widgets/idea_card_widget.dart';
import 'package:startify/widgets/person_card_widget.dart';
import 'package:startify/widgets/search_bar_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, dynamic>> _items = [];
  int _skip = 0;
  final int _limit = 10;
  bool _isLoading = false;
  bool _hasMore = true;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    myIdeaNotifier.value = false;
    _loadItems();

    ideaSearchNotifier.addListener(() {
      if (mounted) {
        setState(() {
          _skip = 0;
          _items.clear();
          _hasMore = true;
        });
        _loadItems();
      }
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !_isLoading &&
          _hasMore) {
        _loadItems();
      }
    });
  }

  void _onSearchChanged(String value) {
    setState(() {
      _searchQuery = value;
      _skip = 0;
      _items.clear();
      _hasMore = true;
    });
    _loadItems();
  }

  Future<void> _loadItems() async {
    _isLoading = true;
    final newItems = await _getItems();
    setState(() {
      _items.addAll(newItems);
      _skip += newItems.length;
      _hasMore = newItems.length == _limit;
      _isLoading = false;
    });
  }

  Future<List<Map<String, dynamic>>> _getItems() {
    if (ideaSearchNotifier.value) {
      return StartupService().getStartups(
        skip: _skip,
        limit: _limit,
        search: _searchQuery,
      );
    } else {
      return AuthService().getUsers(
        skip: _skip,
        limit: _limit,
        search: _searchQuery,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: SingleChildScrollView(
      //   physics: ClampingScrollPhysics(),
      body: Column(
        children: [
          SearchBarWidget(onChanged: _onSearchChanged),
          ValueListenableBuilder(
            valueListenable: ideaSearchNotifier,
            builder: (context, ideaSearch, child) {
              return Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: _items.length + (_hasMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == _items.length) {
                      return Center(child: CircularProgressIndicator());
                    }
                    final item = _items[index];
                    if (ideaSearch) {
                      return IdeaCardWidget(
                        name: item['name'],
                        description: item['description'] ?? 'No description',
                        goalAmount: item['goal_amount'],
                        raisedAmount: item['raised_amount'],
                      );
                    } else {
                      return PersonCardWidget(
                        name: item['username'],
                        bio: item['bio'] ?? 'No bio',
                      );
                    }
                  },
                ),
              );
            },
          ),
        ],
      ),
      // ),
    );
  }
}
