import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/common/helpers/is_dark_mode.dart';
import 'package:spotify_clone/common/widget/appbar/app_bar.dart';
import 'package:spotify_clone/common/widget/favorite_button/favorite_button.dart';
import 'package:spotify_clone/core/configs/constants/app_urls.dart';
import 'package:spotify_clone/presentation/profile/bloc/favorite_songs_cubit.dart';
import 'package:spotify_clone/presentation/profile/bloc/favorite_songs_state.dart';
import 'package:spotify_clone/presentation/profile/bloc/profile_info_cubit.dart';
import 'package:spotify_clone/presentation/profile/bloc/profile_info_state.dart';
import 'package:spotify_clone/presentation/song_player/pages/song_player.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: Text("Profile"),
        backgroundColor: const Color(0xFF2C2B2B),
      ),
      body: Column(
        children: [
          _profileInfo(context),
          const SizedBox(height: 30),
          _favoriteSongs(context),
        ],
      ),
    );
  }

  Widget _profileInfo(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3.5,
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.isDarkMode ? const Color(0xFF2C2B2B) : Colors.white,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(50),
          bottomLeft: Radius.circular(50),
        ),
      ),
      child: BlocProvider(
        create: (context) => ProfileInfoCubit()..getUser(),
        child: BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
          builder: (context, state) {
            if (state is ProfileInfoLoaded) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(state.userEntity.imageUrl!),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(state.userEntity.email!),
                  const SizedBox(height: 10),
                  Text(
                    state.userEntity.fullName!,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              );
            } else if (state is ProfileInfoFailure) {
              return const Text("Failed to load Profile info");
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  Widget _favoriteSongs(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteSongsCubit()..getFavoriteSongs(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("FAVORITE SONGS"),
            const SizedBox(height: 20),
            BlocBuilder<FavoriteSongsCubit, FavoriteSongsState>(
              builder: (context, state) {
                if (state is FavoriteSongsLoaded) {
                  return ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => SongPlayerPage(
                                songEntity: state.favoriteSongs[index],
                              ),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        '${AppUrls.coverFirestorage}${state.favoriteSongs[index].artist} - ${state.favoriteSongs[index].title}.jpg${AppUrls.mediaAlt}',
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.favoriteSongs[index].title,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: context.isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      state.favoriteSongs[index].artist,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11,
                                        color: context.isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Text(
                              state.favoriteSongs[index].duration
                                  .toString()
                                  .replaceAll(".", ":"),
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 11,
                                color: context.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                            const SizedBox(width: 20),
                            FavoriteButton(
                              songEntity: state.favoriteSongs[index],
                              key: UniqueKey(),
                              function: () {
                                context.read<FavoriteSongsCubit>().removeSong(
                                  index,
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, state) =>
                        const SizedBox(height: 20),
                    itemCount: state.favoriteSongs.length,
                  );
                } else if (state is FavoriteSongsFailure) {
                  return const Text("Failed to load Profile info");
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
