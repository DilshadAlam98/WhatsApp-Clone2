import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'recent_event.dart';
part 'recent_state.dart';

class RecentBloc extends Bloc<RecentEvent, RecentState> {
  RecentBloc() : super(RecentInitial()) {
    on<RecentEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
