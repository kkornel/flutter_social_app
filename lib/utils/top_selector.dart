import 'package:flutter/material.dart';

class TopSelector extends StatefulWidget {
  final List<String> titles;

  TopSelector({@required this.titles});

  @override
  _TopSelectorState createState() => _TopSelectorState();
}

class _TopSelectorState extends State<TopSelector> {
  int _currentIndex = 0;
  bool _isSelected;

  List<Widget> _buildTitles() {
    return widget.titles.map((title) {
      var index = widget.titles.indexOf(title);
      _isSelected = _currentIndex == index;
      return Padding(
        padding: EdgeInsets.only(left: 15),
        child: GestureDetector(
          onTap: () {
            setState(() {
              _currentIndex = index;
            });
          },
          child: Text(
            title,
            style: TextStyle(
              color: _isSelected ? Colors.black : Colors.grey,
              fontSize: _isSelected ? 22 : 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _buildTitles(),
    );
  }
}
