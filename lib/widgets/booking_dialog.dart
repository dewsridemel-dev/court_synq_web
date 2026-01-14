import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:intl/intl.dart';
import '../services/supabase_service.dart';

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

class _BookingDialogState extends State<BookingDialog> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController(text: 'yourmail@gmail.com');
  final _phoneController = TextEditingController(text: '79123456');
  final _participantsController = TextEditingController();
  
  String _selectedCountryCode = '+94';
  String _selectedPaymentMethod = 'card';
  bool _isPaid = true;
  bool _isLoading = false;

  // Default values - these would come from the selected booking slot
  final String _defaultCourtId = 'court_1';
  final double _defaultHourlyRate = 1500.00;
  final String _defaultTimeSlot = '09:00 - 10:00';

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
      child: Container(
        width: 600,
        constraints: const BoxConstraints(maxHeight: 800),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey.shade200),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Add a booking',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Create a new booking for this court.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
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
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Booking Information
                      const Text(
                        'Booking Information',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _firstNameController,
                              decoration: InputDecoration(
                                labelText: 'First name',
                                hintText: 'Enter first name',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
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
                                hintText: 'Enter last name',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
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
                          hintText: 'Enter email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
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
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
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
                          hintText: 'Enter number of participants',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
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
                      Row(
                        children: [
                          Icon(Icons.calendar_today, color: Colors.purple),
                          const SizedBox(width: 8),
                          const Text(
                            'Booking details',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Price'),
                                Text(
                                  'Hourly rate (Tennis):',
                                  style: TextStyle(color: Colors.grey.shade600),
                                ),
                                Text(
                                  'Rs ${NumberFormat('#,##0.00').format(hourlyRate)}/hr',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Duration '), // ($timeSlot)
                                Text(
                                  durationText,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
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
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Rs ${NumberFormat('#,##0.00').format(total)}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.purple,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      // Payment Method
                      const Text(
                        'Select payment method',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
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
                      const SizedBox(height: 8),
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
                      const SizedBox(height: 8),
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
                      const SizedBox(height: 32),
                      // Payment Status
                      const Text(
                        'Payment status',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      CheckboxListTile(
                        title: const Text('Mark as paid'),
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
            // Footer Buttons
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey.shade200),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 12,
                      ),
                      side: BorderSide(color: Colors.grey.shade300),
                    ),
                    child: const Text('Previous'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _handleConfirm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 12,
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Text('Confirm'),
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
      title: Text(title),
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