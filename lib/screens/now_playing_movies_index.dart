import 'package:flutter/material.dart';

class NowPlayingIndex extends StatefulWidget {
  final int moviesLength;
  final ScrollController scrollController;
  const NowPlayingIndex({super.key, required this.moviesLength, required this.scrollController});

  @override
  State<NowPlayingIndex> createState() => _NowPlayingIndexState();
}

class _NowPlayingIndexState extends State<NowPlayingIndex> {
  var index = 1;
  @override
  void initState() {
    widget.scrollController.addListener(() {
      setState(() {
        index = widget.scrollController.offset ~/ (MediaQuery.of(context).size.width * 0.65) + 1;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.black),
          child: Text(
            '$index/${widget.moviesLength}',
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
          height: 10,
          width: 10,
        ),
        Container(
          decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
          height: 10,
          width: 10,
        )
      ],
    );
  }
}
