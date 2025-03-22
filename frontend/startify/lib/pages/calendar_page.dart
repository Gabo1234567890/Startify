import 'package:flutter/material.dart';
import 'dart:math';

enum CalendarViewMode { daily, weekly, monthly }

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  CalendarPageState createState() => CalendarPageState();
}

class CalendarPageState extends State<CalendarPage> {
  DateTime _currentDate = DateTime.now();
  CalendarViewMode _viewMode = CalendarViewMode.monthly;

  final TextEditingController _eventNameController = TextEditingController();
  TimeOfDay _selectedTime = TimeOfDay(hour: 12, minute: 0);
  DateTime _selectedDate = DateTime.now();

  final Map<DateTime, List<Map<String, dynamic>>> _events = {};
  final Map<DateTime, Color> _dayColors = {};
  Map<String, dynamic>? _selectedEvent;

  final List<Color> _eventColors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
  ];
  final Random _random = Random();

  void _addEvent() {
    if (_eventNameController.text.isEmpty) return;

    DateTime eventDateTime = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _selectedTime.hour,
      _selectedTime.minute,
    );

    Color eventColor = _eventColors[_random.nextInt(_eventColors.length)];

    setState(() {
      _events.putIfAbsent(eventDateTime, () => []).add({
        "name": _eventNameController.text,
        "color": eventColor,
      });
      _dayColors[_selectedDate] = eventColor;
      _eventNameController.clear();
    });
  }

  void _removeEvent() {
    if (_selectedEvent == null) return;

    setState(() {
      _events.forEach((key, value) {
        value.removeWhere((event) => event == _selectedEvent);
      });
      _events.removeWhere((key, value) => value.isEmpty);
      _selectedEvent = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Define colors based on the theme mode
    final Color selectedColor =
        isDarkMode ? Color(0xFF2D526C) : Color.fromRGBO(224, 253, 255, 1);
    final Color unselectedColor = Colors.grey;
    final Color textColor = isDarkMode ? Colors.white : Colors.black;

    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildViewButton(
              "Daily",
              CalendarViewMode.daily,
              selectedColor,
              unselectedColor,
              textColor,
            ),
            _buildViewButton(
              "Weekly",
              CalendarViewMode.weekly,
              selectedColor,
              unselectedColor,
              textColor,
            ),
            _buildViewButton(
              "Monthly",
              CalendarViewMode.monthly,
              selectedColor,
              unselectedColor,
              textColor,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Expanded(
          child: _buildCalendarView(selectedColor, unselectedColor, textColor),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              _buildTextInput(
                "Event Name",
                _eventNameController,
                selectedColor,
                textColor,
              ),
              _buildDateTimeSelector(selectedColor, textColor),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildRoundedButton(
                "Create Event",
                _addEvent,
                selectedColor,
                textColor,
              ),
              _buildRoundedButton(
                "Delete Event",
                _removeEvent,
                _selectedEvent != null ? selectedColor : unselectedColor,
                textColor,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildViewButton(
    String text,
    CalendarViewMode mode,
    Color selectedColor,
    Color unselectedColor,
    Color textColor,
  ) {
    return GestureDetector(
      onTap: () => setState(() => _viewMode = mode),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: _viewMode == mode ? selectedColor : unselectedColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(text, style: TextStyle(color: textColor)),
      ),
    );
  }

  Widget _buildTextInput(
    String hint,
    TextEditingController controller,
    Color backgroundColor,
    Color textColor,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(color: textColor.withValues(alpha: 0.7)),
        ),
        style: TextStyle(color: textColor),
      ),
    );
  }

  Widget _buildDateTimeSelector(Color backgroundColor, Color textColor) {
    return Padding(
      padding: EdgeInsets.only(top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () async {
              DateTime? picked = await showDatePicker(
                context: context,
                initialDate: _selectedDate,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (picked != null) setState(() => _selectedDate = picked);
            },
            child: Text(
              "📅 ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}",
              style: TextStyle(color: textColor),
            ),
          ),
          GestureDetector(
            onTap: () async {
              TimeOfDay? picked = await showTimePicker(
                context: context,
                initialTime: _selectedTime,
                builder: (context, child) {
                  return MediaQuery(
                    data: MediaQuery.of(
                      context,
                    ).copyWith(alwaysUse24HourFormat: false),
                    child: child!,
                  );
                },
              );

              if (picked != null) {
                setState(
                  () => _selectedTime = TimeOfDay(hour: picked.hour, minute: 0),
                );
              }
            },
            child: Text(
              "⏰ ${_selectedTime.format(context)}",
              style: TextStyle(color: textColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoundedButton(
    String text,
    VoidCallback onTap,
    Color backgroundColor,
    Color textColor,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(text, style: TextStyle(color: textColor)),
      ),
    );
  }

  Widget _buildCalendarView(
    Color selectedColor,
    Color unselectedColor,
    Color textColor,
  ) {
    switch (_viewMode) {
      case CalendarViewMode.daily:
        return _buildDailyView(selectedColor, unselectedColor, textColor);
      case CalendarViewMode.weekly:
        return _buildWeeklyView(selectedColor, unselectedColor, textColor);
      case CalendarViewMode.monthly:
      default:
        return _buildMonthlyView(selectedColor, unselectedColor, textColor);
    }
  }

  Widget _buildWeeklyView(
    Color selectedColor,
    Color unselectedColor,
    Color textColor,
  ) {
    DateTime startOfWeek = _currentDate.subtract(
      Duration(days: _currentDate.weekday - 1),
    );
    List<DateTime> weekDays = List.generate(
      7,
      (index) => startOfWeek.add(Duration(days: index)),
    );

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, color: textColor),
              onPressed: () {
                setState(() {
                  _currentDate = _currentDate.subtract(Duration(days: 7));
                });
              },
            ),
            Text(
              "Week of ${startOfWeek.day}/${startOfWeek.month}/${startOfWeek.year}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward, color: textColor),
              onPressed: () {
                setState(() {
                  _currentDate = _currentDate.add(Duration(days: 7));
                });
              },
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: weekDays.length,
            itemBuilder: (context, index) {
              DateTime day = weekDays[index];
              List<Map<String, dynamic>> dayEvents =
                  _events.entries
                      .where(
                        (entry) =>
                            entry.key.year == day.year &&
                            entry.key.month == day.month &&
                            entry.key.day == day.day,
                      )
                      .expand((entry) => entry.value)
                      .toList();

              return Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${day.day}/${day.month}/${day.year}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children:
                            dayEvents
                                .map(
                                  (event) => GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _selectedEvent = event;
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      margin: EdgeInsets.only(right: 4, top: 8),
                                      decoration: BoxDecoration(
                                        color:
                                            _selectedEvent == event
                                                ? selectedColor
                                                : event["color"],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        event["name"],
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDailyView(
    Color selectedColor,
    Color unselectedColor,
    Color textColor,
  ) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, color: textColor),
              onPressed: () {
                setState(() {
                  _currentDate = _currentDate.subtract(Duration(days: 1));
                });
              },
            ),
            Text(
              "${_currentDate.day}/${_currentDate.month}/${_currentDate.year}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward, color: textColor),
              onPressed: () {
                setState(() {
                  _currentDate = _currentDate.add(Duration(days: 1));
                });
              },
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 24,
            itemBuilder: (context, hour) {
              DateTime eventTime = DateTime(
                _currentDate.year,
                _currentDate.month,
                _currentDate.day,
                hour,
              );
              List<Map<String, dynamic>>? eventList = _events[eventTime];

              return Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      "${hour.toString().padLeft(2, '0')}:00 ",
                      style: TextStyle(color: textColor),
                    ),
                    Expanded(
                      child: Column(
                        children:
                            eventList
                                ?.map(
                                  (e) => GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _selectedEvent = e;
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      margin: EdgeInsets.only(bottom: 4),
                                      decoration: BoxDecoration(
                                        color:
                                            _selectedEvent == e
                                                ? selectedColor
                                                : e["color"],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        e["name"],
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                )
                                .toList() ??
                            [],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMonthlyView(
    Color selectedColor,
    Color unselectedColor,
    Color textColor,
  ) {
    DateTime firstDayOfMonth = DateTime(
      _currentDate.year,
      _currentDate.month,
      1,
    );
    DateTime firstDisplayedDay = firstDayOfMonth.subtract(
      Duration(days: firstDayOfMonth.weekday - 1),
    );
    List<DateTime> calendarDays = List.generate(
      42,
      (index) => firstDisplayedDay.add(Duration(days: index)),
    );

    DateTime selectedDay = DateTime(
      _currentDate.year,
      _currentDate.month,
      _currentDate.day,
    );

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, color: textColor),
              onPressed: () {
                setState(() {
                  _currentDate = DateTime(
                    _currentDate.year,
                    _currentDate.month - 1,
                    1,
                  );
                });
              },
            ),
            Text(
              "${_currentDate.month}/${_currentDate.year}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward, color: textColor),
              onPressed: () {
                setState(() {
                  _currentDate = DateTime(
                    _currentDate.year,
                    _currentDate.month + 1,
                    1,
                  );
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 15),
        Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:
                ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
                    .map(
                      (day) => Expanded(
                        child: Center(
                          child: Text(
                            day,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
          ),
        ),
        const SizedBox(height: 15),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(5),
            child: GridView.count(
              childAspectRatio: 0.85,
              crossAxisCount: 7,
              children:
                  calendarDays.map((day) {
                    DateTime dayKey = DateTime(day.year, day.month, day.day);
                    bool hasEvent = _events.keys.any(
                      (eventDay) =>
                          eventDay.year == day.year &&
                          eventDay.month == day.month &&
                          eventDay.day == day.day,
                    );
                    bool isSelected = selectedDay == dayKey;
                    bool isCurrentMonth = day.month == _currentDate.month;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _currentDate = dayKey;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color:
                              isSelected
                                  ? selectedColor
                                  : (hasEvent
                                      ? selectedColor
                                      : (isCurrentMonth
                                          ? unselectedColor
                                          : unselectedColor.withValues(
                                            alpha: 0.7,
                                          ))),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "${day.day}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color:
                                  isSelected
                                      ? (Theme.of(context).brightness ==
                                              Brightness.light
                                          ? Colors.black
                                          : Colors
                                              .white) // Black text in light mode, white in dark mode
                                      : (hasEvent
                                          ? (Theme.of(context).brightness ==
                                                  Brightness.light
                                              ? Colors.black
                                              : Colors
                                                  .white) // Black text in light mode for events
                                          : (isCurrentMonth
                                              ? textColor
                                              : textColor.withValues(
                                                alpha: 0.7,
                                              ))),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
