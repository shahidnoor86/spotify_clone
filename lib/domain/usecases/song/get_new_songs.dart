import 'package:dartz/dartz.dart';
import 'package:spotify_clone/core/usecase/usecase.dart';
import 'package:spotify_clone/domain/repository/song/song.dart';
import 'package:spotify_clone/service_locator.dart';

class GetNewSongsUseCase implements UseCase<Either, dynamic> {
  @override
  Future<Either> call(dynamic params) async {
    return await sl<SongsRepository>().getNewsSongs();
  }
}
