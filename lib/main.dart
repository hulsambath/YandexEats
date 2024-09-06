import 'package:yandex_eats_clone/app/view/app_view.dart';
import 'package:yandex_eats_clone/boostrap.dart';

void main() async {
  await boostrap(() {
    return const MyApp();
  });
}
