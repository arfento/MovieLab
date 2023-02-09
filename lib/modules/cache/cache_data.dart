import 'package:get/get.dart';
import 'package:movie_lab/models/item_models/actor_models/full_actor_model.dart';
import 'package:movie_lab/models/item_models/show_models/full_show_model.dart';

class CacheData extends GetxController {
  List<FullShow> showData = [];
  List<FullActor> actorsData = [];
  List<Map> companiesData = [];

  addShowData({required FullShow show}) {
    showData.add(show);
    update();
  }

  addActorData({required FullActor actor}) {
    actorsData.add(actor);
    update();
  }

  addCompanyData({required Map company}) {
    companiesData.add(company);
    update();
  }
}
