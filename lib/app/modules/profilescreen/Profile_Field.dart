import 'package:flutter/material.dart';

import '../../widgets/CustomeTittleText.dart';
import '../../widgets/Textfield_widget.dart';

class Profile_Field extends StatelessWidget {
  String? tittle;
  String? hitText;
  Profile_Field({required this.tittle, required this.hitText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12, left: 12, bottom: 05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomeSubTittleText(
            text: tittle!,
            textsize: 13,
            color: Colors.grey.shade500,
          ),
          SizedBox(
            height: 05,
          ),
          Textfield_widget(
              isOutlineBorder: true,
              isEnabled: false,
              validator: (_) {},
              hint: hitText),
          SizedBox(
            height: 05,
          )
        ],
      ),
    );
  }
}