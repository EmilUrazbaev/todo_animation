import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  debugPaintSizeEnabled = false;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _iconSizeAnimation;
  Animation _helloAnimation;
  Animation _listAnimation;
  Animation _buttonAnimation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    _iconSizeAnimation = Tween<double>(begin: 0.0, end: 50.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: (Interval(0.0, 0.4, curve: Curves.easeOut)),
      ),
    );
    _helloAnimation = Tween<double>(begin: 0.0, end: 24.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: (Interval(0.4, 0.6, curve: Curves.easeOut)),
      ),
    );
    _listAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: (Interval(0.6, 0.8, curve: Curves.easeOut)),
      ),
    );
    _buttonAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: (Interval(0.8, 1.0, curve: Curves.easeOut)),
      ),
    );
    _animationController.addListener(() {
      setState(() {});
    });
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      floatingActionButton: Transform.scale(
        scale: _buttonAnimation.value,
        child: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {},
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //container with appbar height
          Container(
            height: kToolbarHeight,
            width: double.infinity,
          ),
          Container(
            alignment: Alignment.topRight,
            height: 90,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.only(top: 10, right: 10),
              child: Image.asset(
                'assets/images/pngegg.png',
                width: _iconSizeAnimation.value,
              ),
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello!',
                  style: TextStyle(
                      fontSize: _helloAnimation.value,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Your ToDo list for today:',
                  style: TextStyle(fontSize: 17),
                ),
              ],
            ),
          ),
          Expanded(
            child: Opacity(
              opacity: _listAnimation.value,
              child: ListView.builder(
                padding: EdgeInsets.all(0.0),
                itemBuilder: (context, pos) {
                  return CheckboxListTile(
                    title: Text('ToDo #$pos'),
                    value: false,
                    onChanged: (pos) {},
                  );
                },
                itemCount: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}
