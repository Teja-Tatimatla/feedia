import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainChatScreen extends StatefulWidget {
  const MainChatScreen({super.key, required this.endpoint});

  final String endpoint;

  @override
  State<MainChatScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<MainChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, String>> _messages = [];
  final List<Map> _gptHistory = [];
  Map<String, Object> _location = {};

  @override
  void initState() {
    _initialPing();
    super.initState();
  }

  Future<void> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    // Request location permission
    permission = await Geolocator.requestPermission();

    // Get current position
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    //_location = "Lat: ${position.latitude}, Lon: ${position.longitude}";
    _location = {
      "latitude": position.latitude,
      "longitude": position.longitude,
    };
  }

  Future<void> _initialPing() async {
    await _getLocation();

    final localeCode = Localizations.localeOf(context).languageCode;

    try {
      final response = await http.post(
        Uri.parse(
          "http://172.104.209.107:3000/${widget.endpoint}",
        ), // Server IP not hidden as its a temp server
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "messages": _gptHistory,
          "location": _location,
          "language": localeCode,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final Map<String, dynamic> greetingObj = data["conversation"][0];
        _gptHistory.add(greetingObj);

        setState(() {
          _messages.add({
            'role': 'assistant',
            'content': greetingObj['content'],
          });
        });
      }
    } catch (e) {
      //Handle error
    }
  }

  Future<void> _fetchResponse() async {
    try {
      final response = await http.post(
        Uri.parse(
          "http://172.104.209.107:3000/${widget.endpoint}", // Server IP not hidden as its a temp server
        ), // Replace this
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"messages": _gptHistory, "location": _location}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        List conversation = data['conversation'];
        int convoLength = conversation.length;
        Map<String, dynamic> latestConvoObj =
            data["conversation"][convoLength - 2];
        if (latestConvoObj['content'] == "" ||
            widget.endpoint == "wraparound-help") {
          latestConvoObj = data["conversation"][convoLength - 1];
        }
        _gptHistory.add(latestConvoObj);

        setState(() {
          _messages.add({
            'role': 'assistant',
            'content': latestConvoObj['content'],
          });
        });
      }
      _scrollToBottom();
    } catch (e) {
      print(e);
    }
  }

  void _sendMessage() async {
    final input = _controller.text.trim();
    if (input.isEmpty) return;

    setState(() {
      _messages.add({'role': 'user', 'content': input});
      _controller.clear();
    });

    _gptHistory.add({'role': 'user', 'content': input});

    _scrollToBottom();

    await _fetchResponse();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }
  /*
  Widget _buildMessage(Map<String, String> message) {
    final isUser = message['role'] == 'user';
    final alignment = isUser ? Alignment.centerRight : Alignment.centerLeft;
    final color =
        isUser
            ? const Color.fromARGB(255, 65, 170, 255)
            : Color.fromRGBO(13, 19, 25, 1);


    return Align(
      alignment: alignment,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        constraints: const BoxConstraints(maxWidth: 380),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(message['content'] ?? ''),
      ),
    );
  }
*/

  Widget _buildMessage(BuildContext context, Map<String, String> message) {
    final isUser = message['role'] == 'user';
    final alignment = isUser ? Alignment.centerRight : Alignment.centerLeft;
    final color =
        isUser
            ? const Color.fromARGB(255, 65, 170, 255)
            : const Color.fromRGBO(13, 19, 25, 1);

    final content = message['content'] ?? '';

    final RegExp linkRegex = RegExp(
      r'(https:\/\/www\.google\.com\/maps\/dir\/\?api=1[^\s]+)',
    );
    final parts = content.split(linkRegex);
    final matches = linkRegex.allMatches(content).toList();

    final containsLink = matches.isNotEmpty;
    if (containsLink) FocusScope.of(context).unfocus();

    return Align(
      alignment: alignment,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        constraints: const BoxConstraints(maxWidth: 380),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment:
              isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            for (int i = 0; i < parts.length; i++) ...[
              if (parts[i].isNotEmpty)
                ..._buildStyledText(parts[i], containsLink),
              if (i < matches.length)
                TextButton.icon(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.blueAccent,
                  ),
                  onPressed: () async {
                    final url = matches[i].group(0)!;
                    if (await canLaunchUrl(Uri.parse(url))) {
                      await launchUrl(
                        Uri.parse(url),
                        mode: LaunchMode.externalApplication,
                      );
                    }
                  },
                  icon: const Icon(Icons.directions),
                  label: const Text('Open in Maps'),
                ),
            ],
          ],
        ),
      ),
    );
  }

  List<Widget> _buildStyledText(String text, bool boldKeys) {
    final List<String> lines = text.split('\n');
    final List<Widget> widgets = [];

    for (final line in lines) {
      if (boldKeys && line.contains(':')) {
        final index = line.indexOf(':');
        if (index != -1) {
          final key = line.substring(0, index + 1);
          final value = line.substring(index + 1).trim();

          widgets.add(
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '$key ',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  TextSpan(
                    text: value,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        }
      } else {
        widgets.add(
          Text(line, style: const TextStyle(color: Colors.white, fontSize: 16)),
        );
      }
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(3, 12, 18, 1),
        surfaceTintColor: Color.fromRGBO(3, 12, 18, 1),
      ),
      backgroundColor: Color.fromRGBO(3, 12, 18, 1),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessage(context, _messages[index]);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 6.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onSubmitted: (_) => _sendMessage(),
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.messageHint,
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
