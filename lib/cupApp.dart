import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class DS extends StatefulWidget {
  const DS({super.key});

  @override
  State<DS> createState() => _DSState();
}

class _DSState extends State<DS> {
  double _progress = 0;
  late InAppWebViewController webView;
  RangeValues values = RangeValues(0, 100);
  Color bgColor = Colors.lightBlue.shade50;
  TextEditingController text = TextEditingController();

  void sendText(String text) {
    print("Text sent from Flutter: $text");
    String javascriptCode = 'app.contentWindow.postMessage("$text", "*")';
    print('JavaScript format: $javascriptCode');
    webView.evaluateJavascript(source: javascriptCode).then((value) {
      print("Function is processing");
      if (value != null && value.isNotEmpty) {
        print('Post message sent successfully: $value');
        // You can handle the result here if needed
      } else {
        print('Failed to send post message. $value');
      }
    }).catchError((error) {
      print('Error sending post message: $error');
      // Handle any errors that occurred during evaluation
    });
  }

  void changeColor(Color color) {
    print('Changing color to: $color');
    String hexColor =
        color.value.toRadixString(16).padLeft(8, '0').substring(2);
    print('Changing color to: $hexColor');
    String javascriptCode = 'app.contentWindow.postMessage("$hexColor", "*");';
    print('JavaScript code: $javascriptCode');
    webView.evaluateJavascript(source: javascriptCode).then((value) {
      print("Function is processing");

      if (value != null) {
        print('Post message sent successfully: $value');
        // You can handle the result here if needed
      } else {
        print('Failed to send post message.');
      }
    }).catchError((error) {
      print('Error sending post message: $error');
      // Handle any errors that occurred during evaluation
    });
  }

  var _width = 300.0;
  var _heigth = 30.0;
  bool flag = true;
  Color bgcolor = Colors.yellowAccent;

  @override
  Widget build(BuildContext context) {
    RangeLabels labels =
        RangeLabels(values.start.toString(), values.end.toString());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Cup Configrator InAppWebView"),
          backgroundColor: Colors.black26,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // InAppWebView
              SizedBox(
                height: 200,
                width: MediaQuery.of(context).size.width * 100,
                child: InAppWebView(
                  initialUrlRequest: URLRequest(
                    url: Uri.parse('https://playcanv.as/e/p/WZ2fvacO/'),
                  ),
                  onWebViewCreated: (InAppWebViewController controller) {
                    webView = controller;
                  },
                  onProgressChanged:
                      (InAppWebViewController controller, int progress) {
                    setState(() {
                      _progress = progress / 100;
                    });
                  },
                  onLoadStop: (controller, url) {
                    // Add the JavaScript event listener after the page is loaded
                    String javascriptCode = '''
                      window.addEventListener("message", function(event) {
                        var receivedText = event.data;
                        console.log("Received message from Flutter: " + receivedText);
                      });
                    ''';
                    controller.evaluateJavascript(source: javascriptCode);
                  },
                  // Add this line to enable mixed content mode
                ),
              ),
              // color
              Container(
                height: 450,
                color: Colors.white24,
                child: SingleChildScrollView(
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
                      Row(
                        children: [
                          Expanded(
                            // Wrap TextField with Expanded
                            child: Padding(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: TextField(
                                controller: text,
                                decoration: const InputDecoration(
                                  labelText: 'Enter text here',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: ElevatedButton(
                              onPressed: () {
                                String enteredText = text.text;
                                sendText(enteredText);
                              },
                              child: Text('Press me'),
                            ),
                          ),
                        ],
                      ),
                      RangeSlider(
                          activeColor: Colors.green,
                          inactiveColor: Colors.green.shade100,
                          values: values,
                          labels: labels,
                          divisions: 20,
                          min: 0,
                          max: 100,
                          onChanged: (newValue) {
                            values = newValue;
                            setState(() {});
                          }),
                      Text(
                          "Selected Range is  ${values.start} to  ${values.end}"),
                      AnimatedContainer(
                        width: _width,
                        height: _heigth,
                        color: bgColor,
                        duration: Duration(seconds: 2),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (flag) {
                              _width = 300.0;
                              _heigth = 200.0;
                              bgColor = Colors.orange;
                              flag = false;
                            } else {
                              _width = 300.0;
                              _heigth = 30.0;
                              bgColor = Colors.yellowAccent;
                              flag = true;
                            }
                            setState(() {});
                          },
                          child: Text("press.")),
                    ],
                  ),
                ),
              ),
              _progress < 1
                  ? SizedBox(
                      height: 3,
                      child: LinearProgressIndicator(
                        value: _progress,
                        backgroundColor: Colors.red,
                      ),
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
