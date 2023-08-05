import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class Car extends StatefulWidget {
  const Car({Key? key}) : super(key: key);

  @override
  _CarState createState() => _CarState();
}

class _CarState extends State<Car> {
  Color bgColor = Colors.lightBlue.shade50;
  Key modelViewerKey = UniqueKey(); // Declare modelViewerKey as a Key

  bool _autoPlay = false;
  List<String> dropDownItems = ['30', '60', '90'];
  String selectedDropDownItem = '30';
  int getRotationPerSecond() {
    switch (selectedDropDownItem) {
      case '30':
        return 30;
      case '60':
        return 60;
      case '90':
        return 90;
      default:
        return 30; // Default value
    }
  }

  void _onMenuItemSelected(String item) {
    // ... (existing code unchanged)
  }

  void changeColor(Color color) {
    setState(() {
      bgColor = color;
      //print("Color changed to: $color");
      modelViewerKey = UniqueKey(); // Update modelViewerKey to trigger reload
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(95, 32, 14, 14),
          centerTitle: true,
          title: const Text(
            "3D Car Model",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 350,
                child: ModelViewer(
                  key:
                      modelViewerKey, // Assign the modelViewerKey to the ModelViewer
                  backgroundColor: bgColor,
                  src: 'assets/old_rusty_car.glb',
                  alt: "A 3D model of a table soccer",
                  ar: true,
                  autoPlay: _autoPlay,
                  autoRotate: _autoPlay,
                  cameraControls: true,
                  rotationPerSecond: '${getRotationPerSecond()}deg',
                ),
              ),
              Container(
                  height: 90,
                  color: Color.fromARGB(255, 235, 231, 231),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Change Background Color",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(2, 30),
                              backgroundColor: Colors.red,
                            ),
                            onPressed: () => changeColor(Colors.red),
                            child: const Text(''),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(2, 30),
                              backgroundColor: Colors.blue,
                            ),
                            onPressed: () => changeColor(Colors.blue),
                            child: const Text(''),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(2, 30),
                              backgroundColor: Colors.black,
                            ),
                            onPressed: () => changeColor(Colors.black),
                            child: const Text(''),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(2, 30),
                              backgroundColor: Colors.green,
                            ),
                            onPressed: () => changeColor(Colors.green),
                            child: const Text(''),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(2, 30),
                              backgroundColor: Colors.lightBlue.shade50,
                            ),
                            onPressed: () =>
                                changeColor(Colors.lightBlue.shade50),
                            child: const Text(''),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(2, 30),
                              backgroundColor: Colors.pinkAccent,
                            ),
                            onPressed: () => changeColor(Colors.pinkAccent),
                            child: const Text(''),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(2, 30),
                              backgroundColor: Colors.deepOrange,
                            ),
                            onPressed: () => changeColor(Colors.deepOrange),
                            child: const Text(''),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(2, 30),
                              backgroundColor: Colors.deepPurple,
                            ),
                            onPressed: () => changeColor(Colors.deepPurple),
                            child: const Text(''),
                          ),
                        ],
                      ),
                    ],
                  )),
              const SizedBox(
                height: 10,
              ),
              Container(
                  height: 90,
                  color: Color.fromARGB(255, 235, 231, 231),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Manage the Field",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                            checkColor: Colors.black,
                            activeColor: Colors.green,
                            value: _autoPlay,
                            onChanged: (value) {
                              setState(() {
                                _autoPlay = value!;
                                modelViewerKey = UniqueKey();
                              });
                            },
                          ),
                          const Text('Auto Rotate'),
                          const SizedBox(width: 60),
                          const Text('Set Speed      '),
                          DropdownButton<String>(
                            value: selectedDropDownItem,
                            onChanged: (newValue) {
                              setState(() {
                                selectedDropDownItem = newValue!;
                                modelViewerKey = UniqueKey();
                              });
                              // Implement actions based on the selected item here
                            },
                            items: dropDownItems.map((String item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
