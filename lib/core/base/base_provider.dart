import 'package:poke_app/core/helper/helper.dart';
import 'package:poke_app/core/memory/memory_action.dart';
import 'package:poke_app/core/routing/routing.dart';

import '../../service/api_repository.dart';
import '../memory/shared/share_preference.dart';

mixin BaseProvider {
  final sharedPre = SharedPreference();

  final apiRep = ApiRepository();

  final helper = Helper();

  final memoryAction = MemoryAction(HiveMemoryAction());

  final globalContext = Routing.navigatorKey.currentContext;
}
