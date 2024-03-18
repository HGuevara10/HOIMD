import 'package:flutter/material.dart';
import 'package:hoimd/Pages/Add_Pet.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isDog1Submitted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      backgroundColor: const Color.fromARGB(255, 25, 25, 25),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          text(),
          const SizedBox(height: 200),
          if (isDog1Submitted)
            Container(
              alignment: Alignment.center,
              width: 200,
              height: 100,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 90, 27, 172),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'Hello your dogs name is: ' ,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          addPetButton(),
        ],
      ),
    );
  }

  Widget addPetButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddPet(
                petName: '',
                day: '',
                month: '',
                year: '',
              ),
            ),
          );

          if (result != null && result) {
            setState(() {
              isDog1Submitted = true;
            });
          }
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 90, 27, 172)),
        child: const Text('Add a Dog', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: const Color.fromARGB(255, 25, 25, 25),
      title: const Text(
        'How Old Is My Dog?',
        style: TextStyle(fontSize: 36, color: Color.fromARGB(255, 90, 27, 172)),
      ),
    );
  }

  Widget text() {
    return const Text(
      'Add up to 3 dogs!',
      style: TextStyle(fontSize: 25, color: Color.fromARGB(255, 90, 27, 172)),
    );
  }
}