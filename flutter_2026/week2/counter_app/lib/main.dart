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
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  int _counter =
      0; // this creates a variable named counter and sets its value to zero(0)
  bool _countByFive = false;
  int get _step => _countByFive ? 5 : 1;

  // _countByFive = false; this means the variable can hold either true or false
  //_countByFive records whether counting by five is enabled.
  //false means the switch is initially off,When the switch is off, we want the counter to change by 1.
  // When the switch is on (true), we want it to change by 5. .
  // The ? : syntax is called the ternary operator. It checks a condition and chooses one of two values.
  // for more understanding If _countByFive is true, use 5.Otherwise, use 1.
  // The int get _step part creates a getter, which lets us obtain the current step whenever we need it.
  void _incrementCounter() {
    setState(() {
      _counter += _step; //adds the value stored in _step if its 1, increases by 1, and if 5,it increases by 5.

      //setState tells flutter to rebuild the screen because the value has changed
      //We keep setState() because Flutter needs to rebuild the screen and display the new number.
      //_counter++;  //increases the number by +1
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter -= _step; //subtracts the value stored in _step if its 1, decreases by 1, and if 5,it decreases by 5.

      //We keep setState() so the displayed number updates immediately.
      //_counter--; //this reduces the number by -1
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetCounter,
            tooltip: 'Reset',
          ),
        ],
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: .center,
          children: [
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: _counter < 0
                    ? Colors.red
                    : (_counter == 0 ? Colors.grey : Colors.green),
              ),
            ), //this is the widget that displays my counter number

            const SizedBox(height: 20), //this is a widget that adds some space between the counter number and the switch
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('count by 5'),
                Switch(
                  value: _countByFive,
                  onChanged: (value) {
                    setState(() {
                      _countByFive = value;
                    });
                  },
                ),
              ],
            ),
            Text('Current step: $_step'),
            const SizedBox(height: 16),

            if (_counter != 0 && _counter % 5 == 0) //_counter % 5 == 0 checks whether the number is divisible by 5.
                                                     //_counter != 0 excludes zero, because we've decided to show the message only after reaching a non-zero multiple of 5.
                                                     //The if inside children means the message appears only when the condition is true.
                                                     //The text disappears automatically when the counter moves to a number that isn't a multiple of 5.
                                                     // Zero is excluded because the message should appear only
                                                     // after reaching a non-zero multiple of 5.
              const Text(
                "High five! 🖐 That's a multiple of 5",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ),
              ),

            
            //PERSONAL NOTES:
            //SizedBox adds space between the counter and the switch.
            //Row places the label and switch side by side.
            //value: _countByFive makes the switch reflect the current setting.
            //onChanged runs when you toggle the switch.
            //setState() updates _countByFive and tells Flutter to redraw the screen.
            //Text('Current step: $_step') shows whether you're counting by 1 or 5.
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            // Each FAB on a screen needs its own heroTag, otherwise Flutter
            // throws an error when navigating to another page.
            heroTag: 'decrement',
            onPressed: _decrementCounter,
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            heroTag: 'increment',
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
