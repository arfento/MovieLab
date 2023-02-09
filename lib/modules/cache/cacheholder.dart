import 'package:get/get.dart';
import 'package:movie_lab/models/item_models/actor_models/full_actor_model.dart';
import 'package:movie_lab/models/item_models/show_models/full_show_model.dart';
import 'package:movie_lab/modules/cache/cache_data.dart';

class CacheHolder {
  Future saveShowInfoInCache({required FullShow show}) async {
    bool thereIs = false;

    List<dynamic> shows = Get.find<CacheData>().showData;
    for (var isShow in shows) {
      if (isShow.id == show.id) {
        thereIs = true;
        break;
      }
    }

    if (!thereIs) {
      Get.find<CacheData>().addShowData(show: show);
    }
  }

  Future saveActorInfoInCache({required FullActor actor}) async {
    bool thereIs = false;

    List<dynamic> actors = Get.find<CacheData>().actorsData;
    for (var isActor in actors) {
      if (isActor.id == actor.id) {
        thereIs = true;
        break;
      }
    }

    if (!thereIs) {
      Get.find<CacheData>().addActorData(actor: actor);
    }
  }

  Future saveCompanyInfoInCache({required Map company}) async {
    bool thereIs = false;

    List<dynamic> companies = Get.find<CacheData>().companiesData;
    for (Map iCompany in companies) {
      if (iCompany["id"] == company["id"]) {
        thereIs = true;
        break;
      }
    }

    if (!thereIs) {
      Get.find<CacheData>().addCompanyData(company: company);
    }
  }

  Future<FullShow?> getShowInfoFromCache({required String id}) async {
    List<dynamic> shows = Get.find<CacheData>().showData;

    for (var isShow in shows) {
      if (isShow.id == id) {
        return isShow;
      }
    }
    return null;
  }

  Future<FullShow?> getActorInfoFromCache({required String id}) async {
    List<dynamic> actors = Get.find<CacheData>().actorsData;

    for (var isActor in actors) {
      if (isActor.id == id) {
        return isActor;
      }
    }
    return null;
  }

  Future<Map?> getCompanyInfoFromCache({required String id}) async {
    List<Map> companies = Get.find<CacheData>().companiesData;

    for (Map iCompany in companies) {
      if (iCompany["id"] == id) {
        return iCompany;
      }
    }
    return null;
  }
}
