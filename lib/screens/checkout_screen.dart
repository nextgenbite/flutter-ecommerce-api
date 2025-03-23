import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../models/shipping_cost.dart';
import '../providers/cart_provider.dart';
import '../providers/order_provider.dart';
import '../providers/shipping_cost_provider.dart';
import '../widgets/app_bottom_bar.dart';
import '../widgets/custom_app_bar.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ShippingCostProvider>(
        context,
        listen: false,
      ).fetchShippingCost();
      Provider.of<CartProvider>(context, listen: false).fetchCart();
    });
  }

  final _formKey = GlobalKey<FormState>();
  int _activeCurrentStep = 0;
  double? _selectedShippingCost;
  String _selectedRadio = 'bkash';
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController phone = TextEditingController();
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final cartProvider = Provider.of<CartProvider>(context, listen: false);
      final orderProvider = Provider.of<OrderProvider>(context, listen: false);
      var order = {
        "name": name.text,
        "phone": phone.text,
        "address": address.text,
        "shipping_cost": _selectedShippingCost ?? 0.0,
        "payment_method": _selectedRadio,
        'total': cartProvider.cart?.total ?? 0,
        'discount': 0,
        "carts":
            cartProvider.cart != null
                ? cartProvider.cart!.items
                    .map((cartItem) => cartItem.toJson())
                    .toList()
                : [],
      };

      // Call the store method to submit the order
      orderProvider.store(order);

      // Show confirmation dialog
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text('Order Confirmed'),
              content: Text(
                "Name: ${name.text}\n"
                "Phone: ${phone.text}\n"
                "Address: ${address.text}\n"
                "Shipping Cost: \$${_selectedShippingCost ?? 'Not selected'}\n"
                "Payment Method: $_selectedRadio",
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            ),
      );
    }
  }

  List<Step> stepList(
    List<ShippingCost> shippingCosts,
    bool isLoading,
    cart,
  ) => [
    Step(
      state: _activeCurrentStep <= 0 ? StepState.editing : StepState.complete,
      isActive: _activeCurrentStep >= 0,
      title: Text('Account', style: TextStyle(fontSize: 14.sp)),
      content: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: name,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Full Name',
                labelStyle: TextStyle(fontSize: 14.sp),
              ),
              validator: (value) => value!.isEmpty ? 'Enter your name' : null,
            ),
            SizedBox(height: 8.h),
            TextFormField(
              controller: phone,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Phone',
                labelStyle: TextStyle(fontSize: 14.sp),
              ),
              validator: (value) => value!.isEmpty ? 'Enter your phone' : null,
            ),
            SizedBox(height: 8.h),
            TextFormField(
              controller: address,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Full House Address',
                labelStyle: TextStyle(fontSize: 14.sp),
              ),
              validator:
                  (value) => value!.isEmpty ? 'Enter your address' : null,
            ),
            SizedBox(height: 8.h),
            isLoading
                ? CircularProgressIndicator()
                : DropdownButtonFormField<double>(
                  value: _selectedShippingCost,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Shipping Charge',
                    labelStyle: TextStyle(fontSize: 14.sp),
                  ),
                  items:
                      shippingCosts
                          .map(
                            (cost) => DropdownMenuItem(
                              value: cost.cost, // Storing cost as value
                              child: Text(
                                "${cost.title} - \$${cost.cost}",
                                style: TextStyle(fontSize: 14.sp),
                              ),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedShippingCost = value;
                    });
                  },
                ),

            SizedBox(height: 8.h),
          ],
        ),
      ),
    ),
    Step(
      state: _activeCurrentStep <= 1 ? StepState.editing : StepState.complete,
      isActive: _activeCurrentStep >= 1,
      title: Text('Payment', style: TextStyle(fontSize: 14.sp)),
      content: Column(
        children: [
          RadioListTile(
            title: Image.asset('assets/images/bkash.png', height: 50.h),
            value: 'bkash',
            groupValue: _selectedRadio,
            onChanged: (String? value) {
              setState(() {
                _selectedRadio = value!;
              });
            },
          ),
          RadioListTile(
            title: Image.asset('assets/images/nagad.png', height: 50.h),
            value: 'Nogod',
            groupValue: _selectedRadio,
            onChanged: (String? value) {
              setState(() {
                _selectedRadio = value!;
              });
            },
          ),

          RadioListTile(
            title: Image.asset('assets/images/cod.png', height: 50.h),
            value: 'cash_on_delivary',
            groupValue: _selectedRadio,
            onChanged: (String? value) {
              setState(() {
                _selectedRadio = value!;
              });
            },
          ),
        ],
      ),
    ),
    Step(
      state: StepState.complete,
      isActive: _activeCurrentStep >= 2,
      title: Text('Confirm', style: TextStyle(fontSize: 14.sp)),
      content: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name: ${name.text}', style: TextStyle(fontSize: 14.sp)),
              Text('Phone: ${phone.text}', style: TextStyle(fontSize: 14.sp)),
              Text(
                'Address: ${address.text}',
                style: TextStyle(fontSize: 14.sp),
              ),
              SizedBox(height: 40.h),
              const Divider(color: Colors.grey),
              SizedBox(height: 5.h),
              Row(
                children: [
                  Text(
                    'Subtotal:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Expanded(child: Container()),
                  Text(
                    '\$${cart?.subtotal ?? 0.00}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              SizedBox(height: 5.h),
              Row(
                children: [
                  Text(
                    'Discount:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Expanded(child: Container()),
                  Text(
                    '\$0.00',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              if (_selectedShippingCost != null)
                Row(
                  children: [
                    Text(
                      'Shipping Charge:',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Expanded(child: Container()),
                    Text(
                      '\$$_selectedShippingCost',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              Row(
                children: [
                  Text(
                    'Total Price:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Expanded(child: Container()),
                  Text(
                    '\$${(cart?.subtotal ?? 0) + (_selectedShippingCost ?? 0)}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final shippingCostProvider = Provider.of<ShippingCostProvider>(context);
    final shippingCosts = shippingCostProvider.shippingCosts;
    final cartProvider = Provider.of<CartProvider>(context);
    final cart = cartProvider.cart;
    final isLoading = shippingCostProvider.isLoading;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: CustomAppBar(
        title: 'Checkout',
        isHome: true,
        onCartTap: () {
          Navigator.of(context).pushReplacementNamed('/cart');
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.only(
              left: 6,
              right: 6,
              bottom: 80,
              top: 20,
            ),
            margin: const EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Stepper(
              elevation: 0,
              type: StepperType.horizontal,
              currentStep: _activeCurrentStep,
              steps: stepList(shippingCosts, isLoading, cart),
              onStepContinue: () {
                if (_formKey.currentState!.validate()) {
                  if (_activeCurrentStep <
                      stepList(shippingCosts, isLoading, cart).length - 1) {
                    setState(() {
                      _activeCurrentStep += 1;
                    });
                  } else {
                    _submitForm();
                  }
                }
              },
              onStepCancel:
                  _activeCurrentStep == 0
                      ? null
                      : () {
                        setState(() {
                          _activeCurrentStep -= 1;
                        });
                      },
              onStepTapped: (int index) {
                setState(() {
                  _activeCurrentStep = index;
                });
              },
            ),
          ),
        ),
      ),
      bottomNavigationBar: AppBottomBar(currentIndex: 0),
    );
  }
}
