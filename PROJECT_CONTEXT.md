# 📱 Productivity App — Контекст проекта

## 👤 Разработчик
- GitHub: winchestersdc79-hub
- Репозиторий: Student (приватный)
- Работает только с телефона
- Студент-компьютерный инженер (учит C++ и Go)

## 📦 Последняя версия
**v1.5.0**

## 🛠 Технологии
- Flutter / Dart
- Provider (state management)
- SharedPreferences (хранение данных)
- Flutter Local Notifications
- Timezone

## 📄 pubspec.yaml зависимости
```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.2
  provider: ^6.1.1
  shared_preferences: ^2.2.2
  flutter_local_notifications: ^17.0.0
  timezone: ^0.9.2
📁 Структура проекта
lib/
├── main.dart
├── models/
│   └── task.dart
├── providers/
│   └── task_provider.dart
├── services/
│   ├── storage_service.dart
│   └── notification_service.dart
├── screens/
│   ├── main_screen.dart
│   ├── home_screen.dart
│   ├── add_task_screen.dart
│   ├── archive_screen.dart
│   ├── pomodoro_screen.dart
│   ├── statistics_screen.dart
│   ├── habits_screen.dart
│   ├── calendar_screen.dart
│   ├── ai_screen.dart
│   ├── search_screen.dart
│   ├── settings_screen.dart
│   └── pin_screen.dart
├── widgets/
│   ├── quadrant_card.dart
│   └── animated_task_card.dart
└── utils/
    └── page_transitions.dart
🎨 Дизайн
Тёмная тема
Фон: 0xFF0D0D1A
Карточки: 0xFF16213E
Акцент: 0xFF9B59B6 (фиолетовый)
Material 3 / Flutter
🧭 Навигация (9 вкладок)
📋 Задачи (Матрица Эйзенхауэра)
📅 Календарь
🔍 Поиск
🍅 Pomodoro
✅ Привычки
🤖 AI-помощник
📊 Статистика
🗄️ Архив
⚙️ Настройки
✅ Что сделано
Матрица Эйзенхауэра (4 квадранта)
Создание задач с дедлайном и приоритетом (P1/P2/P3)
Архив выполненных задач (автоудаление через 60 дней)
Pomodoro таймер (25/5/15 минут)
Статистика с прогресс-барами
Трекер привычек со стриком
Календарь задач с дедлайнами
AI-помощник (советы по продуктивности)
Поиск с фильтрами и сортировкой
Настройки (тема, язык, цвет акцента, пин-код)
Анимации карточек и переходов
Сохранение данных (SharedPreferences)
Уведомления (дедлайн, Pomodoro, выполнение)
📋 Модель задачи
enum TaskQuadrant { urgentImportant, notUrgentImportant, urgentNotImportant, notUrgentNotImportant }
enum TaskPriority { p1, p2, p3 }
class Task { id, title, description, quadrant, priority, deadline, isCompleted, isPinned, createdAt, completedAt, tags, subtasks }
class SubTask { title, isDone }
🚀 Следующие шаги
[ ] Когда будет ПК: установить Flutter
[ ] Клонировать репозиторий
[ ] Исправить ошибки компиляции
[ ] Собрать APK файл
[ ] Протестировать на телефоне
[ ] Экспорт данных в PDF
[ ] Виджет на рабочий стол
💬 Как использовать в новом чате
Скажи Claude:
"Я разрабатываю Flutter приложение продуктивности.
Прочитай файл PROJECT_CONTEXT.md в моём репозитории
github.com/winchestersdc79-hub/Student и продолжим разработку!"
