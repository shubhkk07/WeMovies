import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:movieapp/screens/custom_clipper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class MovieImage extends StatefulWidget {
  static const url = 'https://image.tmdb.org/t/p/w500';
  final String imagePath;
  final Size size;
  const MovieImage({super.key, required this.imagePath, required this.size});

  @override
  State<MovieImage> createState() => _MovieImageState();
}

class _MovieImageState extends State<MovieImage> {
  @override
  void initState() {
    saveImageToLocalStorage();
    super.initState();
  }

  saveImageToLocalStorage() async {
    final url = MovieImage.url + widget.imagePath;
    var response = await get(Uri.parse(url));
    Directory directory = await getApplicationCacheDirectory();
    File file = File(path.join(directory.path, path.basename(widget.imagePath)));
    await file.writeAsBytes(response.bodyBytes);
  }

  Future<File?> getImageFromLocalStorage() async {
    Directory directory = await getApplicationCacheDirectory();
    final imagePath = path.join(directory.path, path.basename(widget.imagePath));
    try {
      File file = File.fromUri(Uri.parse(imagePath));
      return file;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<File?>(
        future: getImageFromLocalStorage(),
        builder: (builder, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return Image.file(
              snapshot.data!,
              fit: BoxFit.cover,
              height: widget.size.height,
              width: widget.size.width,
              errorBuilder: (context, error, stackTrace) => Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  height: widget.size.height,
                  width: widget.size.width,
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Icon(
                      Icons.no_photography,
                      size: 40,
                    ),
                  )),
            );
          } else {
            return CachedNetworkImage(
                fit: BoxFit.cover,
                height: widget.size.height,
                width: widget.size.width,
                imageUrl: MovieImage.url + widget.imagePath);
          }
        });
  }
}
