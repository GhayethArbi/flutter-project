import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tunipark/core/theme/app_colors.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';
import 'package:tunipark/core/constants/app_strings.dart';

class DateTimePickerBottomSheet extends StatefulWidget {
  final DateTime initialValue;
  final DateTime? minimumDate;
  final String title;

  const DateTimePickerBottomSheet({
    super.key,
    required this.initialValue,
    required this.title,
    this.minimumDate,
  });

  @override
  State<DateTimePickerBottomSheet> createState() =>
      _DateTimePickerBottomSheetState();
}

class _DateTimePickerBottomSheetState extends State<DateTimePickerBottomSheet> {
  late final List<DateTime> _availableDates;
  late final List<TimeOfDay> _availableTimes;

  late int _selectedDateIndex;
  late int _selectedTimeIndex;

  @override
  void initState() {
    super.initState();
    _initializePickers();
  }

  void _initializePickers() {
    final now = DateTime.now();
    final startDate = widget.minimumDate ?? now;

    _availableDates = List.generate(30, (index) {
      return DateTime(
        startDate.year,
        startDate.month,
        startDate.day,
      ).add(Duration(days: index));
    });

    _availableTimes = List.generate(48, (index) {
      final hour = index ~/ 2;
      final minute = index.isEven ? 0 : 30;
      return TimeOfDay(hour: hour, minute: minute);
    });

    _selectedDateIndex = _findInitialDateIndex(widget.initialValue);
    _selectedTimeIndex = _findInitialTimeIndex(widget.initialValue);
  }

  int _findInitialDateIndex(DateTime value) {
    for (int i = 0; i < _availableDates.length; i++) {
      final date = _availableDates[i];
      if (_isSameDay(date, value)) return i;
    }
    return 0;
  }

  int _findInitialTimeIndex(DateTime value) {
    final roundedMinute = value.minute < 30 ? 0 : 30;

    for (int i = 0; i < _availableTimes.length; i++) {
      final time = _availableTimes[i];
      if (time.hour == value.hour && time.minute == roundedMinute) {
        return i;
      }
    }
    return 0;
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  String _formatDate(DateTime date) {
    const weekDays = [
      'Lun',
      'Mar',
      'Mer',
      'Jeu',
      'Ven',
      'Sam',
      'Dim',
    ];

    const months = [
      'Jan',
      'Fév',
      'Mar',
      'Avr',
      'Mai',
      'Juin',
      'Juil',
      'Aoû',
      'Sep',
      'Oct',
      'Nov',
      'Déc',
    ];

    final weekDay = weekDays[date.weekday - 1];
    final month = months[date.month - 1];
    final day = date.day.toString().padLeft(2, '0');

    return '$weekDay $day $month';
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  DateTime _buildSelectedDateTime() {
    final selectedDate = _availableDates[_selectedDateIndex];
    final selectedTime = _availableTimes[_selectedTimeIndex];

    return DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );
  }

  void _confirm() {
    final selectedDateTime = _buildSelectedDateTime();

    if (widget.minimumDate != null &&
        selectedDateTime.isBefore(widget.minimumDate!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppStrings.laDateSelectionneeDoitEtrePosterieure,
          ),
        ),
      );
      return;
    }

    Navigator.of(context).pop(selectedDateTime);
  }

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    final pickerHeight = rs.adaptive(
      mobile: 180,
      tablet: 200,
      desktop: 220,
    );

    final confirmHeight = rs.adaptive(
      mobile: 52,
      tablet: 56,
      desktop: 60,
    );

    final horizontalPadding = rs.adaptive(
      mobile: 20,
      tablet: 24,
      desktop: 28,
    );

    return SafeArea(
      top: false,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: EdgeInsets.fromLTRB(
          horizontalPadding,
          16,
          horizontalPadding,
          20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.title,
              style: TextStyle(
                fontSize: rs.adaptive(mobile: 16, tablet: 17, desktop: 18),
                fontWeight: FontWeight.w600,
                color: Colors.black, // titre noir
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: pickerHeight,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: CupertinoPicker(
                      scrollController: FixedExtentScrollController(
                        initialItem: _selectedDateIndex,
                      ),
                      itemExtent: 40,
                      onSelectedItemChanged: (index) {
                        setState(() {
                          _selectedDateIndex = index;
                        });
                      },
                      children: _availableDates.map((date) {
                        return Center(
                          child: Text(
                            _formatDate(date),
                            style: TextStyle(
                              fontSize: rs.adaptive(
                                mobile: 16,
                                tablet: 17,
                                desktop: 18,
                              ),
                              color: const Color(0xFF224466),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: CupertinoPicker(
                      scrollController: FixedExtentScrollController(
                        initialItem: _selectedTimeIndex,
                      ),
                      itemExtent: 40,
                      onSelectedItemChanged: (index) {
                        setState(() {
                          _selectedTimeIndex = index;
                        });
                      },
                      children: _availableTimes.map((time) {
                        return Center(
                          child: Text(
                            _formatTime(time),
                            style: TextStyle(
                              fontSize: rs.adaptive(
                                mobile: 16,
                                tablet: 17,
                                desktop: 18,
                              ),
                              color: const Color(0xFF224466),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: confirmHeight,
              child: ElevatedButton(
                onPressed: _confirm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.colorBtn,
                  foregroundColor: Colors.black,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(AppStrings.confirmer,
                  style: TextStyle(
                    fontSize: rs.adaptive(mobile: 15, tablet: 16, desktop: 17),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}