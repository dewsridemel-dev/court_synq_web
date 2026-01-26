import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:intl/intl.dart';
import '../../services/supabase_service.dart';
import '../../models/court_booking.dart';
import '../button/primary_button.dart';

class BookingDialog extends StatefulWidget {
  final String? courtId;
  final DateTime? selectedDate;
  final String? selectedTimeSlot;
  final double? hourlyRate;

  const BookingDialog({
    super.key,
    this.courtId,
    this.selectedDate,
    this.selectedTimeSlot,
    this.hourlyRate,
  });

  @override
  State<BookingDialog> createState() => _BookingDialogState();
}

typedef OnBookingSubmit = void Function({
  required String courtId,
  required String customerName,
  required BookingStatus status,
  required String location,
  required String activity,
  required String price,
  required int startHour,
  required int endHour,
});

class _BookingDialogState extends State<BookingDialog> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _participantsController = TextEditingController();
  
  String _selectedCountryCode = '+94';
  String _selectedPaymentMethod = 'card';
  bool _isPaid = true;
  bool _isLoading = false;

  // Default values - these would come from the selected booking slot
  final String _defaultCourtId = '1'; // court_1
  final double _defaultHourlyRate = 1500.00; // 1500.00
  final String _defaultTimeSlot = ''; // 09:00 - 10:00

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _participantsController.dispose();
    super.dispose();
  }

  Duration _parseDuration(String timeSlot) {
    // Parse "09:00 - 10:00" format
    final parts = timeSlot.split(' - ');
    if (parts.length == 2) {
      final start = parts[0].split(':');
      final end = parts[1].split(':');
      if (start.length == 2 && end.length == 2) {
        final startHour = int.parse(start[0]);
        final startMinute = int.parse(start[1]);
        final endHour = int.parse(end[0]);
        final endMinute = int.parse(end[1]);
        
        final startTime = DateTime(2024, 1, 1, startHour, startMinute);
        final endTime = DateTime(2024, 1, 1, endHour, endMinute);
        
        return endTime.difference(startTime);
      }
    }
    return const Duration(hours: 1);
  }

  double _calculateTotal() {
    final duration = _parseDuration(widget.selectedTimeSlot ?? _defaultTimeSlot);
    final hours = duration.inMinutes / 60.0;
    return (widget.hourlyRate ?? _defaultHourlyRate) * hours;
  }

  Future<void> _handleConfirm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final supabaseService = Provider.of<SupabaseService>(context, listen: false);
        
        final timeSlot = widget.selectedTimeSlot ?? _defaultTimeSlot;
        final duration = _parseDuration(timeSlot);
        final parts = timeSlot.split(' - ');
        final startTimeStr = parts[0];
        final endTimeStr = parts[1];
        
        // Parse time strings to DateTime (using today's date or selected date)
        final selectedDate = widget.selectedDate ?? DateTime.now();
        final startParts = startTimeStr.split(':');
        final endParts = endTimeStr.split(':');
        
        final startTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          int.parse(startParts[0]),
          int.parse(startParts[1]),
        );
        
        final endTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          int.parse(endParts[0]),
          int.parse(endParts[1]),
        );

        await supabaseService.insertBooking(
          firstName: _firstNameController.text.trim(),
          lastName: _lastNameController.text.trim(),
          email: _emailController.text.trim(),
          phoneNumber: '$_selectedCountryCode${_phoneController.text.trim()}',
          numberOfParticipants: int.parse(_participantsController.text.trim()),
          courtId: widget.courtId ?? _defaultCourtId,
          startTime: startTime,
          endTime: endTime,
          hourlyRate: widget.hourlyRate ?? _defaultHourlyRate,
          totalAmount: _calculateTotal(),
          paymentMethod: _selectedPaymentMethod,
          isPaid: _isPaid,
        );

        if (mounted) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Booking created successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error creating booking: ${e.toString()}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final total = _calculateTotal();
    final hourlyRate = widget.hourlyRate ?? _defaultHourlyRate;
    final timeSlot = widget.selectedTimeSlot ?? _defaultTimeSlot;
    final duration = _parseDuration(timeSlot);
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    final durationText = hours > 0 
        ? '$hours hour${hours > 1 ? 's' : ''}'
        : '$minutes minute${minutes > 1 ? 's' : ''}';

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: SizedBox(
        width: 600,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                border: Border(
                  bottom: BorderSide(color: Colors.white),
                ),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Add a booking',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF09090A)
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Create a new booking for this court.',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF63748B),
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                    color: Colors.red,
                  ),
                ],
              ),
            ),
            // Form Content
            Flexible(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _firstNameController,
                                decoration: InputDecoration(
                                  labelStyle: const TextStyle(
                                    color: Color(0xFF6C727F),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  labelText: 'First name',
                                  hintText: 'Enter first name',
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(color: Color(0xFFD2D5DA), width: 1)
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter first name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: TextFormField(
                                controller: _lastNameController,
                                decoration: InputDecoration(
                                  labelText: 'Last name',
                                  labelStyle: const TextStyle(
                                    color: Color(0xFF6C727F),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  hintText: 'Enter last name',
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(color: Color(0xFFD2D5DA), width: 1)
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter last name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: const TextStyle(
                              color: Color(0xFF6C727F),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            hintText: 'Enter email',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Color(0xFFD2D5DA), width: 1)
                            ),
                            suffixIcon: const Icon(Icons.email_outlined),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter email';
                            }
                            if (!value.contains('@')) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _phoneController,
                          decoration: InputDecoration(
                            labelText: 'Phone number',
                            labelStyle: const TextStyle(
                              color: Color(0xFF6C727F),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Color(0xFFD2D5DA), width: 1)
                            ),
                            prefixIcon: CountryCodePicker(
                              onChanged: (country) {
                                setState(() {
                                  _selectedCountryCode = country.dialCode ?? '+94';
                                });
                              },
                              initialSelection: 'LK',
                              favorite: ['+94', 'LK'],
                              showCountryOnly: false,
                              showOnlyCountryWhenClosed: false,
                              alignLeft: false,
                            ),
                          ),
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter phone number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _participantsController,
                          decoration: InputDecoration(
                            labelText: 'Number of participants',
                            labelStyle: const TextStyle(
                              color: Color(0xFF6C727F),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            hintText: 'Enter number of participants',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Color(0xFFD2D5DA), width: 1)
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter number of participants';
                            }
                            if (int.tryParse(value) == null || int.parse(value) < 1) {
                              return 'Please enter a valid number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 32),
                        // Booking Details
                        const Row(
                          children: [
                            Icon(Icons.calendar_today, color: Color(0xFF262626), size: 16,),
                            SizedBox(width: 8),
                            Text(
                              'Booking details',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF262626),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F1FD),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: const Color(0xFFD7D8FB),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Price',
                                    style: TextStyle(
                                      color: Color(0xFF6E73F1),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Hourly rate (Tennis):',
                                    style: TextStyle(color: Color(0xFF63748B), fontSize: 14, fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    'Rs ${NumberFormat('#,##0.00').format(hourlyRate)}/hr',
                                    style: const TextStyle(color: Color(0xFF262626), fontSize: 14, fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Duration ',
                                    style: TextStyle(color: Color(0xFF63748B), fontSize: 14, fontWeight: FontWeight.w600),  
                                  ), // ($timeSlot)
                                  Text(
                                    durationText,
                                    style: const TextStyle(color: Color(0xFF262626), fontSize: 14, fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              const Divider(height: 24),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Total',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF262626)
                                    ),
                                  ),
                                  Text(
                                    'Rs ${NumberFormat('#,##0.00').format(total)}',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF313D4F),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Payment Method
                        const Text(
                          'Select payment method',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF262626),
                          ),
                        ),
                        const SizedBox(height: 10),
                        _PaymentMethodOption(
                          title: 'Credit/debit Card',
                          value: 'card',
                          groupValue: _selectedPaymentMethod,
                          onChanged: (value) {
                            setState(() {
                              _selectedPaymentMethod = value;
                            });
                          },
                        ),
                        const SizedBox(height: 5),
                        _PaymentMethodOption(
                          title: 'Fund transfer',
                          value: 'transfer',
                          groupValue: _selectedPaymentMethod,
                          onChanged: (value) {
                            setState(() {
                              _selectedPaymentMethod = value;
                            });
                          },
                        ),
                        const SizedBox(height: 5),
                        _PaymentMethodOption(
                          title: 'Cash payment',
                          value: 'cash',
                          groupValue: _selectedPaymentMethod,
                          onChanged: (value) {
                            setState(() {
                              _selectedPaymentMethod = value;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        // Payment Status
                        const Text(
                          'Payment status',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF262626),
                          ),
                        ),
                        const SizedBox(height: 10),
                        CheckboxListTile(
                          title: const Text(
                            'Mark as paid',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xD9000000),
                            ),
                          ),
                          value: _isPaid,
                          onChanged: (value) {
                            setState(() {
                              _isPaid = value ?? true;
                            });
                          },
                          contentPadding: EdgeInsets.zero,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Footer Buttons
            Container(
              padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
                border: Border(
                  bottom: BorderSide(color: Colors.white),
                ),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  PrimaryButton(
                    text: 'Previous',
                    onPressed: () => Navigator.of(context).pop(),
                    backgroundColor1: Color(0xFFFFFFFF),
                    backgroundColor2: Color(0xFFFFFFFF),
                    textColor: Color(0xFF000000),
                    borderColor: Color(0xFF7256B1),
                    height: 30,
                    width: 145,
                    isLoading: _isLoading,
                  ),
                  const SizedBox(width: 40),
                  PrimaryButton(
                    text: 'Confirm',
                    onPressed: _handleConfirm,
                    backgroundColor1: Color(0xFF6775DC),
                    backgroundColor2: Color(0xFF7256B1),
                    textColor: Colors.white,
                    borderColor: Color(0xFFCCCCCC),
                    height: 30,
                    width: 370,
                    isLoading: _isLoading,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PaymentMethodOption extends StatelessWidget {
  final String title;
  final String value;
  final String groupValue;
  final ValueChanged<String> onChanged;

  const _PaymentMethodOption({
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return RadioListTile<String>(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Color(0xD9000000),
        ),
      ),
      value: value,
      groupValue: groupValue,
      onChanged: (value) {
        if (value != null) onChanged(value);
      },
      contentPadding: EdgeInsets.zero,
      dense: true,
    );
  }
}