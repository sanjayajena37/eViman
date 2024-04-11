import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../widgets/common_appbar_view.dart';
import '../../../widgets/remove_focuse.dart';
import '../controllers/galleryscreen_controller.dart';
import '../details_page.dart';

class GalleryscreenView extends GetView<GalleryscreenController> {
  GalleryscreenView({Key? key}) : super(key: key);


  @override
  GalleryscreenController controller =
  Get.put<GalleryscreenController>(GalleryscreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RemoveFocuse(
        onClick: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CommonAppbarView(
              iconData: Icons.arrow_back,
              onBackClick: () {
                Navigator.pop(context);
              },
              titleText: "Gallery",
            ),
            GetBuilder<GalleryscreenController>(
              assignId: true,
              id: "ref",
              builder: (logic) {
                return Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 3,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        return RawMaterialButton(
                          onPressed: () {
                            /*Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailsPage(
                                      imagePath: controller.galleryModel
                                          ?.gallery?[index].image ?? "",
                                      index: index,
                                    ),
                              ),
                            );*/
                          },
                          child: Hero(
                            tag: 'logo$index',
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      controller.galleryModel?.gallery?[index]
                                          .image ?? ""),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: controller.galleryModel?.gallery?.length,
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
