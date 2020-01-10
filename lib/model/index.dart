class Index {
  final num changes;
  final num price;
  final String indexName;
  final String ticker;

  Index._({this.changes, this.price, this.indexName, this.ticker});

  factory Index.fromJson(Map<String, dynamic> json) {
    return new Index._(
      changes: json['changes'],
      price: json['price'],
      indexName: json['indexName'],
      ticker: json['ticker'],
    );
  }
}
