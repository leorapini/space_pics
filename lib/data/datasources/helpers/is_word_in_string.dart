bool isWordInString(String word, String str) {
  final String lowerCaseWord = word.toLowerCase();
  final String lowerCaseString = str.toLowerCase();
  final bool result = lowerCaseString.contains(lowerCaseWord);
  return result;
}
