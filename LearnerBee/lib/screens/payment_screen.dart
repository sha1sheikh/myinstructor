import 'package:flutter/material.dart';
import '../models/instructor.dart';

class PaymentScreen extends StatefulWidget {
  final Instructor instructor;
  final String lessonDuration;
  final double price;

  const PaymentScreen({
    Key? key, 
    required this.instructor,
    required this.lessonDuration,
    required this.price,
  }) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int _selectedPaymentMethod = 0;
  final List<String> _paymentMethods = ['Credit/Debit Card', 'PayPal'];
  final List<String> _paymentMethodDetails = ['•••• 4582', ''];
  
  // Default lesson date and time
  DateTime selectedDate = DateTime.now().add(Duration(days: 1));
  TimeOfDay selectedTime = TimeOfDay(hour: 14, minute: 0);

  // Calculate total with booking fee and potential discount
  double get _bookingFee => 2.0;
  double get _firstLessonDiscount => 5.0;
  double get _total => widget.price + _bookingFee - _firstLessonDiscount;

  String _formatTimeRange(TimeOfDay startTime) {
    // Calculate end time based on lesson duration
    final int durationHours = int.tryParse(widget.lessonDuration.split(' ')[0]) ?? 2;
    final int endHour = (startTime.hour + durationHours) % 24;
    
    String formatTime(int hour, int minute) {
      final String period = hour >= 12 ? 'PM' : 'AM';
      final int displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
      return '$displayHour:${minute.toString().padLeft(2, '0')} $period';
    }
    
    return '${formatTime(startTime.hour, startTime.minute)}-${formatTime(endHour, startTime.minute)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF6D6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF6D6),
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Payment',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Lesson Details Section
            const Text(
              'Lesson Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: const BorderSide(color: Color(0xFFE6D9B2), width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // Instructor Avatar - using first initials if no image
                        widget.instructor.image.isNotEmpty
                            ? CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage(widget.instructor.image),
                              )
                            : CircleAvatar(
                                radius: 25,
                                backgroundColor: const Color(0xFFE6D9B2),
                                child: Text(
                                  widget.instructor.name.split(' ').take(2).map((e) => e[0]).join(''),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                        const SizedBox(width: 15),
                        // Instructor Info
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.instructor.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              widget.instructor.location,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    const Divider(color: Color(0xFFE6D9B2)),
                    const SizedBox(height: 5),
                    Text(
                      '${widget.lessonDuration} lesson: ${selectedDate.day} ${_getMonth(selectedDate.month)}, ${selectedDate.year} (${_formatTimeRange(selectedTime)})',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: selectedDate,
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(Duration(days: 90)),
                            );
                            if (picked != null) {
                              setState(() {
                                selectedDate = picked;
                              });
                            }
                          },
                          child: const Text(
                            'Change Date',
                            style: TextStyle(color: Color(0xFF8B6D47)),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            final TimeOfDay? picked = await showTimePicker(
                              context: context,
                              initialTime: selectedTime,
                            );
                            if (picked != null) {
                              setState(() {
                                selectedTime = picked;
                              });
                            }
                          },
                          child: const Text(
                            'Change Time',
                            style: TextStyle(color: Color(0xFF8B6D47)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            // Payment Summary Section
            const Text(
              'Payment Summary',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: const BorderSide(color: Color(0xFFE6D9B2), width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    // Payment Items
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${widget.lessonDuration} driving lesson'),
                        Text('£${widget.price.toStringAsFixed(2)}'),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Booking fee'),
                        Text('£${_bookingFee.toStringAsFixed(2)}'),
                      ],
                    ),
                    const SizedBox(height: 15),
                    const Divider(color: Color(0xFFE6D9B2)),
                    const SizedBox(height: 15),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Discount (first lesson)'),
                        Text('-£5.00'),
                      ],
                    ),
                    const SizedBox(height: 15),
                    const Divider(color: Color(0xFFE6D9B2)),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          '£${_total.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            // Payment Method Section
            const Text(
              'Payment Method',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            
            // Payment Method Cards
            ...List.generate(
              _paymentMethods.length,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(
                      color: _selectedPaymentMethod == index 
                        ? const Color(0xFF8B6D47) 
                        : const Color(0xFFE6D9B2),
                      width: _selectedPaymentMethod == index ? 2 : 1,
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _selectedPaymentMethod = index;
                      });
                    },
                    borderRadius: BorderRadius.circular(15),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          // Radio Button
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: _selectedPaymentMethod == index 
                                  ? const Color(0xFF8B6D47) 
                                  : const Color(0xFFE6D9B2),
                                width: 2,
                              ),
                            ),
                            child: _selectedPaymentMethod == index
                              ? const Center(
                                  child: CircleAvatar(
                                    radius: 6,
                                    backgroundColor: Color(0xFF8B6D47),
                                  ),
                                )
                              : null,
                          ),
                          const SizedBox(width: 15),
                          // Payment Method Name
                          Text(
                            _paymentMethods[index],
                            style: const TextStyle(fontSize: 16),
                          ),
                          const Spacer(),
                          // Card Details if available
                          if (_paymentMethodDetails[index].isNotEmpty)
                            Text(
                              _paymentMethodDetails[index],
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            
            // Cancellation Policy
            const SizedBox(height: 15),
            const Text(
              'By proceeding, you agree to our cancellation policy.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'Cancellations within 24 hours incur a 50% fee.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 30),
            
            // Pay Now Button
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  // Process payment
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Payment Successful'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Your lesson has been booked successfully!'),
                          const SizedBox(height: 16),
                          Text(
                            'Instructor: ${widget.instructor.name}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Date: ${selectedDate.day} ${_getMonth(selectedDate.month)}, ${selectedDate.year}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Time: ${_formatTimeRange(selectedTime)}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop(); // Return to instructor detail
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8B6D47),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Pay £${_total.toStringAsFixed(2)} Now',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_back),
            label: '',
          ),
        ],
      ),
    );
  }
  
  // Helper method to convert month number to name
  String _getMonth(int month) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June', 
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }
}