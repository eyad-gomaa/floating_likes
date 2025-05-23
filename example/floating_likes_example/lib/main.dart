import 'package:floating_likes/floating_likes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'floating likes example',
      debugShowCheckedModeBanner: false,
      
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const FloatingLikesExample(),
    );
  }
}

class FloatingLikesExample extends StatefulWidget {
  const FloatingLikesExample({super.key});

  @override
  State<FloatingLikesExample> createState() => _FloatingLikesExampleState();
}

class _FloatingLikesExampleState extends State<FloatingLikesExample> {
  final FloatingLikesController _controller = FloatingLikesController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Floating Likes Example')),
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: ElevatedButton.icon(
                onHover: (value) => _controller.showLike(),
                onPressed: () => _controller.showLike(),
                icon: Image.asset('assets/heart.png', width: 20, height: 20),
                label: const Text("Send Like"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
              ),
            ),
          ),
          FloatingLikes(
            controller: _controller,
            likeWidget: Image.asset('assets/heart.png', width: 50, height: 50),
            likePosition: EdgeInsets.only(
              bottom: 30,
              right: (MediaQuery.sizeOf(context).width / 2) - 50,
            ),
          ),
        ],
      ),
    );
  }
}
