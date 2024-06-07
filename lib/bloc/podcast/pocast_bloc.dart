import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/bloc/podcast/podcast_event.dart';
import 'package:mobile/bloc/podcast/podcast_state.dart';
import 'package:mobile/data/repository/podcast_repository.dart';

class PodcastBloc extends Bloc<PodcastEvent, PodcastState> {
  final PodcastRepository _podcastRepository;
  PodcastBloc(this._podcastRepository) : super(PodcastInitState()) {
    on<PodcastListEvent>(
      (event, emit) async {
        var podcastList = await _podcastRepository.getPodcastList();
        emit(PodcastListState(podcastList));
      },
    );
  }
}
