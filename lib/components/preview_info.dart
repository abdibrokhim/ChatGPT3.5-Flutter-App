import 'package:flutter/material.dart';
import 'package:chatgpt_app/constants/constants.dart';


class PreviewInfo extends StatelessWidget {
  const PreviewInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          _buildCard(
            context,
            "Remembers what user said earlier in the conversation and more",
          ),
          const SizedBox(height: 20),
          _buildCard(
            context,
            "Allows user to generate images right in chat screen along chatting",
          ),
          const SizedBox(height: 20),
          _buildCard(
            context,
            "Allows user to download generated images and leave feedback",
          ),
          const SizedBox(height: 20),
          _buildCard(
            context,
            "Allows user to set any OpenAI model and custom assistant",
          ),
          const SizedBox(height: 20),
          _buildCard(
            context,
            "Allows user to set own API Key for fast response",
          ),
          const SizedBox(height: 20),
          _buildCard(
            context,
            "Allows user to generate custom voice overs and animate images (coming soon)",
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, String text) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      color: cardColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
} 
