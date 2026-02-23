import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/common/bloc/favorite_button/favorite_button_cubit.dart';
import 'package:spotify_clone/common/bloc/favorite_button/favorite_button_state.dart';
import 'package:spotify_clone/core/configs/theme/app_colors.dart';
import 'package:spotify_clone/domain/entities/song/song.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({super.key, required this.songEntity, this.function});

  final SongEntity songEntity;
  final Function? function;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteButtonCubit(),
      child: BlocBuilder<FavoriteButtonCubit, FavoriteButtonState>(
        builder: (context, state) {
          if (state is FavoriteButtonInitial) {
            return IconButton(
              icon: Icon(
                songEntity.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_outline_outlined,
                size: 25,
                color: AppColors.darkGrey,
              ),
              onPressed: () {
                // Handle favorite button press
                context.read<FavoriteButtonCubit>().favoriteButtonUpdated(
                  songEntity.songId,
                );
                if (function != null) {
                  function!();
                }
              },
            );
          }

          if (state is FavoriteButtonUpdated) {
            return IconButton(
              icon: Icon(
                state.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_outline_outlined,
                size: 25,
                color: AppColors.darkGrey,
              ),
              onPressed: () {
                // Handle favorite button press
                context.read<FavoriteButtonCubit>().favoriteButtonUpdated(
                  songEntity.songId,
                );
              },
            );
          }

          return Container();
        },
      ),
    );
  }
}
