import 'dart:async';

enum CounterAction {
  INCREMENT,
  DECREMENT,
  RESET
}

class CounterBloc {

  int counter=0;

  final _streamController1 = StreamController<int>();
  StreamSink<int> get counterSink => _streamController1.sink;
  Stream<int> get counterStream => _streamController1.stream;

  final _streamController2 = StreamController<CounterAction>();
  StreamSink<CounterAction> get eventSink => _streamController2.sink;
  Stream<CounterAction> get eventStream => _streamController2.stream;

  final _streamController3 = StreamController<bool>();
  StreamSink<bool> get alertSink => _streamController3.sink;
  Stream<bool> get alertStream => _streamController3.stream;

  CounterBloc() {
    eventStream.listen((event) {
      if(event == CounterAction.INCREMENT)
        counter++;
      else if(event == CounterAction.DECREMENT) {
        counter--;
        if(counter<0) {
          print('true');
          alertSink.add(true);
          return;
        }
      }
      else if(event == CounterAction.RESET)
        counter=0;

      counterSink.add(counter);
    });
  }

}