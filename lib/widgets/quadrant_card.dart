import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/task.dart';

class QuadrantCard extends StatelessWidget {
  final String title;
  final Color color;
  final IconData icon;
  final List<Task> tasks;
  final VoidCallback onAddTask;

  const QuadrantCard({
    super.key,
    required this.title,
    required this.color,
    required this.icon,
    required this.tasks,
    required this.onAddTask,
  });

  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
      width: double.infinity,
      height: double.infinity,
      borderRadius: 24,
      blur: 15,
      alignment: Alignment.center,
      border: 1.5,
      linearGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          color.withOpacity(0.15),
          color.withOpacity(0.05),
        ],
      ),
      borderGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          color.withOpacity(0.5),
          color.withOpacity(0.1),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: color, size: 18),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: tasks.isEmpty
                ? Center(
                    child: Icon(
                      icon,
                      color: color.withOpacity(0.1),
                      size: 40,
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: tasks.length > 3 ? 3 : tasks.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 6),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          tasks[index].title,
                          style: GoogleFonts.inter(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${tasks.length} задач',
                  style: GoogleFonts.inter(
                    color: color.withOpacity(0.8),
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                GestureDetector(
                  onTap: onAddTask,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.add_rounded, color: Colors.white, size: 18),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
