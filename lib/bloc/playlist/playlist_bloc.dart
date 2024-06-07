import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/bloc/playlist/playlist_event.dart';
import 'package:mobile/bloc/playlist/playlist_state.dart';
import 'package:mobile/data/repository/playlist_repository.dart';

class PlaylistBloc extends Bloc<PlaylistEvent, PlaylistState> {
  final PLaylistRepository _repository;
  PlaylistBloc(this._repository) : super(PlaylistInitState()) {
    on<PlaylistFetchEvent>((event, emit) async {
      var playlist = await _repository.getList(event.mix);
      emit(PlaylistResponseState(playlist));
    });
  }
}
