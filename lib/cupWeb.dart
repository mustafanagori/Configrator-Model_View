import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class Cup extends StatefulWidget {
  const Cup({super.key});

  @override
  State<Cup> createState() => _CupState();
}

class _CupState extends State<Cup> {
  double _progress = 0;
  InAppWebViewController? webView;
  Color bgColor = Colors.lightBlue.shade50;
  final TextEditingController text = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    text.dispose();
    super.dispose();
  }

  void sendtext(String text) {
    //print the text enter into textfield
    print("here i text that i send it $text");
    // store javacode in to variable
    String javascriptCode = 'app.contentWindow.postMessage("$text", "*")';
    print('javascript format: $javascriptCode');
    // function to evulate the javacode
    webView?.evaluateJavascript(source: javascriptCode).then((value) {
      // Check the result of the JavaScript evaluation
      print("funcation is processsing");
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Cup Configrator Web View"),
            backgroundColor: Colors.black26,
          ),
          body: SingleChildScrollView(
            child: Column(children: [
              SizedBox(
                height: 250,
                width: double.infinity,
                child: InAppWebView(
                  //https://vcapture.pk/playcanvas-packages/box-configurator-built/
                  initialUrlRequest: URLRequest(
                      url: Uri.parse('https://playcanv.as/e/p/WZ2fvacO/')),
                  onWebViewCreated: (InAppWebViewController controller) {
                    webView = controller;
                  },
                  onProgressChanged:
                      (InAppWebViewController controller, int progess) {
                    setState(() {
                      _progress = progess / 100;
                    });
                  },
                ),
              ),
              // color
              Container(
                height: 90,
                color: Color.fromARGB(255, 243, 243, 243),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          // Wrap TextField with Expanded
                          child: Padding(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: TextField(
                              key: ValueKey('cupTextField'),
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
                              sendtext(enteredText);
                              // Add your button action here
                            },
                            child: Text('post Message'),
                          ),
                        ),
                      ],
                    )
                  ],
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
            ]),
          )),
    );
  }
}
