import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/student.dart';
import '../providers/class_provider.dart';
import '../providers/slm_provider.dart';

class ClassInsightsTab extends ConsumerWidget {
  final String classId;
  
  const ClassInsightsTab({
    Key? key,
    required this.classId,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studentsAsync = ref.watch(studentsByClassProvider(classId));
    
    return studentsAsync.when(
      data: (students) {
        // Calculate aggregate stats
        final avgAttendance = students.isEmpty 
            ? 0.0 
            : students.map((s) => s.attendancePercent).reduce((a, b) => a + b) / students.length;
        
        final highRiskCount = students.where((s) => 
          s.attendancePercent < 70 || s.averageGrade == 'D' || s.averageGrade == 'F'
        ).length;
        
        final dropoutRate = students.isEmpty 
            ? 0.0 
            : (highRiskCount / students.length) * 100;
        
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Stats Cards
              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      title: 'Avg Attendance',
                      value: '${avgAttendance.toStringAsFixed(1)}%',
                      icon: Icons.calendar_today,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _StatCard(
                      title: 'High Risk',
                      value: '$highRiskCount/${students.length}',
                      icon: Icons.warning,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 24),
              
              // Attendance vs Dropout Chart
              const Text(
                'Attendance vs Dropout Risk',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              
              SizedBox(
                height: 200,
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(show: true),
                    titlesData: FlTitlesData(show: true),
                    borderData: FlBorderData(show: true),
                    lineBarsData: [
                      LineChartBarData(
                        spots: [
                          FlSpot(0, avgAttendance),
                          FlSpot(1, 100 - dropoutRate),
                        ],
                        isCurved: true,
                        color: Colors.blue,
                        barWidth: 3,
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // AI Analysis Section
              const Text(
                'AI Risk Analysis',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              
              _buildAIAnalysis(ref, students),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Text('Error loading insights: $error'),
      ),
    );
  }
  
  Widget _buildAIAnalysis(WidgetRef ref, List<Student> students) {
    final slmData = students.map((s) => s.toSLMJson()).toList();
    final analysisAsync = ref.watch(riskAnalysisProvider(slmData));
    
    return analysisAsync.when(
      data: (analysis) {
        final highRisk = analysis['highRiskStudents'] as List? ?? [];
        
        if (highRisk.isEmpty) {
          return const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text('✅ No high-risk students identified'),
            ),
          );
        }
        
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '⚠️ ${highRisk.length} High-Risk Students',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(height: 8),
                ...highRisk.map((student) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text('• ${student['reason']}'),
                )),
              ],
            ),
          ),
        );
      },
      loading: () => const Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              SizedBox(width: 12),
              Text('Analyzing with AI...'),
            ],
          ),
        ),
      ),
      error: (error, stack) => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text('AI analysis unavailable: Using fallback'),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  
  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
