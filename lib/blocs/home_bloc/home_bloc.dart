import 'package:rxdart/rxdart.dart';

class HomeBloc {
  final _itemsController = BehaviorSubject<List<String>>();

  Stream<List<String>> get itemsStream => _itemsController.stream;

  HomeBloc() {
    _itemsController.sink.add(_generateItems());
  }

  void refresh() {
    _itemsController.sink.add(_generateItems());
  }

  void loadMore() {
    final currentItems = _itemsController.value;
    final moreItems = _generateItems(start: currentItems.length);
    _itemsController.sink.add(currentItems + moreItems);
  }

  List<String> _generateItems({int start = 0}) {
    return List.generate(10, (index) => 'Item ${start + index + 1}');
  }

  void dispose() {
    _itemsController.close();
  }
}