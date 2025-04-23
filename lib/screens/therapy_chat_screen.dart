import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TherapyChatScreen extends StatefulWidget {
  const TherapyChatScreen({super.key});

  @override
  State<TherapyChatScreen> createState() => _TherapyChatScreenState();
}

class _TherapyChatScreenState extends State<TherapyChatScreen> {
  final TextEditingController _controller = TextEditingController();

  final ScrollController _scrollController = ScrollController();

  final List<Map<String, String>> _messages = [];

  final List<Map> _gptHistory = [];

  @override
  void initState() {
    _initialPing();
    super.initState();
  }

  Future<void> _initialPing() async {
    try {
      final response = await http.post(
        Uri.parse("http://172.104.209.107:3000/therapy"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"messages": _gptHistory}),
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
        Uri.parse("http://172.104.209.107:3000/therapy"), // Replace this
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"messages": _gptHistory}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        List conversation = data['conversation'];
        int convoLength = conversation.length;
        Map<String, dynamic> latestConvoObj =
            data["conversation"][convoLength - 1];
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
                return _buildMessage(_messages[index]);
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
                      border: const OutlineInputBorder(),
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
