import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/domain/usecases/song/get_play_list.dart';
import 'package:spotify_clone/presentation/home/bloc/play_list_state.dart';
import 'package:spotify_clone/service_locator.dart';

class PlayListCubit extends Cubit<PlayListState> {
  PlayListCubit() : super(PlayListLoading());

  Future<void> getPlayList() async {
    // emit(PlayListLoading());
    var returnedSongs = await sl<GetPlayListUseCase>().call(null);
    returnedSongs.fold((l) => emit(PlayListLoadFailure()), (data) {
      print('##### Play List Songs: ${data.length} #####');
      print(data);
      emit(PlayListLoaded(songs: data));
    });
  }
}
