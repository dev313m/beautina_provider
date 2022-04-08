
import 'package:beautina_provider/blocks/all_services/block_all_services_repo.dart';
import 'package:beautina_provider/constants/app_colors.dart';
import 'package:beautina_provider/core/global_values/responsive/salon_services_cart.dart';
import 'package:beautina_provider/core/models/response/model_service.dart';
import 'package:beautina_provider/utils/size/edge_padding.dart';
import 'package:beautina_provider/utils/ui/space.dart';
import 'package:beautina_provider/utils/ui/text.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

final categoryListColors = [Colors.lightBlue, Colors.teal];
const maximumListColorIndex = 1;
int colorListIndex = 0;

class BlockAllServices extends StatefulWidget {
  const BlockAllServices({Key? key}) : super(key: key);

  @override
  State<BlockAllServices> createState() => _BlockAllServicesState();
}

class _BlockAllServicesState extends State<BlockAllServices> {
  late BlockAllServicesRepo _blockAllServicesRepo;
  @override
  void initState() {
    _blockAllServicesRepo = BlockAllServicesRepo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          Container(
            height: ScreenUtil().setHeight(200),
            decoration: BoxDecoration(
              color: AppColors.blue,
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 6.0),
                child: GWdgtTextTitle(
                  string: "خدمات الصالون",
                  // fontColor: ExtendedText.brightColor,
                  // fontSize: ExtendedText.bigFont,
                ),
              ),
            ),
          ),
          const Y(),
          SizedBox(
            height: 270,
            child: Obx(() {
              // var globalValAllServices = Get.find<GlobalValAllServices>();
              return AnimatedSwitcher(
                duration: const Duration(seconds: 1),
                child: _blockAllServicesRepo.isLoadError()
                    ? Center(
                        child: IconButton(
                            icon: Icon(
                              CommunityMaterialIcons.refresh,
                              size: ScreenUtil().setSp(55),
                              color: AppColors.blue,
                            ),
                            onPressed: () =>
                                _blockAllServicesRepo.reLoadServices),
                      )
                    : _blockAllServicesRepo.isLoading()
                        ? const CircularProgressIndicator()
                        : Column(
                            children: [
                              // SizedBox(height: 200),
                              ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(radiusDefault),
                                  child: ShaderMask(
                                    shaderCallback: (rect) {
                                      return LinearGradient(
                                        begin: Alignment.center,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.transparent,
                                          Colors.transparent,
                                          AppColors.purpleColor
                                        ],
                                      ).createShader(Rect.fromLTRB(
                                          0, 0, rect.width, rect.height));
                                    },
                                    blendMode: BlendMode.xor,
                                    child: Container(
                                      child: Column(
                                        children: <Widget>[
                                          SizedBox(
                                            height: 270,
                                            child: ListView.builder(
                                              itemCount: _blockAllServicesRepo
                                                  .getRootNodes()
                                                  .length,

                                              // shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              padding: const EdgeInsets.only(
                                                  bottom: 50),
                                              addRepaintBoundaries: true,
                                              addAutomaticKeepAlives: true,
                                              // physics: NeverScrollableScrollPhysics(),
                                              itemBuilder: (_, index) {
                                                List<ModelService> rootNodes =
                                                    _blockAllServicesRepo
                                                        .getRootNodes();
                                                var rootDirectChild =
                                                    rootNodes[index]
                                                        .children
                                                        .where((element) =>
                                                            !element.isCategory)
                                                        .toList();
                                                return Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 5,
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Image.asset(
                                                            _blockAllServicesRepo
                                                                    .servicesIcons +
                                                                rootNodes[index]
                                                                    .code +
                                                                '.png',
                                                            height: 180.h,
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              const GWdgtTextTitle(
                                                                  string:
                                                                      'نوع الخدمة'),
                                                              const Y(),
                                                              const Y(),
                                                              GWdgtTextTitleDesc(
                                                                  textAlign:
                                                                      TextAlign
                                                                          .right,
                                                                  string: rootNodes[
                                                                          index]
                                                                      .arName),
                                                            ],
                                                          ),
                                                          const Expanded(
                                                              child: SizedBox())
                                                        ],
                                                      ),
                                                    ),
                                                    Y(),
                                                    AllServicesCategory(
                                                        rootService:
                                                            rootNodes[index]),
                                                    if (rootDirectChild
                                                        .isNotEmpty)
                                                      SizedBox(
                                                        height: 150.h,
                                                        child: ListView(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                const AllServicesSingleCategory(
                                                                  title:
                                                                      'خدمات اخرى',
                                                                ),
                                                                AllServicesLeaves(
                                                                    parentNode:
                                                                        rootNodes[
                                                                            index],
                                                                    leaves: rootNodes[
                                                                            index]
                                                                        .children
                                                                        .where((element) =>
                                                                            !element.isCategory)
                                                                        .toList()),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    SizedBox(
                                                      height: 15,
                                                    )
                                                  ],
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                          color: AppColors.purpleColor,
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                    ),
                                  )),
                            ],
                          ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class AllServicesDirectLeaves extends StatelessWidget {
  final List<ModelService> leaves;

  const AllServicesDirectLeaves({Key? key, required this.leaves})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class AllServicesCategory extends StatelessWidget {
  final ModelService rootService;
  const AllServicesCategory({Key? key, required this.rootService})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Text('data');
    final color = getColor();

    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(0),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, index) {
        return SizedBox(
          height: 150.h,
          // width: 600,
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.end,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(0),
              children: [
                // if (!rootService.isRoot)
                AllServicesSingleCategory(
                  color: color,
                  title: rootService.children[index].arName,
                ),
                // if (rootService.isRoot) Image.asset('assets/images/hair_icon.png'),
                AllServicesLeaves(
                  leaves: rootService.children[index].children,
                  parentNode: rootService,
                  color: color,
                ),
              ],
            ),
          ),
        );
      },
      itemCount:
          rootService.children.where((element) => element.isCategory).length,
    );
  }

  getColor() {
    if (rootService.isRoot) return null;
    if (colorListIndex == maximumListColorIndex)
      colorListIndex = 0;
    else
      colorListIndex++;
    return categoryListColors[colorListIndex];
  }
}

