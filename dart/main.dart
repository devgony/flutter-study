extension MapExtension<K, V> on Map<K, V> {
  bool equals(Map<K, V> other) {
    if (identical(this, other)) return true;
    if (length != other.length) return false;
    for (final key in keys) {
      if (!other.containsKey(key)) return false;
      if (other[key] != this[key]) return false;
    }

    return true;
  }
}

typedef Term = String;
typedef Definition = String;
typedef Words = Map<Term, Definition>;

class Dictionary {
  Words words;
  Dictionary(this.words);

  void add(Term term, Definition definition) {
    words[term] = definition;
  }

  Definition? get(Term term) {
    return words[term];
  }

  Definition? delete(Term term) {
    return words.remove(term);
  }

  Definition? update(Term term, Definition definition) {
    return words.update(term, (value) => definition);
  }

  Words showAll() {
    return words;
  }

  int count() {
    return words.length;
  }

  Definition? upsert(Term term, Definition definition) {
    if (words.containsKey(term)) {
      return this.update(term, definition);
    }

    this.add(term, definition);
    return null;
  }

  bool exists(Term term) {
    return words.containsKey(term);
  }

  void bulkAdd(Words words) {
    this.words.addAll(words);
  }

  void bulkDelete(List<Term> terms) {
    terms.forEach((term) => this.words.remove(term));
  }
}

main() {
  Dictionary dictionary = Dictionary({
    'Dart': 'A new programming language',
    'Flutter': 'A framework to build cross-platform apps'
  });

  dictionary.add('Android', 'A mobile operating system');
  assert(dictionary.count() == 3);

  Definition? actual = dictionary.get('Android');
  assert(actual == 'A mobile operating system');

  actual = dictionary.delete('Android');
  assert(actual == 'A mobile operating system');

  actual = dictionary.update('Dart', '3.0 is awesome');
  assert(actual == '3.0 is awesome');

  Words words = dictionary.showAll();
  assert(words.equals({
    'Dart': '3.0 is awesome',
    'Flutter': 'A framework to build cross-platform apps'
  }));

  int count = dictionary.count();
  assert(count == 2);

  Definition? updated = dictionary.upsert('Dart', 'flirting language');
  assert(updated == 'flirting language');

  Definition? inserted = dictionary.upsert('IOS', 'A mobile operating system');
  assert(inserted == null);
  assert(dictionary.count() == 3);

  bool exists = dictionary.exists('Dart');
  assert(exists == true);

  dictionary.bulkAdd({
    'Rust': 'Super fast programming language',
    'Typescript': 'A typed superset of JavaScript'
  });
  assert(dictionary.count() == 5);

  dictionary.bulkDelete(['Rust', 'Typescript']);
  assert(dictionary.count() == 3);
}
