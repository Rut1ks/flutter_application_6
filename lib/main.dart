import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'pr5',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FirstRoute(),
    );
  }
}

class FirstRoute extends StatelessWidget {
  FirstRoute({super.key});
  final ValueNotifier<ThemeMode> _notifier = ValueNotifier(ThemeMode.light);
  TextEditingController textSendedFrom = TextEditingController();

  void SaveDataInSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('sended', textSendedFrom.text);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: _notifier,
      builder: (_, mode, __) {
        return MaterialApp(
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: mode,
          home: Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                ),
                Container(
                  child: TextField(
                    controller: textSendedFrom,
                  ),
                ),
                ElevatedButton(
                  child: const Text('Переход в другое окно'),
                  onPressed: () {
                    SaveDataInSharedPreferences();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SecondRoute(
                          textSended: textSendedFrom.text,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            floatingActionButton: ElevatedButton(
              onPressed: () => _notifier.value =
                  mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light,
              child: Text('Тема'),
            ),
          ),
        );
      },
    );
  }
}

class SecondRoute extends StatelessWidget {
  SecondRoute({super.key, required this.textSended});

  final String textSended;
  final ValueNotifier<ThemeMode> _notifier = ValueNotifier(ThemeMode.light);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: _notifier,
      builder: (_, mode, __) {
        return MaterialApp(
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: mode,
          home: Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    textSended,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 400,
                )
              ],
            ),
            floatingActionButton: ElevatedButton(
              onPressed: () => _notifier.value =
                  mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light,
              child: Text('Тема'),
            ),
          ),
        );
      },
    );
  }
}
