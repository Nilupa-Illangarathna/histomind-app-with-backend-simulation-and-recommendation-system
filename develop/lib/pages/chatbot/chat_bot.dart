import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '/widgets/lenceFlare/lence_flare.dart';
import '/Classes/dataPoints/dashboard_location_label_string.dart';
import 'package:http/http.dart' as http;

class ChatScreen extends StatefulWidget {
  @override
  State createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = [];

  bool _isRecording = false;
  bool _isSpeechStopped = true;
  String _prompt = '';
  String _userAudio = ''; // Global variable to store user's audio text

  final stt.SpeechToText _speech = stt.SpeechToText();
  Timer? _timeoutTimer;
  bool _canActivateSpeech = true;

  double _containerHeight = 0.0;
  int _maxRecordingDuration = 60; // Maximum recording duration in seconds

  @override
  void initState() {
    super.initState();
    _initializeSpeechRecognition();
  }

  void _initializeSpeechRecognition() async {
    bool available = await _speech.initialize();
    if (available) {
      setState(() {
        _isSpeechStopped = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          LensFlareContainer(
            diameter: 200.0, // Specify the diameter
            color: Color(0xFF4D1F3E), // Specify the color
            x: MediaQuery.of(context).size.width * 1 / 6, // X-coordinate
            y: MediaQuery.of(context).size.height * 1 / 6, // Y-coordinate
            opacity: 1.0,
          ),
          LensFlareContainer(
            diameter: 120.0, // Specify the diameter
            color: Color(0xFF08594C), // Specify the color
            x: MediaQuery.of(context).size.width * 5 / 12, // X-coordinate
            y: MediaQuery.of(context).size.height * 5 / 12, // Y-coordinate
            opacity: 0.9,
          ),
          LensFlareContainer(
            diameter: 200.0, // Specify the diameter
            color: Color(0xFF08594C), // Specify the color
            x: MediaQuery.of(context).size.width * 2 / 12, // X-coordinate
            y: MediaQuery.of(context).size.height * 9 / 12, // Y-coordinate
            opacity: 0.5,
          ),
          Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ShaderMask(
                          blendMode: BlendMode.srcIn,
                          shaderCallback: (Rect bounds) => RadialGradient(
                            center: Alignment.topCenter,
                            stops: [0.6, 1],
                            colors: [Color(0xFF4D1F3E), Color(0xFF08594C)],
                          ).createShader(bounds),
                          child: Icon(
                            Icons.pin_drop,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(LabelString.locationLabel,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            )),
                      ),
                      Stack(
                        children: <Widget>[
                          new IconButton(
                              icon: new ShaderMask(
                                blendMode: BlendMode.srcIn,
                                shaderCallback: (Rect bounds) => RadialGradient(
                                  center: Alignment.topCenter,
                                  stops: [0.6, 1],
                                  colors: [
                                    Color(0xFF4D1F3E),
                                    Color(0xFF08594C)
                                  ],
                                ).createShader(bounds),
                                child: Icon(
                                  Icons.notifications,
                                ),
                              ),
                              onPressed: () {}),
                          new Positioned(
                              child: new Stack(
                            children: <Widget>[
                              new Icon(Icons.brightness_1,
                                  size: 20.0, color: Colors.orange.shade500),
                              new Positioned(
                                  top: 4.0,
                                  right: 5.0,
                                  child: new Center(
                                    child: new Text(
                                      "0",
                                      style: new TextStyle(
                                          color: Colors.white,
                                          fontSize: 11.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )),
                            ],
                          )),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                color: Colors
                    .transparent, // Set your desired background color here
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * (7 / 10),
                      child: Text(
                        'HistoBot',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ),
                    ),
                    SizedBox(
                        height: 38.0), // Add some space between text and button
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Flexible(
                child: _messages.length == 0
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'How can I assist you today?',
                              style: TextStyle(
                                  color: Colors.white60,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22),
                            ),
                            Opacity(
                              opacity: 0.6,
                              child: Container(
                                  width: MediaQuery.of(context).size.width *
                                      (5 / 7),
                                  // height: MediaQuery.of(context).size.width * (5/7),
                                  child: Container(
                                    width: 225,
                                    height: 225,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors
                                          .transparent, // Background color of the container
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.transparent,
                                          offset: Offset(0, 0),
                                          blurRadius: 1,
                                          spreadRadius: -2 / 2,
                                        ),
                                      ],
                                    ),
                                    child: ClipOval(
                                      child: Image.asset(
                                        "assets/botScreen/noMessage.png",
                                        fit: BoxFit.cover, // Image scaling mode
                                      ),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.all(8.0),
                        reverse: true,
                        itemCount: _messages.length,
                        itemBuilder: (_, int index) =>
                            ChatMessageWidget(message: _messages[index]),
                      ),
              ),
              Divider(height: 1.0),
              Stack(
                children: <Widget>[
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    height: _containerHeight, // Adjusted height
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      // Center the second Lottie animation
                      child: Lottie.asset(
                        'assets/jsons/speech_recording.json',
                        frameRate: FrameRate.composition,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  Container(
                    height: 50.0,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          onTapDown: (_) {
                            if (!_canActivateSpeech) return;

                            // Calculate one-third of the screen width
                            double screenWidth =
                                MediaQuery.of(context).size.width;
                            double oneThirdWidth = screenWidth / 3;

                            // Set the container height to one-third of the screen width
                            setState(() {
                              _containerHeight = oneThirdWidth;
                            });

                            // Start recognition after an initial delay
                            _startRecording();
                          },
                          onTapUp: (_) {
                            if (_isRecording) {
                              // If still recording when released, stop recording
                              _stopRecording();
                            } else if (_canActivateSpeech) {
                              // Otherwise, send the text message
                              _handleSubmitted(_userAudio);
                            }
                            // Collapse the container
                            setState(() {
                              _containerHeight = 0.0;
                              _canActivateSpeech = true;
                            });
                          },
                          child: Lottie.asset(
                            'assets/jsons/splashBot.json',
                            frameRate: FrameRate.composition,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          child: _buildTextComposer(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Colors.white),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration: InputDecoration.collapsed(
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
                  hintText: 'Send a message',
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.send),
              onPressed: () => _handleSubmitted(_textController.text),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> fetchChatbotResponse(String userMessage) async {
    final url =
        'https://histomind-86f011d5789d.herokuapp.com/chatbot/$userMessage';

    final response = await http.get(Uri.parse(url), headers: {
      'accept': 'application/json',
    });

    if (response.statusCode == 200) {
      // Successful API call
      Map<String, dynamic> responseData = json.decode(response.body);
      String message = responseData['response'];
      return message;
    } else {
      // Handle any error cases here
      throw Exception('Failed to load chatbot response');
    }
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    print('You: $text');

    setState(() {
      _messages.insert(0, ChatMessage(text, true));
    });
    fetchChatbotResponse(text).then((response) {
      print('Chatbot Response: $response');
      _addBotMessage(response);
    }).catchError((error) {
      print('Error: $error');
      _addBotMessage("Sorry, an error occurred.");
    });
  }

  void _addBotMessage(String message) {
    print('Bot: $message');
    setState(() {
      _messages.insert(0, ChatMessage(message, false));
    });
  }


  void _startRecording() {
    if (_speech.isListening) return;

    _timeoutTimer?.cancel();
    _speech.listen(
      onResult: (result) {
        setState(() {
          _prompt = result.recognizedWords;
        });
      },
    );

    // Set a timer to stop recording after the maximum duration
    _timeoutTimer = Timer(Duration(seconds: _maxRecordingDuration), () {
      if (_speech.isListening) {
        _stopRecording();
      }
    });

    setState(() {
      _isRecording = true;
      _isSpeechStopped = false;
      _canActivateSpeech = false;
    });
  }

  void _stopRecording() {
    if (!_speech.isListening) return;

    _speech.stop();
    _timeoutTimer?.cancel();

    setState(() {
      _isRecording = false;
      _isSpeechStopped = true;
      _userAudio = _prompt; // Store user's audio as text
      print('User audio: $_userAudio'); // Print user's audio text to console
      _prompt = '';
    });

    // Send the user's audio text as a message
    if (_userAudio.isNotEmpty) {
      _handleSubmitted(_userAudio);
    }
  }
}

class ChatMessage {
  final String text;
  final bool isMe;

  ChatMessage(this.text, this.isMe);
}

class ChatMessageWidget extends StatelessWidget {
  final ChatMessage message;

  ChatMessageWidget({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          !message.isMe
              ? CircleAvatar(
                  backgroundColor: Theme.of(context).hintColor,
                  child: Text('Bot'),
                )
              : Container(),
          Container(
            margin: const EdgeInsets.only(left: 10.0, right: 10.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: message.isMe
                  ? Color(0xFF08594C).withOpacity(0.8)
                  : Color(0xFF4D1F3E).withOpacity(0.8),
              borderRadius: BorderRadius.circular(10.0),
            ),
            constraints: BoxConstraints(maxWidth: 250.0), // Set a maximum width
            child: Text(
              message.text,
              style: TextStyle(
                fontSize: 16.0,
                color: message.isMe ? Colors.white : Colors.white70,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
//
// final List<String> dummyResponses = [
//   'Hello!',
//   'How can I help you?',
//   'I\'m here to assist you.',
//   'What do you want to know?',
//   'Ask me anything.',
// ];
