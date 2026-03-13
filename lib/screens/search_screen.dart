import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:productivity_app/models/task.dart';
import 'package:productivity_app/providers/task_provider.dart';
enum SortType { byDate, byName, byPriority, byDeadline }

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();
  String _query = '';
  SortType _sortType = SortType.byDate;
  TaskQuadrant? _filterQuadrant;
  TaskPriority? _filterPriority;

  List<Task> _filterAndSort(List<Task> tasks) {
    var result = tasks.where((t) {
      final matchQuery = _query.isEmpty ||
          t.title.toLowerCase().contains(_query.toLowerCase()) ||
          t.description.toLowerCase().contains(_query.toLowerCase());
      final matchQuadrant = _filterQuadrant == null || t.quadrant == _filterQuadrant;
      final matchPriority = _filterPriority == null || t.priority == _filterPriority;
      return matchQuery && matchQuadrant && matchPriority;
    }).toList();

    switch (_sortType) {
      case SortType.byDate:
        result.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case SortType.byName:
        result.sort((a, b) => a.title.compareTo(b.title));
        break;
      case SortType.byPriority:
        result.sort((a, b) => a.priority.index.compareTo(b.priority.index));
        break;
      case SortType.byDeadline:
        result.sort((a, b) {
          if (a.deadline == null) return 1;
          if (b.deadline == null) return -1;
          return a.deadline!.compareTo(b.deadline!);
        });
        break;
    }
    return result;
  }

  Color _getQuadrantColor(TaskQuadrant q) {
    switch (q) {
      case TaskQuadrant.urgentImportant: return const Color(0xFFE74C3C);
      case TaskQuadrant.notUrgentImportant: return const Color(0xFFF39C12);
      case TaskQuadrant.urgentNotImportant: return const Color(0xFF27AE60);
      case TaskQuadrant.notUrgentNotImportant: return const Color(0xFF7F8C8D);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TaskProvider>();
    final results = _filterAndSort(provider.tasks);

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D1A),
        title: const Text(
          '🔍 Поиск',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _controller,
              style: const TextStyle(color: Colors.white),
              onChanged: (v) => setState(() => _query = v),
              decoration: InputDecoration(
                hintText: 'Поиск задач...',
                hintStyle: const TextStyle(color: Colors.white38),
                prefixIcon: const Icon(Icons.search, color: Colors.white38),
                suffixIcon: _query.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.white38),
                        onPressed: () {
                          _controller.clear();
                          setState(() => _query = '');
                        },
                      )
                    : null,
                filled: true,
                fillColor: const Color(0xFF16213E),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.all(16),
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _buildSortChip('📅 По дате', SortType.byDate),
                const SizedBox(width: 8),
                _buildSortChip('🔤 По имени', SortType.byName),
                const SizedBox(width: 8),
                _buildSortChip('🔥 По приоритету', SortType.byPriority),
                const SizedBox(width: 8),
                _buildSortChip('⏰ По дедлайну', SortType.byDeadline),
              ],
            ),
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _buildQuadrantFilter('Все', null),
                const SizedBox(width: 8),
                _buildQuadrantFilter('🔴', TaskQuadrant.urgentImportant),
                const SizedBox(width: 8),
                _buildQuadrantFilter('🟡', TaskQuadrant.notUrgentImportant),
                const SizedBox(width: 8),
                _buildQuadrantFilter('🟢', TaskQuadrant.urgentNotImportant),
                const SizedBox(width: 8),
                _buildQuadrantFilter('⚪', TaskQuadrant.notUrgentNotImportant),
                const SizedBox(width: 16),
                _buildPriorityFilter('Все', null),
                const SizedBox(width: 8),
                _buildPriorityFilter('🔥P1', TaskPriority.p1),
                const SizedBox(width: 8),
                _buildPriorityFilter('⚡P2', TaskPriority.p2),
                const SizedBox(width: 8),
                _buildPriorityFilter('💤P3', TaskPriority.p3),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  'Найдено: ${results.length}',
                  style: const TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: results.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('🔍', style: TextStyle(fontSize: 48)),
                        SizedBox(height: 16),
                        Text(
                          'Ничего не найдено',
                          style: TextStyle(color: Colors.white54, fontSize: 18),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: results.length,
                    itemBuilder: (ctx, i) {
                      final task = results[i];
                      final color = _getQuadrantColor(task.quadrant);
                      return Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFF16213E),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: color.withOpacity(0.3)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 4,
                              height: 48,
                              decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    task.title,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  if (task.description.isNotEmpty)
                                    Text(
                                      task.description,
                                      style: const TextStyle(
                                        color: Colors.white54,
                                        fontSize: 12,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  if (task.deadline != null)
                                    Text(
                                      '⏰ ${task.deadline!.day}.${task.deadline!.month}.${task.deadline!.year}',
                                      style: const TextStyle(
                                        color: Colors.orange,
                                        fontSize: 11,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                _buildPriorityBadge(task.priority),
                                if (task.isPinned)
                                  const Icon(Icons.push_pin, color: Colors.yellow, size: 16),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSortChip(String label, SortType type) {
    final isSelected = _sortType == type;
    return GestureDetector(
      onTap: () => setState(() => _sortType = type),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF9B59B6) : const Color(0xFF16213E),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFF9B59B6) : Colors.white12,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white54,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildQuadrantFilter(String label, TaskQuadrant? quadrant) {
    final isSelected = _filterQuadrant == quadrant;
    return GestureDetector(
      onTap: () => setState(() => _filterQuadrant = quadrant),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1A1A3E) : const Color(0xFF16213E),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.white54 : Colors.white12,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white54,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildPriorityFilter(String label, TaskPriority? priority) {
    final isSelected = _filterPriority == priority;
    return GestureDetector(
      onTap: () => setState(() => _filterPriority = priority),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1A1A3E) : const Color(0xFF16213E),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.white54 : Colors.white12,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white54,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildPriorityBadge(TaskPriority p) {
    final labels = {TaskPriority.p1: '🔥P1', TaskPriority.p2: '⚡P2', TaskPriority.p3: '💤P3'};
    final colors = {
      TaskPriority.p1: const Color(0xFFE74C3C),
      TaskPriority.p2: const Color(0xFFF39C12),
      TaskPriority.p3: const Color(0xFF7F8C8D),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: colors[p]!.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        labels[p]!,
        style: TextStyle(color: colors[p], fontSize: 11),
      ),
    );
  }
}
