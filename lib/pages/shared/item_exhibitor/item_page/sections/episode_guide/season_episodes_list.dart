import 'package:flutter/material.dart';
import 'package:movie_lab/constants/types.dart';
import 'package:movie_lab/pages/shared/item_exhibitor/item_box/expanded_item_box/expanded_item_box.dart';
import 'package:movie_lab/widgets/inefficacious_refresh_indicator.dart';

class EpisodeGuideSeasonEpisodes extends StatelessWidget {
  final int season;
  final dynamic show;
  const EpisodeGuideSeasonEpisodes(
      {Key? key, required this.season, required this.show})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InefficaciousRefreshIndicator(
      child: ListView.builder(
        itemCount: show.seasons[season].length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, episode) {
          return ExpandedItemBox(
            show: show.seasons[season][episode],
            preTag: "episode",
            showType: ItemSuit.EPISODE,
          );
        },
      ),
    );
  }
}
