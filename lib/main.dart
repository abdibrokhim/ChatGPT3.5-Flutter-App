import 'package:chatgpt_app/providers/models_provider.dart';
import 'package:chatgpt_app/providers/assistants_provider.dart';
import 'package:chatgpt_app/providers/tasks_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants/constants.dart';
import 'providers/chats_provider.dart';
import 'screens/chat_screen.dart';
import 'widgets/error_widget.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  // Hangling error in with custom widget
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    runApp(ErrorWidgetClass(errorDetails: details));
  };

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ModelsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AssistantsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => TasksProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ChatProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'ChatGPT4',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: scaffoldBackgroundColor,
            appBarTheme: AppBarTheme(
              color: cardColor,
            )),
        home: const ChatScreen(),
      ),
    );
  }
}
