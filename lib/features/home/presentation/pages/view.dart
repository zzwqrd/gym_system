import 'package:flutter/material.dart';
import 'package:gym_system/core/utils/ui_extensions/extensions_init.dart';

import '../widgets/category_item.dart';
import '../widgets/legend_item.dart';
import '../widgets/recent_item.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      'Good Morning'.withStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      4.verticalSpace,
                      Row(
                        children: [
                          'Firgia'.withStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          4.horizontalSpace,
                          '👋'.withStyle(fontSize: 18),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.search, color: Colors.black54),
                  ).container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                  ),
                ],
              ),
              30.verticalSpace,

              // Storage Usage
              Column(
                    children: [
                      SizedBox(
                        height: 150,
                        width: 150,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CircularProgressIndicator(
                              value: 0.52,
                              strokeWidth: 2,
                              backgroundColor: Colors.grey.shade100,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.blue,
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                '52%'.withStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                                'used'.caption,
                              ],
                            ),
                          ],
                        ),
                      ),
                      20.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LegendItem(
                            color: Colors.grey.shade300,
                            size: '75 GB',
                            label: 'free',
                          ),
                          20.horizontalSpace,
                          const LegendItem(
                            color: Colors.blue,
                            size: '84 GB',
                            label: 'used',
                          ),
                        ],
                      ),
                    ],
                  )
                  .paddingAll(20)
                  .container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                  ),
              30.verticalSpace,

              // Categories
              'Category'.withStyle(fontSize: 18, fontWeight: FontWeight.bold),
              15.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CategoryItem(
                    icon: Icons.description,
                    label: 'Docs',
                    bgColor: Colors.green.shade100,
                    iconColor: Colors.green,
                  ),
                  CategoryItem(
                    icon: Icons.image,
                    label: 'Images',
                    bgColor: Colors.blue.shade100,
                    iconColor: Colors.blue,
                  ),
                  CategoryItem(
                    icon: Icons.play_circle,
                    label: 'Videos',
                    bgColor: Colors.pink.shade100,
                    iconColor: Colors.pink,
                  ),
                  CategoryItem(
                    icon: Icons.music_note,
                    label: 'Music',
                    bgColor: Colors.orange.shade100,
                    iconColor: Colors.orange,
                  ),
                ],
              ),
              30.verticalSpace,

              // Recent
              'Recent'.withStyle(fontSize: 18, fontWeight: FontWeight.bold),
              15.verticalSpace,
              const RecentItem(
                name: 'powerpoint.pptx',
                size: '4.77 MB',
                icon: Icons.description,
                iconColor: Colors.orange,
              ),
              10.verticalSpace,
              const RecentItem(
                name: 'word.docx',
                size: '9.54 MB',
                icon: Icons.description,
                iconColor: Colors.blue,
              ),
              10.verticalSpace,
              const RecentItem(
                name: 'access.accdb',
                size: '25.4 MB',
                icon: Icons.description,
                iconColor: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
