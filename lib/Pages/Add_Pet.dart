import 'package:flutter/material.dart';
import 'package:hoimd/Pages/HomePage.dart';
import 'package:hoimd/Pages/Add_Pet_Methods.dart';

class AddPet extends StatefulWidget {
  const AddPet({
    Key? key,
    required this.petName,
    required this.day,
    required this.month,
    required this.year,
  }) : super(key: key);

  final petName;
  final String? day;
  final String? month;
  final String? year;

  @override
  State<AddPet> createState() => _AddPetState();
}

class _AddPetState extends State<AddPet> {
  late TextEditingController _nameController;
  late TextEditingController _dayController;
  late TextEditingController _monthController;
  late TextEditingController _yearController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.petName);
    _dayController = TextEditingController(text: widget.day.toString());
    _monthController = TextEditingController(text: widget.month.toString());
    _yearController = TextEditingController(text: widget.year.toString());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dayController.dispose();
    _monthController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 25, 25, 25),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildInformationText(),
              const SizedBox(height: 10),
              _buildTextBox(),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 0.0),
                    child: _buildCancelButton(context),
                  ),
                  const SizedBox(width: 30),
                  _buildSubmitButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInformationText() {
    return const Text(
      'Add Information',
      style: TextStyle(fontSize: 30.0, color: Color.fromARGB(255, 90, 27, 172)),
    );
  }

  Widget _buildTextBox() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 25, 25, 25),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildTextField(_nameController, 'Pet Name'),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _buildTextField(_dayController, 'Day(dd)'),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildTextField(_monthController, 'Month(mm)'),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildTextField(_yearController, 'Year(yyyy)'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white, fontSize: 14.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildCancelButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pop(context, false); // Return false to indicate cancellation
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 90, 27, 172),
      ),
      child: const Text(
        'Cancel',
        style: TextStyle(fontSize: 14, color: Colors.white),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: () {
        if (_isValidForm()) {
          Navigator.pop(context, true); // Return true to indicate successful submission
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 90, 27, 172),
      ),
      child: const Text(
        'Submit',
        style: TextStyle(fontSize: 14, color: Colors.white),
      ),
    );
  }

  // Custom validation methods
  bool _isValidForm() {
    final petNameValid = !_nameController.text.isEmpty && !_containsNumbers(_nameController.text);
    final dayValid = _isValidDay(_dayController.text, _monthController.text);
    final monthValid = _isValidMonth(_monthController.text);
    final yearValid = !_yearController.text.isEmpty && !_containsLetters(_yearController.text);

    return petNameValid && dayValid && monthValid && yearValid;
  }

  bool _isValidMonth(String? month) {
    if (month == null) return false;
    final monthInt = int.tryParse(month);
    return monthInt != null && monthInt >= 1 && monthInt <= 12;
  }

  bool _isValidDay(String? day, String? month) {
    if (day == null || month == null) return false;
    final dayInt = int.tryParse(day);
    final monthInt = int.tryParse(month);
    if (dayInt == null || monthInt == null) return false;

    if (dayInt < 1 || dayInt > 31) return false;
    if (monthInt == 2 && (dayInt < 1 || dayInt > 29)) return false;
    if ([4, 6, 9, 11].contains(monthInt) && (dayInt < 1 || dayInt > 30))
      return false;

    return true;
  }

  bool _containsNumbers(String value) {
    return RegExp(r'\d').hasMatch(value);
  }

  bool _containsLetters(String value) {
    return RegExp(r'[a-zA-Z]').hasMatch(value);
  }
}