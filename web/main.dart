import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'package:http/http.dart' as http;

void main() async {
  String apiURL = 'https://api.github.com/repos';
  String flutterRepoURL = '$apiURL/flutter/flutter';
  String reactnativeRepoURL = '$apiURL/facebook/react-native';

  double flutterStargazersCount = await getStargazersCount(flutterRepoURL);
  double reactnativeStargazersCount =
      await getStargazersCount(reactnativeRepoURL);

  double difference =
      (flutterStargazersCount - reactnativeStargazersCount).abs();
  bool hasIt = flutterStargazersCount > reactnativeStargazersCount;

  querySelector('#hasIt').text = hasIt ? 'YES' : 'Not Yet';
  querySelector('#diff').text = !hasIt
      ? '${difference.toString()} stars to go'
      : 'Ahead by ${difference.toString()} stars!';
  querySelector('#flutter_stargazers_count').innerHtml =
      '${flutterStargazersCount.toString()} &starf;';
  querySelector('#reactnative_stargazers_count').innerHtml =
      '${reactnativeStargazersCount.toString()} &starf;';
}

Future getStargazersCount(String repoURL) async {
  var response = await http.get(repoURL);
  var json = jsonDecode(response.body);
  return json['stargazers_count'];
}
