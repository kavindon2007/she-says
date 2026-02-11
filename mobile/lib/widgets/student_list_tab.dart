import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/class_provider.dart';

class StudentListTab extends ConsumerWidget {
  final String classId;
  
  const StudentListTab({
    Key? key,
    required this.classId,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studentsAsync = ref.watch(studentsByClassProvider(classId));
    
    return studentsAsync.when(
      data: (students) {
        if (students.isEmpty) {
          return const Center(
            child: Text('No students in this class'),
          );
        }
        
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: students.length,
          itemBuilder: (context, index) {
            final student = students[index];
            final isHighRisk = student.attendancePercent < 70 || 
                               student.averageGrade == 'D' || 
                               student.averageGrade == 'F';
            
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: isHighRisk ? Colors.orange : Colors.green,
                  child: Text(
                    student.name[0].toUpperCase(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(
                  student.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text('Attendance: ${student.attendancePercent.toStringAsFixed(1)}%'),
                    Text('Grade: ${student.averageGrade}'),
                  ],
                ),
                trailing: isHighRisk 
                    ? const Icon(Icons.warning, color: Colors.orange)
                    : const Icon(Icons.check_circle, color: Colors.green),
                onTap: () => _showStudentDetails(context, student),
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Text('Error loading students: $error'),
      ),
    );
  }
  
  void _showStudentDetails(BuildContext context, student) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(16),
          child: ListView(
            controller: scrollController,
            children: [
              Text(
                student.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              
              _DetailSection(
                title: 'Attendance',
                children: [
                  _DetailRow('Attendance Rate', '${student.attendancePercent.toStringAsFixed(1)}%'),
                  _DetailRow('Days Present', '${student.daysPresent}/${student.totalSchoolDays}'),
                  _DetailRow('Longest Absence', '${student.longestAbsence} days'),
                ],
              ),
              
              _DetailSection(
                title: 'Academic Performance',
                children: [
                  _DetailRow('Current Marks', '${student.currentTermMarks}%'),
                  _DetailRow('Previous Marks', '${student.previousTermMarks}%'),
                  _DetailRow('Current Grade', student.averageGrade),
                  _DetailRow('Subjects Failed', '${student.subjectsFailedCurrent}'),
                ],
              ),
              
              _DetailSection(
                title: 'Family & Economic',
                children: [
                  _DetailRow('Family Income', '₹${student.familyIncome}'),
                  _DetailRow('Parent Education', student.parentEducation),
                  _DetailRow('Study Device', student.hasStudyDevice ? 'Yes' : 'No'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  
  const _DetailSection({
    required this.title,
    required this.children,
  });
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 8),
        ...children,
        const SizedBox(height: 16),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  
  const _DetailRow(this.label, this.value);
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
