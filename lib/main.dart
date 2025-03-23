import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'providers/cart_provider.dart';
import 'providers/homepage_provider.dart';
import 'providers/order_provider.dart';
import 'providers/product_provider.dart';
import 'providers/shipping_cost_provider.dart';
import 'routes/app_router.dart';

void main() {
  // runApp(MyApp());

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => HomepageProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => ShippingCostProvider()),
        ChangeNotifierProvider(create: (context) => OrderProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
            useMaterial3: true,
          ),
          title: 'E-Commerce App',
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: '/',
        );
      },
    );
  }
}
