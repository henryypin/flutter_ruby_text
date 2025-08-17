extension IterableExtension<T> on Iterable<T> {
  List<T> separate(T separator) {
    return _insertBetween(separator).toList();
  }

  Iterable<T> _insertBetween(T item) sync* {
    for (var i = 0; i < length; i++) {
      yield elementAt(i);
      if (i < length - 1) {
        yield item;
      }
    }
  }
}
