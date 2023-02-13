import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movie_lab/constants/colors.dart';
import 'package:movie_lab/constants/types.dart';
import 'package:movie_lab/models/hive/convertor.dart';
import 'package:movie_lab/models/hive/models/actor_preview.dart';
import 'package:movie_lab/models/hive/models/show_preview.dart';
import 'package:movie_lab/models/item_models/show_models/show_preview_model.dart';
import 'package:movie_lab/modules/preferences/preferences_shareholder.dart';
import 'package:movie_lab/pages/main/home/home_data_controller.dart';
import 'package:movie_lab/pages/main/profile/list_page/sections/history_timeline.dart';
import 'package:movie_lab/pages/shared/item_exhibitor/item_box/lists_item_box.dart';
import 'package:movie_lab/widgets/error.dart';
import 'package:movie_lab/widgets/inefficacious_refresh_indicator.dart';
import 'package:ms_undraw/ms_undraw.dart';

class UserlistBody extends StatefulWidget {
  const UserlistBody({Key? key, required this.listName}) : super(key: key);

  final String listName;
  @override
  _UserlistBodyState createState() => _UserlistBodyState();
}

class _UserlistBodyState extends State<UserlistBody> {
  late FToast fToast;
  late List<ShowPreview> list;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    getList();
    if (widget.listName == 'history') {
      Future.delayed(const Duration(milliseconds: 300))
          .then((value) => setState(() {
                _scrollController.animateTo(
                  _scrollController.position.maxScrollExtent,
                  duration: Duration(milliseconds: list.length * 140),
                  curve: Curves.easeInOut,
                );
              }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.listName == "recommendations"
        ? GetBuilder<HomeDataController>(builder: (recommendations) {
            return recommendations.recommendations.isNotEmpty
                ? InefficaciousRefreshIndicator(
                    child: ListView.builder(
                    itemCount: recommendations.recommendations.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ListItemBox(
                        listName: widget.listName,
                        showPreview: recommendations.recommendations[index],
                      );
                    },
                  ))
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 100),
                      Text("There is no ${widget.listName} for you yet!",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                      SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: UnDraw(
                          illustration: UnDrawIllustration.empty,
                          color: kGreyColor,
                          padding: const EdgeInsets.all(65),
                          placeholder: const Center(
                            child: SpinKitThreeBounce(
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          errorWidget: ConnectionErrorWidget(
                              errorText:
                                  "An unexpected error occurred while loading the illustration.",
                              tryAgain: () {}),
                        ),
                      ),
                    ],
                  );
          })
        : widget.listName == "artists"
            ? ValueListenableBuilder<Box<HiveActorPreview>>(
                valueListenable:
                    Hive.box<HiveActorPreview>(widget.listName).listenable(),
                builder: (context, artistValue, child) {
                  final list =
                      artistValue.values.toList().cast<HiveActorPreview>();
                  return list.isNotEmpty
                      ? InefficaciousRefreshIndicator(
                          child: ListView.builder(
                            itemCount: list.length,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return ListItemBox(
                                listName: "artists",
                                actorPreview: convertHiveToActorPreview(
                                    list[list.length - index - 1]),
                              );
                            },
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const SizedBox(
                              height: 100,
                            ),
                            Text(
                                "You haven't add anything in your ${widget.listName} yet!",
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600)),
                            SizedBox(
                              height: MediaQuery.of(context).size.width,
                              child: UnDraw(
                                color: kGreyColor,
                                illustration: UnDrawIllustration.empty,
                                padding: const EdgeInsets.all(65),
                                placeholder: const Center(
                                  child: SpinKitThreeBounce(
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                                errorWidget: ConnectionErrorWidget(
                                    errorText:
                                        "An unexpected error occurred while loading the illustration.",
                                    tryAgain: () {}),
                              ),
                            ),
                          ],
                        );
                },
              )
            : ValueListenableBuilder<Box<HiveShowPreview>>(
                valueListenable:
                    Hive.box<HiveShowPreview>(widget.listName).listenable(),
                builder: (context, box, _) {
                  final list = box.values.toList().cast<HiveShowPreview>();
                  return list.isNotEmpty
                      ? widget.listName == "history"
                          ? Column(
                              children: [
                                Expanded(
                                  child: InefficaciousRefreshIndicator(
                                    child: CustomScrollView(
                                      controller: _scrollController,
                                      physics: const BouncingScrollPhysics(),
                                      slivers: [
                                        TimelineSteps(
                                          steps: [
                                            for (HiveShowPreview show in list)
                                              ListItemBox(
                                                  listName: widget.listName,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      76,
                                                  showPreview:
                                                      convertHiveToShowPreview(
                                                          show),
                                                  showType:
                                                      ItemSuit.USER_HISTORY)
                                          ],
                                          watchDates: [
                                            for (HiveShowPreview show in list)
                                              convertHiveToShowPreview(show)
                                                  .watchDate
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : InefficaciousRefreshIndicator(
                              child: ListView.builder(
                                itemCount: list.length,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return ListItemBox(
                                      listName: widget.listName,
                                      showPreview: convertHiveToShowPreview(
                                          list[list.length - index - 1]));
                                },
                              ),
                            )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              const SizedBox(height: 100),
                              Text(
                                  "You haven't add anything in your ${widget.listName} yet!",
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(
                                height: MediaQuery.of(context).size.width,
                                child: UnDraw(
                                  color: kGreyColor,
                                  illustration: UnDrawIllustration.empty,
                                  padding: const EdgeInsets.all(65),
                                  placeholder: const Center(
                                    child: SpinKitThreeBounce(
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                  errorWidget: ConnectionErrorWidget(
                                      errorText:
                                          "An unexpected error occurred while loading the illustration.",
                                      tryAgain: () {}),
                                ),
                              ),
                            ]);
                },
              );
  }

  Future getList() async {
    PreferencesShareholder preferencesShareholder = PreferencesShareholder();
    if (widget.listName != "artists") {
      list = preferencesShareholder.getList(listName: widget.listName);
      if (widget.listName != 'history') {
        setState(() {
          list = list;
        });
      } else {
        list.sort((a, b) => a.watchDate!.compareTo(b.watchDate!));
        setState(() {
          list = list;
        });
        preferencesShareholder.replaceList(
            listName: widget.listName,
            newItems: [
              for (ShowPreview item in list)
                convertShowPreviewToHive(showPreview: item)
            ]);
      }
    }
  }
}
