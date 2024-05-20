String shorten(String input, int length) {
  if (input.length > length) {
    return '${input.substring(0, length)}...';
  } else {
    return input;
  }
}
