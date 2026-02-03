import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class BusinessDialog extends StatefulWidget {
  const BusinessDialog({Key? key}) : super(key: key);

  @override
  State<BusinessDialog> createState() => _BusinessDialogState();
}

class _BusinessDialogState extends State<BusinessDialog> {
  final _formKey = GlobalKey<FormState>();
  
  // Controllers
  final _businessNameController = TextEditingController(text: 'Elite Sports Club');
  final _registrationNumberController = TextEditingController();
  final _emailController = TextEditingController(text: 'info@elitesportsclub.com');
  final _phoneController = TextEditingController(text: '+94 79123456');
  final _websiteController = TextEditingController(text: 'https://elitesportsclub.com');
  final _addressController = TextEditingController(text: '123 Tennis Lane, Rajagirilla Road, Kurunegala');
  final _cityController = TextEditingController(text: 'Kurunegala');
  final _provinceController = TextEditingController(text: 'Central');

  String _selectedCountryCode = '+94';
  List<String> _uploadedFiles = [];

  @override
  void dispose() {
    _businessNameController.dispose();
    _registrationNumberController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _websiteController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _provinceController.dispose();
    super.dispose();
  }

  Future<void> _pickDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
    );

    if (result != null) {
      setState(() {
        _uploadedFiles.addAll(result.files.map((file) => file.name));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
            ),
        ),
        body: SingleChildScrollView(
            child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
                key: _formKey,
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    // Header
                    const Text(
                    'Business Information',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                    ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                    'Update your business details',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                    ),
                    ),
                    const SizedBox(height: 32),

                    // Business Name and Registration Number Row
                    Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Expanded(
                        child: _buildTextField(
                            label: 'Business Name',
                            controller: _businessNameController,
                            isRequired: true,
                        ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                        child: _buildTextField(
                            label: 'Business Registration Number',
                            controller: _registrationNumberController,
                            hintText: 'Enter business registration number',
                        ),
                        ),
                    ],
                    ),
                    const SizedBox(height: 20),

                    // Business Email
                    _buildTextField(
                    label: 'Business E-mail',
                    controller: _emailController,
                    isRequired: true,
                    suffixIcon: Icons.email_outlined,
                    ),
                    const SizedBox(height: 20),

                    // Business Phone Number
                    _buildPhoneField(),
                    const SizedBox(height: 20),

                    // Website
                    _buildTextField(
                    label: 'Website',
                    controller: _websiteController,
                    isRequired: true,
                    suffixIcon: Icons.link,
                    ),
                    const SizedBox(height: 20),

                    // Business Address
                    _buildTextField(
                    label: 'Business Address',
                    controller: _addressController,
                    isRequired: true,
                    ),
                    const SizedBox(height: 20),

                    // City and Province Row
                    Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Expanded(
                        child: _buildTextField(
                            label: 'City',
                            controller: _cityController,
                            isRequired: true,
                        ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                        child: _buildTextField(
                            label: 'Province',
                            controller: _provinceController,
                            isRequired: true,
                        ),
                        ),
                    ],
                    ),
                    const SizedBox(height: 40),

                    // Business Documents Section
                    const Text(
                    'Business Documents',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                    ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                    'Upload and manage your business registration and tax documents',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                    ),
                    ),
                    const SizedBox(height: 24),

                    // Upload Document Button
                    SizedBox(
                    width: 200,
                    child: ElevatedButton.icon(
                        onPressed: _pickDocument,
                        icon: const Icon(Icons.upload_file, size: 18),
                        label: const Text('Upload Document'),
                        style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6366F1),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                        ),
                        ),
                    ),
                    ),
                    const SizedBox(height: 24),

                    // Required Documents Notice
                    Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: const Color(0xFFFEF3C7),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                        color: const Color(0xFFFBBF24),
                        width: 1,
                        ),
                    ),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        const Icon(
                            Icons.info_outline,
                            color: Color(0xFFD97706),
                            size: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                            child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                const Text(
                                'Required Documents :',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF92400E),
                                ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                'Business Registration, Tax Registration Certificate, and billing proof are required for verification. Documents should be current and clearly readable.',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey[800],
                                    height: 1.4,
                                ),
                                ),
                            ],
                            ),
                        ),
                        ],
                    ),
                    ),

                    // Display uploaded files
                    if (_uploadedFiles.isNotEmpty) ...[
                    const SizedBox(height: 20),
                    ..._uploadedFiles.map((file) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                        children: [
                            const Icon(Icons.description, size: 20, color: Colors.grey),
                            const SizedBox(width: 8),
                            Expanded(child: Text(file)),
                            IconButton(
                            icon: const Icon(Icons.close, size: 20),
                            onPressed: () {
                                setState(() {
                                _uploadedFiles.remove(file);
                                });
                            },
                            ),
                        ],
                        ),
                    )).toList(),
                    ],
                ],
                ),
            ),
            ),
        ),
        )
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    bool isRequired = false,
    String? hintText,
    IconData? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            if (isRequired)
              const Text(
                ' *',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.grey[400],
              fontSize: 14,
            ),
            suffixIcon: suffixIcon != null
                ? Icon(suffixIcon, color: Colors.grey, size: 20)
                : null,
            filled: true,
            fillColor: Colors.grey[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Color(0xFF6366F1)),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
          ),
          validator: isRequired
              ? (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is required';
                  }
                  return null;
                }
              : null,
        ),
      ],
    );
  }

  Widget _buildPhoneField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Text(
              'Business Phone number',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            Text(
              ' *',
              style: TextStyle(
                color: Colors.red,
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            // Country Code Dropdown
            Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(6),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedCountryCode,
                  icon: const Icon(Icons.arrow_drop_down, size: 20),
                  items: ['+94', '+1', '+44', '+91']
                      .map((code) => DropdownMenuItem(
                            value: code,
                            child: Row(
                              children: [
                                Text(
                                  '🇱🇰',
                                  style: const TextStyle(fontSize: 18),
                                ),
                                const SizedBox(width: 8),
                                Text(code),
                              ],
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCountryCode = value!;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Phone Number Field
            Expanded(
              child: TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[50],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(color: Color(0xFF6366F1)),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Phone number is required';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}