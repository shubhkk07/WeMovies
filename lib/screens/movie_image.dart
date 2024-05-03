import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
    var response = await Dio().get(url);
    Directory directory = await getApplicationCacheDirectory();
    File file = File(path.join(directory.path, path.basename(widget.imagePath)));
    await file.writeAsBytes(json.decode(utf8.decode(response.data)));
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
              width: widget.size.width,
              height: widget.size.height,
              errorBuilder: ((context, error, stackTrace) => CachedNetworkImage(
                  width: widget.size.width, height: widget.size.height, imageUrl: MovieImage.url + widget.imagePath)),
            );
          } else {
            return CachedNetworkImage(
                width: widget.size.width, height: widget.size.height, imageUrl: MovieImage.url + widget.imagePath);
          }
        });
  }
}
