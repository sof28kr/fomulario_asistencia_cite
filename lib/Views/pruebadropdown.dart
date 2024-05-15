import 'package:flutter/material.dart';

class DropdownWidget extends StatefulWidget {
  @override
  _DropdownWidgetState createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  String? _selectedOptionA;
  String? _selectedOptionB;
  String? _selectedOptionC;

  final Map<String, List<String>> _optionsB = {
    'A': ['A1', 'A2', 'A3'],
    'B': ['B1', 'B2', 'B3'],
  };

  final Map<String, List<String>> _optionsC = {
    'A1': ['A1a', 'A1b'],
    'A2': ['A2a', 'A2b'],
    'B1': ['B1a', 'B1b'],
    'B2': ['B2a', 'B2b'],
  };

  List<String> get _dropdownBItems {
    return _selectedOptionA != null ? _optionsB[_selectedOptionA] ?? [] : [];
  }

  List<String> get _dropdownCItems {
    return _selectedOptionB != null ? _optionsC[_selectedOptionB] ?? [] : [];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildDropdownButton(
            _selectedOptionA, ['A', 'B'], 'Selecciona una opción en A', (val) {
          setState(() {
            _selectedOptionA = val;
            _selectedOptionB = null;
            _selectedOptionC = null;
          });
        }),
        _buildDropdownButton(
            _selectedOptionB, _dropdownBItems, 'Selecciona una opción en B',
            (val) {
          setState(() {
            _selectedOptionB = val;
            _selectedOptionC = null;
          });
        }),
        _buildDropdownButton(
            _selectedOptionC, _dropdownCItems, 'Selecciona una opción en C',
            (val) {
          setState(() {
            _selectedOptionC = val;
          });
        }),
      ],
    );
  }

  Widget _buildDropdownButton(String? value, List<String> items, String hint,
      Function(String?) onChanged) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25),
      width: double.infinity,
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        ),
        hint: Text(hint),
        onChanged: items.isEmpty ? null : onChanged,
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
