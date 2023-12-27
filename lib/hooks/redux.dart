import 'package:flutter_hooks/flutter_hooks.dart' hide Store;
import 'package:flutter_redux/flutter_redux.dart';
import 'package:master_interface_flutter/store/states/app_state.dart';
import 'package:redux/redux.dart';

Store<AppState> useStore() {
  final context = useContext();
  return StoreProvider.of<AppState>(context);
}

typedef Dispatch = dynamic Function(dynamic action);

Dispatch useDispatch() {
  return useStore().dispatch;
}

typedef Selector<State, Output> = Output Function(State state);
typedef EqualityFn<T> = bool Function(T a, T b);
Output? useSelector<Output>(
  Selector<AppState, Output> selector, [
  EqualityFn? equalityFn,
]) {
  final store = useStore();
  final snap = useStream<Output>(
    store.onChange.map(selector).distinct(equalityFn),
    initialData: selector(store.state),
  );

  return snap.data;
}
