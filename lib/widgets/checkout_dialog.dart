import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../state/store_state.dart';
import '../data/farm_data.dart';

class CheckoutDialog extends StatefulWidget {
  final StoreState state;

  const CheckoutDialog({super.key, required this.state});

  @override
  State<CheckoutDialog> createState() => _CheckoutDialogState();
}

class _CheckoutDialogState extends State<CheckoutDialog> {
  final _formKey = GlobalKey<FormState>();

  // Delivery Form Controllers
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _notesController = TextEditingController();

  bool _isSubmitted = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _submitViaWhatsApp() async {
    if (!_formKey.currentState!.validate()) return;

    final encodedMessage = widget.state.generateWhatsAppOrderMessage(
      customerName: _nameController.text.trim(),
      customerPhone: _phoneController.text.trim(),
      deliveryAddress: _addressController.text.trim(),
      deliveryNotes: _notesController.text.trim(),
    );

    final url = Uri.parse("https://wa.me/${FarmData.whatsappNumber}?text=$encodedMessage");

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }

    setState(() {
      _isSubmitted = true;
    });
    widget.state.clearCart();
  }

  void _copyOrderMessage() {
    if (!_formKey.currentState!.validate()) return;

    final encodedMessage = widget.state.generateWhatsAppOrderMessage(
      customerName: _nameController.text.trim(),
      customerPhone: _phoneController.text.trim(),
      deliveryAddress: _addressController.text.trim(),
      deliveryNotes: _notesController.text.trim(),
    );

    final text = Uri.decodeComponent(encodedMessage);
    Clipboard.setData(ClipboardData(text: text));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        duration: Duration(seconds: 3),
        backgroundColor: AppTheme.cardBgElevated,
        content: Text(
          "WhatsApp order text copied to clipboard! You can paste it directly into WhatsApp chat.",
          style: TextStyle(color: AppTheme.emerald),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppTheme.cardBg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: AppTheme.cardBorder),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 460),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: _isSubmitted ? _buildSuccessScreen() : _buildDeliveryFormScreen(),
        ),
      ),
    );
  }

  // Delivery Details & WhatsApp Checkout Form
  Widget _buildDeliveryFormScreen() {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Text("💬", style: TextStyle(fontSize: 18)),
                    SizedBox(width: 8),
                    Text(
                      "WhatsApp Checkout",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: AppTheme.textMuted),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppTheme.emeraldMuted,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppTheme.emerald.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, size: 16, color: AppTheme.emerald),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "Your order details will open directly in WhatsApp to finalize payment & delivery with Abimot (${FarmData.whatsappNumber}).",
                      style: const TextStyle(fontSize: 11.5, color: AppTheme.emerald, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // Order Total Banner
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Order Total:",
                  style: TextStyle(fontSize: 13, color: AppTheme.textSecondary),
                ),
                Text(
                  "₦${widget.state.grandTotal.toStringAsFixed(0)} (${widget.state.cartTotalCount} items)",
                  style: const TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.gold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Full Name
            _buildInputField(
              controller: _nameController,
              label: "Full Name",
              hint: "e.g. Chioma Adeyemi",
              icon: Icons.person_outline,
              validator: (v) => (v == null || v.trim().isEmpty) ? "Please enter your name" : null,
            ),
            const SizedBox(height: 12),

            // Phone Number (Digits only, max 11 digits)
            _buildInputField(
              controller: _phoneController,
              label: "Phone Number (11 digits)",
              hint: "e.g. 08036671429",
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(11),
              ],
              validator: (v) {
                if (v == null || v.trim().isEmpty) {
                  return "Please enter your phone number";
                }
                if (v.trim().length != 11) {
                  return "Phone number must be exactly 11 digits";
                }
                return null;
              },
            ),
            const SizedBox(height: 12),

            // Address
            _buildInputField(
              controller: _addressController,
              label: "Delivery Address & City",
              hint: "e.g. Bodija Market Area, Ibadan",
              icon: Icons.location_on_outlined,
              maxLines: 2,
              validator: (v) => (v == null || v.trim().isEmpty) ? "Please enter your delivery address" : null,
            ),
            const SizedBox(height: 12),

            // Notes
            _buildInputField(
              controller: _notesController,
              label: "Special Instructions / Notes (Optional)",
              hint: "e.g. Please deliver before 2pm",
              icon: Icons.note_alt_outlined,
              maxLines: 2,
            ),
            const SizedBox(height: 20),

            // Main Primary CTA: WhatsApp Fast Order
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: _submitViaWhatsApp,
                icon: const Text("💬", style: TextStyle(fontSize: 18)),
                label: const Text("Complete Order on WhatsApp"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF25D366),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  textStyle: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Optional secondary CTA: Copy Order text
            SizedBox(
              width: double.infinity,
              height: 40,
              child: OutlinedButton.icon(
                onPressed: _copyOrderMessage,
                icon: const Icon(Icons.copy, size: 15, color: AppTheme.gold),
                label: const Text("Copy WhatsApp Order Text"),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.textPrimary,
                  side: const BorderSide(color: AppTheme.cardBorder),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Success Screen after opening WhatsApp
  Widget _buildSuccessScreen() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: const BoxDecoration(
            color: AppTheme.emeraldMuted,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.check_circle, size: 40, color: AppTheme.emerald),
        ),
        const SizedBox(height: 16),
        const Text(
          "Order Sent to WhatsApp!",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Your itemized cart has been prepared and sent to Abimot on WhatsApp (${FarmData.whatsappNumber}). The farm team will confirm payment and arrange delivery with you immediately.",
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary, height: 1.4),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.gold,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text("Return to Store", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600, color: AppTheme.textSecondary),
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          maxLines: maxLines,
          validator: validator,
          style: const TextStyle(fontSize: 13, color: AppTheme.textPrimary),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(fontSize: 12, color: AppTheme.textMuted),
            prefixIcon: Icon(icon, size: 17, color: AppTheme.textMuted),
            filled: true,
            fillColor: AppTheme.cardBgElevated,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppTheme.cardBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppTheme.cardBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppTheme.gold),
            ),
          ),
        ),
      ],
    );
  }
}
