import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zipcode/services/post_code_service.dart';
import 'package:zipcode/styles/styles.dart';

import '../models/post_code.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _controller = TextEditingController();
  List<PostCode> _results = [];
  final PostCodeService _service = PostCodeService();
  bool _loading = false;
  String? _error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Zip Codes"),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: "Codi postal o localitat", //babel text
                  hintText: "Introdueix un codi", //hint text
                  labelStyle: TextStyles.label, //label style
                ),
                style: TextStyles.bigText,
                controller: _controller,
                onChanged: _onTextChange,
              ),
            ),
            _loading
                ? const CircularProgressIndicator()
                : Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: _buildResultsList(_results),
                    ),
                  )
          ],
        ));
  }

  void _onTextChange(String value) async {
    setState(() {
      _loading = true;
    });
    _service.currentValue = value;
    _results = await _service.fetchPlaces(value).catchError((error) {
      _error = error.toString();
      return <PostCode>[];
    });
    _loading = false;
    setState(() {});
  }

  Widget _buildResultsList(List<PostCode> results) {
    List<Widget> resultWidgets = [];

    if (results.isEmpty) return Text(_error ?? "No results found");
    _error = null;

    for (PostCode result in results) {
      for (Places place in result.places) {
        resultWidgets.add(Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              result.postCode ?? place.postCode ?? "---",
              style: TextStyles.bigTextBold,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    place.placeName,
                    style: TextStyles.title,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.place, color: AppColors.grey),
                      Text("(${place.latitude},${place.longitude})",
                          style: TextStyles.subtitle),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(width: 16),
            InkWell(
              child: const Icon(Icons.map_sharp, color: AppColors.blue),
              onTap: () {
                openMap(place.latitude, place.longitude);
              },
            ),
          ],
        ));
      }
    }
    return ListView(
      children: resultWidgets,
    );
  }

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl = "geo:$latitude,$longitude";
    if (!await launchUrl(Uri.parse(googleUrl))) {
      throw 'Could not launch $googleUrl';
    }
  }
}
