import 'package:flutter/material.dart';

class DropdownQuestionController {
  String? _selectedValue;

  String? get selectedValue => _selectedValue;

  void setSelectedValue(String? value) {
    _selectedValue = value;
  }
}

class DropdownQuestionBar extends StatefulWidget {
  final String question;
  final List<String> options;
  final DropdownQuestionController controller;
  final Function(String?)? onChanged;

  const DropdownQuestionBar({
    super.key,
    required this.question,
    required this.controller,
    required this.options,
    this.onChanged,
  });

  @override
  _DropdownQuestionBarState createState() => _DropdownQuestionBarState();
}

class _DropdownQuestionBarState extends State<DropdownQuestionBar> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButtonFormField<String>(
            value: _selectedOption,
            hint: Text(widget.question),
            onChanged: (String? newValue) {
              setState(() {
                _selectedOption = newValue;
                widget.controller.setSelectedValue(_selectedOption);
              });
              if (widget.onChanged != null) {
                widget.onChanged!(newValue);
              }
            },
            items: widget.options.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
            ),
          ),
        ],
      ),
    );
  }
}
