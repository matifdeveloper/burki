/*
********************************************************************************

    _____/\\\\\\\\\_____/\\\\\\\\\\\\\\\__/\\\\\\\\\\\__/\\\\\\\\\\\\\\\_
    ___/\\\\\\\\\\\\\__\///////\\\/////__\/////\\\///__\/\\\///////////__
    __/\\\/////////\\\_______\/\\\___________\/\\\_____\/\\\_____________
    _\/\\\_______\/\\\_______\/\\\___________\/\\\_____\/\\\\\\\\\\\_____
    _\/\\\\\\\\\\\\\\\_______\/\\\___________\/\\\_____\/\\\///////______
    _\/\\\/////////\\\_______\/\\\___________\/\\\_____\/\\\_____________
    _\/\\\_______\/\\\_______\/\\\___________\/\\\_____\/\\\_____________
    _\/\\\_______\/\\\_______\/\\\________/\\\\\\\\\\\_\/\\\_____________
    _\///________\///________\///________\///////////__\///______________

    Created by Muhammad Atif on 3/13/2024.
    Portfolio https://atifnoori.web.app.
    IsloAI

 *********************************************************************************/

extension StringExtension on String {
  // Capitalize the first letter of the string
  String capitalize() {
    if (isEmpty) {
      return this; // Return the original string if it's empty.
    }
    return this[0].toUpperCase() + substring(1);
  }

  // Remove the alphabetic characters in String
  String removeAlphabeticCharacters() {

    // Regular expression to match digits and a decimal point
    RegExp regex = RegExp(r'(\d+(\.\d+)?)');

    // Find the first match of the regular expression in the priceString
    Match? match = regex.firstMatch(this);

    if (match != null) {
      // Extract the matched substring
      String price = match.group(0)!;

      // Parse the string into a double value
      return price;
    } else {
      // If no match found, return 0.0 or handle accordingly
      return '';
    }

  }

  // Get the youtube link from String
  String ytLink() {
    String link = this;

    RegExp regExp = RegExp(r"(?:https?://)?(?:www\.)?(?:youtube\.com/(?:[^/\n\s]+/\S+/|(?:v|e(?:mbed)?)/|\S*?[?&]v=)|youtu\.be/)([a-zA-Z0-9_-]{11})");

    // Match the regular expression with the input text
    RegExpMatch? match = regExp.firstMatch(this);

    // Check if a match is found
    if (match != null) {
      // The first group in the match contains the YouTube video ID
      String? videoId = match.group(1);

      // Construct the YouTube URL using the video ID
      String youtubeUrl = "https://www.youtube.com/watch?v=$videoId";

      return youtubeUrl;
    }


    return link;
  }

  // Get the text inside in brackets
  String? textInsideBrackets() {

    RegExp regExp = RegExp(r'\[([^\]]*)\]');
    RegExpMatch? match = regExp.firstMatch(this);
    // FlutterLogger.success(match?.group(1)??'');
    return match?.group(1)??this;
  }

  // Get the file extension
  String fileExtension() {
    int dotIndex = lastIndexOf('.');
    if (dotIndex != -1 && dotIndex < length - 1) {
      return substring(dotIndex + 1);
    } else {
      return ""; // No extension found
    }
  }

  // Remove characters after that
  String removeAfterDot() {
    RegExp regex = RegExp(r'[^.]+');
    RegExpMatch? match = regex.firstMatch(this);
    if (match != null) {
      return match.group(0) ?? this;
    } else {
      return this;
    }
  }

}