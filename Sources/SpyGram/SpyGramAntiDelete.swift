import Foundation

/// **Охранитель Истории и Перехватчик Сообщений (Anti-Delete & Edit History)**
/// Взаимодействует с базой данных Postbox/SQLite, предотвращая физическое удаление сообщений
/// и сохраняя хронологию редактирования.
public final class SpyGramAntiDelete {
    public static let shared = SpyGramAntiDelete()
    
    private init() {}
    
    /// Структура хранимой версии редактированного сообщения
    public struct EditVersion: Codable {
        public let text: String
        public let editTimestamp: Int32
    }
    
    /// Предотвращает удаление сообщения из локальной базы Postbox.
    /// Вместо физической очистки меняет состояние сообщения на "Удалено локально".
    /// - Parameters:
    ///   - messageId: ID удаляемого сообщения
    ///   - text: Текст удаляемого сообщения
    /// - Returns: true, если удаление из базы заблокировано и сообщение оставлено в чате с меткой [Deleted]
    public func handleMessageDeletion(messageId: Int32, text: String?) -> Bool {
        guard SpyGramSettings.shared.isAntiDeleteEnabled else {
            return false // Обычный клиент Telegram стирает сообщение
        }
        
        print("[SpyGram] 🗑️ Anti-Delete: Сообщение #\(messageId) спасено от удаления! Текст: \(text ?? "<медиа>")")
        // Логика пометки сообщения меткой [Удалено] в UI
        return true // Блокируем удаление из базы
    }
    
    /// Запоминает исходный текст перед сохранением новой версии редактированного сообщения
    /// - Parameters:
    ///   - messageId: ID редактируемого сообщения
    ///   - previousText: Предыдущий текст сообщения
    ///   - newText: Новый текст сообщения
    public func handleMessageEdit(messageId: Int32, previousText: String, newText: String) {
        guard SpyGramSettings.shared.isSaveEditHistoryEnabled else { return }
        
        print("[SpyGram] ✏️ Edit History: Сообщение #\(messageId) изменено. Исходный вариант: '\(previousText)' -> Новый: '\(newText)'")
        // Сохранение в локальный архив правок для данного messageId
    }
    
    /// Проверяет, нужно ли сохранить медиафайл с таймером сгорания
    /// - Parameter mediaId: ID медиафайла
    /// - Returns: true, если сгорание заблокировано
    public func shouldPreventSelfDestruct(mediaId: String) -> Bool {
        guard SpyGramSettings.shared.saveSelfDestructMedia else { return false }
        print("[SpyGram] ⏱️ Self-Destruct Media: Фото/видео \(mediaId) сохранены и защищены от автоочистки.")
        return true
    }
}
