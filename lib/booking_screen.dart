import 'package:flutter/material.dart';

class BookingScreen extends StatefulWidget {
  final String day;
  final String hour;
  final String service;
  final String barbershop;

  const BookingScreen({
    Key? key,
    required this.day,
    required this.hour,
    required this.service,
    required this.barbershop,
  }) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          // HEADER
          Container(
            padding: const EdgeInsets.only(
              top: 60,
              left: 20,
              right: 20,
              bottom: 24,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo
                Center(child: Image.asset('assets/logo.png', height: 80)),
                const SizedBox(height: 20),
                Text(
                  'Your Appointment',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Bookingan kamu sudah masuk\nTerimakasih, Stay Cool Brother',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onPrimaryContainer,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),

          // CARD BOOKING DETAIL
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: 60,
                      height: 60,
                      color: colorScheme.surface,
                      child: Image.asset(
                        'assets/hair.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Detail booking
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Day: ${widget.day}',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: colorScheme.onSecondaryContainer,
                          ),
                        ),
                        Text(
                          'Hour: ${widget.hour}',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: colorScheme.onSecondaryContainer,
                          ),
                        ),
                        Text(
                          'Service: ${widget.service}',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: colorScheme.onSecondaryContainer,
                          ),
                        ),
                        Text(
                          'Barbershop: ${widget.barbershop}',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: colorScheme.onSecondaryContainer,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