class AllServicesSingleCategory extends StatelessWidget {
  final String? title;
  final Color? color;
  const AllServicesSingleCategory({Key? key, this.title, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              color: color ?? AppColors.pinkOpcity,
              borderRadius: BorderRadius.circular(25)),
          padding: EdgeInsets.only(left: 170.h / 3, right: 170.h / 3),
          width: 400.h,
          height: 150.h,
          child: Center(
            child: GWdgtTextTitleDesc(
              string: title,
            ),
          ),
        ),
      ],
    );
  }
}

class AllServicesLeaves extends StatelessWidget {
  final List<ModelService> leaves;
  final Color? color;
  final ModelService parentNode;
  const AllServicesLeaves(
      {Key? key, required this.leaves, this.color, required this.parentNode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final notCategoryLeaves = leaves.where((e) => !e.isCategory).toList();
    return Row(
        children: List.generate(leaves.length, (index) {
      // if (leaves[index].isCategory)
      //   return AllServicesCategory(
      //     rootService: leaves[index],
      //   );
      // return SizedBox();
      return SingleWidget(
        modelService: leaves[index],
        borderRadius: BorderRadius.circular(30),
        borderWidth: 2,
        parentNode: parentNode,
        color: color ?? AppColors.blue,
        width: 120.h,
      );
    }));
  }
}

class SingleWidget extends StatefulWidget {
  final ModelService modelService;
  final Color color;
  final double? width;
  final double borderWidth;
  final BorderRadius borderRadius;
  final ModelService parentNode;
  const SingleWidget({
    required this.width,
    required this.parentNode,
    required this.borderWidth,
    required this.borderRadius,
    required this.color,
    required this.modelService,
  });
  @override
  _SingleWidget createState() => _SingleWidget();
}

class _SingleWidget extends State<SingleWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  int? alpha;
  @override
  void initState() {
    super.initState();

    Get.find<GlobalValSalonServicesCart>().salonServicesCart.listen((p0) {
      updateState();
    });

    _controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    alpha = (_animation.value * 255).toInt();
    Get.find<GlobalValSalonServicesCart>()
            .salonServicesCart
            .contains(widget.modelService.code)
        ? _controller.value = 255.0
        : _controller.value = 0.22;
  }

  updateState() {
    var globalValSalonServicesCart = Get.find<GlobalValSalonServicesCart>();
    if (globalValSalonServicesCart.salonServicesCart
        .contains(widget.modelService.code)) {
      // setState(() {
      //   _controller.forward();

      //   // widget.onChangeFunction(
      //   //     widget.selectionList?..remove(widget.itemCode));
      // });
    } else {
      setState(() {
        _controller.reverse();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // return GWdgtTextDescDesc(string: widget.itemCode);
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        return GestureDetector(
            onTap: () {
              var globalValSalonServicesCart =
                  Get.find<GlobalValSalonServicesCart>();
              if (globalValSalonServicesCart.salonServicesCart
                  .contains(widget.modelService.code)) {
                setState(() {
                  globalValSalonServicesCart.removeService(
                      code: widget.modelService.code);
                  _controller.reverse();
                  // widget.onChangeFunction(
                  //     widget.selectionList?..remove(widget.itemCode));
                });
              } else {
                setState(() {
                  _controller.forward();
                  globalValSalonServicesCart.addService(
                      code: widget.modelService.code);
                });
              }
            },
            child: Container(
                padding: EdgeInsets.only(left: 170.h / 3, right: 170.h / 2),
                // width: widget.width,
                height: 170.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: widget.borderRadius,
                  color: widget.color.withOpacity(0.2).withAlpha(
                      (_controller.value * 255 == 0
                              ? 255 * 0.22
                              : _controller.value * 255)
                          .toInt()),
                  // border: Border.all(
                  //   color: widget.color
                  //       .withOpacity(0.2)
                  //       .withAlpha(255 - (_controller.value.toInt() * 255)),
                  //   width: widget.borderWidth,
                  // )
                ),
                child: GWdgtTextDescDesc(string: widget.modelService.arName)));
      },
    );
  }
}
