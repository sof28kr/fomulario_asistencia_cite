import 'package:flutter/material.dart';
import 'package:fomulario_asistencia_cite/Models/MapaDep.dart';

class DropdownExample extends StatefulWidget {
  final ValueChanged<String?> onDepartmentChanged;
  final ValueChanged<String?> onProvinceChanged;
  final ValueChanged<String?> onDistrictChanged;

  DropdownExample({
    required this.onDepartmentChanged,
    required this.onProvinceChanged,
    required this.onDistrictChanged,
  });

  @override
  _DropdownExampleState createState() => _DropdownExampleState();
}

class _DropdownExampleState extends State<DropdownExample> {
  String? _selectedDepartment;
  String? _selectedProvince;
  String? _selectedDistrict;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildDropdownButton(
          _selectedDepartment,
          peruDepartmentsProvinces.keys.toList(),
          'Seleccione un departamento',
          (val) {
            setState(() {
              _selectedDepartment = val;
              _selectedProvince = null;
              _selectedDistrict = null;
            });
            widget.onDepartmentChanged(val);
          },
        ),
        if (_selectedDepartment != null)
          _buildDropdownButton(
            _selectedProvince,
            peruDepartmentsProvinces[_selectedDepartment!]!,
            'Seleccione una provincia',
            (val) {
              setState(() {
                _selectedProvince = val;
                _selectedDistrict = null;
              });
              widget.onProvinceChanged(val);
            },
          ),
        if (_selectedProvince != null)
          _buildDropdownButton(
            _selectedDistrict,
            peruProvincesDistricts[_selectedProvince!]!,
            'Seleccione un distrito',
            (val) {
              setState(() {
                _selectedDistrict = val;
              });
              widget.onDistrictChanged(val);
            },
          ),
      ],
    );
  }

  Widget _buildDropdownButton(String? value, List<String> items, String hint,
      Function(String?) onChanged) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0),
      width: double.infinity,
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.grey),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
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
