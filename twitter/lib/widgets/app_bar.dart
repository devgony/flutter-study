import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter/views/sign_up_screen.dart';

import '../constants/sizes.dart';

enum LeadingType {
  cancel,
  back,
  none;
}

extension LeadingTypeExtension on LeadingType {
  Widget intoWidget(
    BuildContext context,
  ) {
    switch (this) {
      case LeadingType.cancel:
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const SignUpScreen(),
            ),
          ),
          child: const Align(
            alignment: Alignment.center,
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.black, fontSize: Sizes.size18),
            ),
          ),
        );
      case LeadingType.back:
        return GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Icon(
                FontAwesomeIcons.arrowLeft,
                color: Colors.black,
                size: 24,
              ),
            ),
          ),
        );
      case LeadingType.none:
        return const SizedBox.shrink();
      default:
        return const SizedBox.shrink();
    }
  }
}

// intoWidget() {
//   switch (this) {
//     case LeadingType.cancel:
//       return GestureDetector(
//         onTap: () => Navigator.push(context, route)
//         child: const Align(
//           alignment: Alignment.center,
//           child: Text(
//             "Cancel",
//             style: TextStyle(color: Colors.black, fontSize: Sizes.size18),
//           ),
//         ),
//       );
//     case LeadingType.back:
//       return const Padding(
//         padding: EdgeInsets.only(left: 10.0),
//         child: Align(
//           alignment: Alignment.centerLeft,
//           child: Icon(
//             FontAwesomeIcons.arrowLeft,
//             color: Colors.black,
//             size: 24,
//           ),
//         ),
//       );
//     case LeadingType.none:
//       return null;
//   }
// }
// }

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final LeadingType leadingType;
  const AppBarWidget({
    super.key,
    required this.leadingType,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 90,
      leading: leadingType.intoWidget(context),
      title: const Icon(
        FontAwesomeIcons.twitter,
        color: Colors.blue,
        size: 32,
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
