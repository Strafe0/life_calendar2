import WidgetKit
import SwiftUI

// 1. МОДЕЛЬ ДАННЫХ (То, что мы показываем)
struct SimpleEntry: TimelineEntry {
    let date: Date
    let weeksText: String
    let percentText: String
    let goalsText: String
    let eventsText: String
    let progressValue: Double // От 0.0 до 1.0
}

// 2. ПРОВАЙДЕР (Чтение данных)
struct Provider: TimelineProvider {
    // Вставь сюда свой ID группы из Шага 1
    let appGroupId = "group.com.vgol.life_calendar2"

    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), weeksText: "1408/4226 недель", percentText: "33% жизни", goalsText: "🎯 3 цели", eventsText: "🗓️ 2 события", progressValue: 0.33)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), weeksText: "1408/4226 недель", percentText: "33% жизни", goalsText: "🎯 3 цели", eventsText: "🗓️ 2 события", progressValue: 0.33)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        // Читаем данные из "Общей папки"
        let userDefaults = UserDefaults(suiteName: appGroupId)
        
        let weeks = userDefaults?.string(forKey: "id_weeks_text") ?? "--/-- недель"
        let percentTxt = userDefaults?.string(forKey: "id_percent_text") ?? "0%"
        let goals = userDefaults?.string(forKey: "id_goals_text") ?? "Нет целей"
        let events = userDefaults?.string(forKey: "id_events_text") ?? "Нет событий"
        
        // Читаем Int (0-100), который мы слали для Android, и превращаем в Double (0.0-1.0)
        let progressInt = userDefaults?.integer(forKey: "id_progress_value") ?? 0
        let progressDouble = Double(progressInt) / 100.0

        let entry = SimpleEntry(
            date: Date(),
            weeksText: weeks,
            percentText: percentTxt,
            goalsText: goals,
            eventsText: events,
            progressValue: progressDouble
        )

        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}

// 3. ВЕРСТКА (Визуальная часть)
struct HomeWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            
            // 1. Недели
            Text(entry.weeksText)
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(Color(UIColor.darkGray))
            
            // 2. Прогресс бар
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Capsule()
                        .frame(width: geometry.size.width, height: 6)
                        .foregroundColor(Color(UIColor.systemGray5))
                    
                    Capsule()
                        .frame(width: geometry.size.width * CGFloat(entry.progressValue), height: 6)
                        .foregroundColor(Color.blue)
                }
            }
            .frame(height: 6)
            .padding(.vertical, 4)
            
            // 3. Проценты
            HStack {
                Spacer()
                Text(entry.percentText)
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(Color.blue)
            }
            .padding(.bottom, 4)
            
            // Разделитель
            Divider()
                .padding(.bottom, 4)
            
            // 4. Цели
            Text(entry.goalsText)
                .font(.system(size: 14))
                .foregroundColor(.black)
                .padding(.bottom, 2)
            
            // 5. События
            Text(entry.eventsText)
                .foregroundColor(.black)
                .font(.system(size: 14))
        }
        .padding()
        .widgetBackground(Color.white)
    }
}
// 4. КОНФИГУРАЦИЯ
struct HomeWidget: Widget {
    let kind: String = "HomeWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            HomeWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Мой календарь")
        .description("Статистика жизни")
        .supportedFamilies([.systemSmall]) // Только маленький квадрат
    }
}

extension View {
    func widgetBackground(_ backgroundView: some View) -> some View {
        if #available(iOSApplicationExtension 17.0, *) {
            return containerBackground(for: .widget) {
                backgroundView
            }
        } else {
            return background(backgroundView)
        }
    }
}
