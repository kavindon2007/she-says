import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/slm_service.dart';

/// SLM Service Provider
final slmServiceProvider = Provider<SLMService>((ref) {
  final service = SLMService();
  service.initialize(); // Initialize on app start
  return service;
});

/// Risk Analysis Provider (cached for 5 minutes)
final riskAnalysisProvider = FutureProvider.family.autoDispose<Map<String, dynamic>, List<Map<String, dynamic>>>((ref, students) async {
  final slm = ref.watch(slmServiceProvider);
  return await slm.analyzeClassRisk(students);
});
