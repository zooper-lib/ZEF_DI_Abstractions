const _needleRegex = r'{#}';
final RegExp _regexExpression = RegExp(_needleRegex);

String interpolate(String string, List<dynamic> paramterList) {
  final Iterable<RegExpMatch> matches = _regexExpression.allMatches(string);

  assert(paramterList.length == matches.length);

  var i = -1;
  return string.replaceAllMapped(_regexExpression, (match) {
    i = i + 1;
    return '${paramterList[i]}';
  });
}
