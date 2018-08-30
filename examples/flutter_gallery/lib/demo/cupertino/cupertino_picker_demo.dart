// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'cupertino_navigation_demo.dart' show coolColorNames;

const double _kPickerSheetHeight = 216.0;
const double _kPickerItemHeight = 32.0;

class CupertinoPickerDemo extends StatefulWidget {
  static const String routeName = '/cupertino/picker';

  @override
  _CupertinoPickerDemoState createState() => _CupertinoPickerDemoState();
}

class _CupertinoPickerDemoState extends State<CupertinoPickerDemo> {
  int _selectedColorIndex = 0;

  Duration timer = Duration();

  // Value that is shown in the date picker in date mode.
  DateTime date = new DateTime.now();

  // Value that is shown in the date picker in time mode.
  DateTime time = new DateTime.now();

  // Value that is shown in the date picker in dateAndTime mode.
  DateTime dateTime = new DateTime.now();

  Widget _buildMenu(List<Widget> children) {
    return Container(
      decoration: const BoxDecoration(
        color: CupertinoColors.white,
        border: Border(
          top: BorderSide(color: Color(0xFFBCBBC1), width: 0.0),
          bottom: BorderSide(color: Color(0xFFBCBBC1), width: 0.0),
        ),
      ),
      height: 44.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SafeArea(
          top: false,
          bottom: false,
          child: DefaultTextStyle(
            style: const TextStyle(
              letterSpacing: -0.24,
              fontSize: 17.0,
              color: CupertinoColors.black,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: children,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildColorPicker() {
    final FixedExtentScrollController scrollController =
      FixedExtentScrollController(initialItem: _selectedColorIndex);
    return CupertinoPicker(
      scrollController: scrollController,
      itemExtent: _kPickerItemHeight,
      backgroundColor: CupertinoColors.white,
      onSelectedItemChanged: (int index) {
        setState(() {
          _selectedColorIndex = index;
        });
      },
      children: List<Widget>.generate(coolColorNames.length, (int index) {
        return Center(child:
        Text(coolColorNames[index]),
        );
      }),
    );
  }

  Widget _buildBottomPicker(Widget picker) {
    return Container(
      height: _kPickerSheetHeight,
      padding: const EdgeInsets.only(top: 8.0),
      color: CupertinoColors.white,
      child: DefaultTextStyle(
        style: const TextStyle(
          color: CupertinoColors.black,
          fontSize: 22.0,
        ),
        child: GestureDetector(
          // Blocks taps from propagating to the modal sheet and popping.
          onTap: () {},
          child: SafeArea(
            top: false,
            child: picker,
          ),
        ),
      ),
    );
  }

  Widget _buildCountdownTimerPicker(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showCupertinoModalPopup<void>(
          context: context,
          builder: (BuildContext context) {
            return _buildBottomPicker(
              CupertinoTimerPicker(
                initialTimerDuration: timer,
                onTimerDurationChanged: (Duration newTimer) {
                  setState(() {
                    timer = newTimer;
                  });
                },
              ),
            );
          },
        );
      },
      child: _buildMenu(
        <Widget>[
          const Text('Countdown Timer'),
          new Text(
            '${timer.inHours}:'
              '${(timer.inMinutes % 60).toString().padLeft(2,'0')}:'
              '${(timer.inSeconds % 60).toString().padLeft(2,'0')}',
            style: const TextStyle(color: CupertinoColors.inactiveGray),
          ),
        ],
      ),
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        showCupertinoModalPopup<void>(
          context: context,
          builder: (BuildContext context) {
            return _buildBottomPicker(
              new CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: date,
                onDateTimeChanged: (DateTime newDateTime) {
                  setState(() {
                    date = newDateTime;
                  });
                },
              ),
            );
          },
        );
      },
      child: _buildMenu(
        <Widget>[
          const Text('Date'),
          new Text(
            DateFormat.yMMMMd().format(date),
            style: const TextStyle(color: CupertinoColors.inactiveGray),
          ),
        ]
      ),
    );
  }

  Widget _buildTimePicker(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        showCupertinoModalPopup<void>(
          context: context,
          builder: (BuildContext context) {
            return _buildBottomPicker(
              new CupertinoDatePicker(
                mode: CupertinoDatePickerMode.time,
                initialDateTime: time,
                onDateTimeChanged: (DateTime newDateTime) {
                  setState(() {
                    time = newDateTime;
                  });
                },
              ),
            );
          },
        );
      },
      child: _buildMenu(
          <Widget>[
            const Text('Time'),
            new Text(
              DateFormat('hh:mm aa').format(time),
              style: const TextStyle(color: CupertinoColors.inactiveGray),
            ),
          ]
      ),
    );
  }

  Widget _buildDateAndTimePicker(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        showCupertinoModalPopup<void>(
          context: context,
          builder: (BuildContext context) {
            return _buildBottomPicker(
              new CupertinoDatePicker(
                mode: CupertinoDatePickerMode.dateAndTime,
                initialDateTime: dateTime,
                onDateTimeChanged: (DateTime newDateTime) {
                  setState(() {
                    dateTime = newDateTime;
                  });
                },
              ),
            );
          },
        );
      },
      child: _buildMenu(
          <Widget>[
            const Text('Date and Time'),
            new Text(
              DateFormat('hh:mm aa, MMM dd yyyy').format(dateTime),
              style: const TextStyle(color: CupertinoColors.inactiveGray),
            ),
          ]
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cupertino Picker'),
      ),
      body: DefaultTextStyle(
        style: const TextStyle(
          fontFamily: '.SF UI Text',
          fontSize: 17.0,
          color: CupertinoColors.black,
        ),
        child: DecoratedBox(
          decoration: const BoxDecoration(color: Color(0xFFEFEFF4)),
          child: ListView(
            children: <Widget>[
              const Padding(padding: EdgeInsets.only(top: 32.0)),
              GestureDetector(
                onTap: () async {
                  await showCupertinoModalPopup<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return _buildBottomPicker(_buildColorPicker());
                    },
                  );
                },
                child: _buildMenu(
                    <Widget>[
                      const Text('Favorite Color'),
                      Text(
                        coolColorNames[_selectedColorIndex],
                        style: const TextStyle(
                            color: CupertinoColors.inactiveGray
                        ),
                      ),
                    ]
                ),
              ),
              _buildCountdownTimerPicker(context),
              _buildDatePicker(context),
              _buildTimePicker(context),
              _buildDateAndTimePicker(context),
            ],
          ),
        ),
      ),
    );
  }
}