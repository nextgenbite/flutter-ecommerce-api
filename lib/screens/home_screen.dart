import 'package:ecommerce/constants/config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/homepage_provider.dart';
import '../widgets/app_bottom_bar.dart';
import '../widgets/app_drawer.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/hero_slider.dart';
import '../widgets/product_section.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () =>
          Provider.of<HomepageProvider>(
            // ignore: use_build_context_synchronously
            context,
            listen: false,
          ).fetchHomepageData(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final homepageProvider = Provider.of<HomepageProvider>(context);
    final trendingProducts = homepageProvider.trendingProducts;
    final sliders = homepageProvider.sliders;
    final categories = homepageProvider.categories;
    final latestProducts = homepageProvider.latestProducts;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Nextgen Shop',
        isHome: true,
        onCartTap: () {
          Navigator.of(context).pushReplacementNamed('/cart');
        },
      ),
      drawer: AppDrawer(),
      body: SafeArea(
        child:
            homepageProvider.isLoading
                ? SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Center(child: CircularProgressIndicator()),
                )
                : SingleChildScrollView(
                  child: Column(
                    children: [
                      // Hero Slider
                      HeroSlider(sliders: sliders),
                      SizedBox(height: 10.h),
                      SizedBox(
                        height: 120.h,
                        width: double.infinity,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            final category = categories[index];
                            return Container(
                              margin: EdgeInsets.only(right: 10.w),
                              child: GestureDetector(
                                onTap:
                                    () => {
                                      // ignore: avoid_print
                                      print(
                                        "Selected Category: ${category.title}",
                                      ),
                                    },
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 30.r,
                                      backgroundImage:
                                          category.thumbnail.isNotEmpty
                                              ? CachedNetworkImageProvider(
                                                Config.apiUrl +
                                                    category.thumbnail,
                                              )
                                              : AssetImage(
                                                'assets/images/placeholder.jpg',
                                              ),
                                    ),
                                    SizedBox(height: 8.h),
                                    Text(
                                      category.title,
                                      style: TextStyle(fontSize: 10.sp),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      SizedBox(height: 10.h),

                      // Trending Products
                      ProductSection(
                        products: trendingProducts,
                        title: 'New Products',
                      ),

                      SizedBox(height: 10.h),

                      // Latest Products
                      ProductSection(
                        products: latestProducts,
                        title: "Latest Products",
                      ),
                    ],
                  ),
                ),
      ),

      bottomNavigationBar: AppBottomBar(
        currentIndex: 0,
        // onTap: _onItemTapped,
      ),
    );
  }
}
