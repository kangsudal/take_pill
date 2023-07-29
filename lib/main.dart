import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('myBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '약 챙겨먹기',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: '약챙겨 드세요!!'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    String korWeekDay = '';
    List<String> korWeekDays = ['월', '화', '수', '목', '금', '토', '일'];
    korWeekDay = korWeekDays[DateTime.now().weekday - 1];
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ValueListenableBuilder<Box>(
          valueListenable: Hive.box('myBox').listenable(),
          builder: (context, box, widget) {
            String timeStampBreakfast =
                box.get('timeStampBreakfast', defaultValue: '');
            String timeStampLunch = box.get('timeStampLunch', defaultValue: '');
            String timeStampDinner =
                box.get('timeStampDinner', defaultValue: '');
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}($korWeekDay)",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),

                ///아침약
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        box.put(
                          'timeStampBreakfast',
                          DateTime.now().toString(),
                        );
                      },
                      child: Text('아침약(혈압약, 당뇨약)'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 150,
                          width: 150,
                          child: Image.asset('images/혈압약.jpg'),
                        ),
                        SizedBox(
                          height: 150,
                          width: 150,
                          child: Image.asset('images/당뇨아침약.jpg'),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          timeStampBreakfast,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        if (timeStampBreakfast != '')
                          IconButton(
                            onPressed: () {
                              box.delete('timeStampBreakfast');
                            },
                            icon: Icon(
                              Icons.remove_circle,
                              color: Colors.blueAccent,
                              size: 20,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),

                ///점심약
                // Column(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: <Widget>[
                //     ElevatedButton(
                //       onPressed: () {
                //         box.put(
                //           'timeStampLunch',
                //           DateTime.now().toString(),
                //         );
                //       },
                //       child: Text('점심약'),
                //     ),
                //     Row(
                //       children: [
                //         Text(
                //           timeStampLunch,
                //           style: Theme.of(context).textTheme.bodyLarge,
                //         ),
                //         if (timeStampLunch != '')
                //           IconButton(
                //             onPressed: () {
                //               box.delete('timeStampLunch');
                //             },
                //             icon: Icon(
                //               Icons.remove_circle,
                //               color: Colors.blueAccent,
                //               size: 20,
                //             ),
                //           ),
                //       ],
                //     ),
                //   ],
                // ),

                SizedBox(height: 30),

                ///저녁약
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        box.put(
                          'timeStampDinner',
                          DateTime.now().toString(),
                        );
                      },
                      child: Text('저녁약(당뇨약, 서울현)'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 150,
                          width: 150,
                          child: Image.asset('images/당뇨저녁약.jpg'),
                        ),
                        SizedBox(
                          height: 150,
                          width: 150,
                          child: Image.asset('images/서울현.jpg'),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          timeStampDinner,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        if (timeStampDinner != '')
                          IconButton(
                            onPressed: () {
                              box.delete('timeStampDinner');
                            },
                            icon: Icon(
                              Icons.remove_circle,
                              color: Colors.blueAccent,
                              size: 20,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ],
            );
          }),
    );
  }
}
