import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movieapp/box_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var appbar = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                children: [
                  const Icon(Icons.location_city_outlined),
                  const SizedBox(
                    width: 4,
                  ),
                  Text("RedStone Oaks", style: Theme.of(context).textTheme.bodyLarge)
                ],
              ),
              Text(
                "Vishnu dev Nagar, Wakad, Pimpri-Chinc...",
                style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.black.withOpacity(0.7)),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.centerRight,
            child: const CircleAvatar(
              radius: 20,
            ),
          ),
        )
      ],
    );

    var textField = TextField(
      canRequestFocus: false,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelText: "Search Movies by name...",
          prefixIcon: const Icon(Icons.search),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).colorScheme.inversePrimary.withOpacity(0.1)),
              borderRadius: BorderRadius.circular(30))),
    );

    var customShapeWidget = CustomPaint(
      painter: CustomDesignBox(),
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.14,
          child: const Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("24th APR 2024"),
                Text("We Movies"),
                Text("22 movies are loaded in now playing."),
              ])),
    );
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromARGB(169, 214, 144, 255),
        Color.fromARGB(196, 255, 180, 251),
        Color.fromARGB(218, 255, 209, 254),
        Color.fromARGB(227, 253, 223, 255),
        Color.fromARGB(241, 240, 240, 255)
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      child: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
        child: Column(
          children: [
            appbar,
            const SizedBox(height: 20),
            textField,
            const SizedBox(height: 20),
            customShapeWidget,
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text("NOW PLAYING"),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  height: 1,
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.grey.withOpacity(0.6), Colors.grey.withOpacity(0.4), Colors.grey.withOpacity(0.1)])),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 22,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        ClipPath(
                          clipper: CustomShapeClipper(),
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.blue),
                            margin: const EdgeInsets.only(right: 20),
                            height: MediaQuery.of(context).size.height * 0.35,
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Text("Abc $index"),
                          ),
                        ),
                        Positioned(
                          bottom: 90,
                          child: ClipPath(
                            clipper: CustomShapeClipper(),
                            child: Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.black),
                              margin: const EdgeInsets.only(right: 20),
                              height: MediaQuery.of(context).size.height * 0.15,
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: Text("Abc $index"),
                            ),
                          ),
                        )
                      ],
                    );
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Chip(
                  label: Text('1/22'),
                  labelStyle: TextStyle(color: Colors.white),
                  shape: StadiumBorder(),
                  color: MaterialStateProperty.all(Colors.black),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(color: Colors.black, shape: BoxShape.circle),
                  height: 10,
                  width: 10,
                ),
                Container(
                  decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
                  height: 10,
                  width: 10,
                )
              ],
            )
          ],
        ),
      ),
    ));
  }
}

class CustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    const radius = Radius.circular(20);

    path.moveTo(0, size.height * 0.15 + 20);
    path.arcToPoint(Offset(0 + 20, size.height * 0.15), radius: radius);
    path.lineTo(size.width * 0.32, size.height * 0.15);
    path.arcToPoint(Offset(size.width * 0.32 + 20, size.height * 0.15 - 20), radius: radius, clockwise: false);
    path.arcToPoint(Offset(size.width * 0.32 + 20 + 20, 0), radius: radius);
    path.lineTo(size.width, 0);

    path.moveTo(0, size.height * 0.15 + 20);
    path.lineTo(0, size.height);

    path.lineTo(size.width * 0.75 - 20, size.height);
    path.arcToPoint(Offset(size.width * 0.75, size.height - 20), radius: radius, clockwise: false);
    path.arcToPoint(Offset(size.width * 0.75 + 30, size.height - 50), radius: const Radius.circular(30));
    path.arcToPoint(Offset(size.width * 0.75 + 54, size.height - 70), radius: radius, clockwise: false);
    path.lineTo(size.width, 0);
    path.close();

// Adjusted arcToPoint for the bottom right corner
    // path.arcToPoint(Offset(size.width * 0.6 - 20, size.height), radius: radius);

    // path.arcToPoint(Offset(size.width * 0.7, size.height), radius: radius);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
