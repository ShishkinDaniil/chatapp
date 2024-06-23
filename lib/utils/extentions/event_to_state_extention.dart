import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension MapEventToStateExtension<E, S> on Bloc<E, S> {
  void onBlocEvent(Stream<S> Function(E event) mapEventToState) {
    on<E>(
        (event, emit) =>
            emit.forEach(mapEventToState(event), onData: (S state) => state),
        transformer: sequential());
  }
}
