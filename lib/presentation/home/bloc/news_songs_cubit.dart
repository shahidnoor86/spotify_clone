import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/domain/usecases/song/get_new_songs.dart';
import 'package:spotify_clone/presentation/home/bloc/news_songs_state.dart';
import 'package:spotify_clone/service_locator.dart';

class NewsSongsCubit extends Cubit<NewsSongsState> {
  NewsSongsCubit() : super(NewsSongsLoading());

  Future<void> getNewsSongs() async {
    // emit(NewsSongsLoading());
    var returnedSongs = await sl<GetNewSongsUseCase>().call(null);
    returnedSongs.fold((l) => emit(NewsSongsLoadFailure()), (data) {
      print('##### News Songs: ${data.length} #####');
      print(data);
      emit(NewsSongsLoaded(songs: data));
    });
  }
}
