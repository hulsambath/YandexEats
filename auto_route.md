## How To Setup
#### 1. Create a view and implement @RoutePage() on it:
```dart
library your_screen;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

part 'your_adaptive.dart';

@RoutePage()
class YourView extends StatelessWidget {
  const YourView({super.key});

  @override
  Widget build(BuildContext context) {
    return const YourtAdaptive();
  }
}

```

#### 2. Generate Route:
In bash command:
```bash
dart run build_runner build -d
```
#### 3. Add Auto Route of your Page to App Router
In `lib\core\routes\routers\routers.dart`, add page router to routers:
```dart
final routers = [
  AutoRoute(
    path: '/',
    page: ViewRoute.page,
    ),
];
```

## References:
- [Auto Route](https://pub.dev/documentation/auto_route/latest/)
