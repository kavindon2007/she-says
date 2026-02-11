import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animations/animations.dart';
import '../models/class_data.dart';
import '../models/student.dart';
import '../providers/class_provider.dart';
import 'class_insights_tab.dart';
import 'student_list_tab.dart';

class ClassRiskCard extends ConsumerWidget {
  final ClassData classData;
  
  const ClassRiskCard({
    Key? key,
    required this.classData,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OpenContainer(
      closedElevation: 2,
      openElevation: 4,
      closedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      transitionDuration: const Duration(milliseconds: 300),
      closedColor: Colors.white,
      openColor: Colors.white,
      
      // COLLAPSED STATE (Privacy-First)
      closedBuilder: (context, action) => _buildCollapsedCard(action),
      
      // EXPANDED STATE (Full Details)
      openBuilder: (context, action) => _buildExpandedCard(ref),
    );
  }
  
  /// Collapsed State: Minimal, no sensitive data
  Widget _buildCollapsedCard(VoidCallback openContainer) {
    return InkWell(
      onTap: openContainer,
      child: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            // Generic icon (no risk indicator)
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.school,
                size: 28,
                color: Colors.blue.shade700,
              ),
            ),
            const SizedBox(width: 16),
            
            // Class name only (no student count, no stats)
            Expanded(
              child: Text(
                classData.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            
            // Expand indicator
            Icon(
              Icons.chevron_right,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }
  
  /// Expanded State: Full details with tabs
  Widget _buildExpandedCard(WidgetRef ref) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(classData.name),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Class Insights'),
              Tab(text: 'Student List'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ClassInsightsTab(classId: classData.id),
            StudentListTab(classId: classData.id),
          ],
        ),
      ),
    );
  }
}
