class ParkingDetailFaq {
  final String question;
  final String answer;
  final bool isExpanded;

  const ParkingDetailFaq({
    required this.question,
    required this.answer,
    this.isExpanded = false,
  });

  ParkingDetailFaq copyWith({
    String? question,
    String? answer,
    bool? isExpanded,
  }) {
    return ParkingDetailFaq(
      question: question ?? this.question,
      answer: answer ?? this.answer,
      isExpanded: isExpanded ?? this.isExpanded,
    );
  }
}