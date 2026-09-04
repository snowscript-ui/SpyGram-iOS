import Foundation

/// **Магический Покров Призрака (Ghost Mode Interceptor)**
/// Перехватывает вызовы в сетевом слое TelegramCore/MTProto и блокирует отправку статусов
public final class SpyGramGhostMode {
    public static let shared = SpyGramGhostMode()
    
    private init() {}
    
    /// Проверяет, следует ли заблокировать отправку отчета о прочтении сообщений
    /// - Parameter peerId: Идентификатор чата
    /// - Returns: true, если вызов нужно заглушить (Complete Signal без отправки RPC)
    public func shouldInterceptReadHistory(peerId: Int64) -> Bool {
        guard SpyGramSettings.shared.isGhostModeEnabled else {
            return false
        }
        print("[SpyGram] 👻 Ghost Mode: Заблокирована отправка ReadHistory для peerId: \(peerId)")
        return true
    }
    
    /// Проверяет, следует ли заблокировать отправку тайпинга ("печатает...")
    /// - Parameter peerId: Идентификатор чата
    /// - Returns: true, если вызов нужно блокировать
    public func shouldInterceptTyping(peerId: Int64) -> Bool {
        guard SpyGramSettings.shared.isHideTypingEnabled || SpyGramSettings.shared.isGhostModeEnabled else {
            return false
        }
        print("[SpyGram] 🤫 Ghost Mode: Заблокирован статус тайпинга для peerId: \(peerId)")
        return true
    }
    
    /// Проверяет, следует ли блокировать просмотр историй (Stories Read Receipt)
    /// - Parameter storyId: Идентификатор истории
    /// - Returns: true, если история просматривается анонимно
    public func shouldInterceptStoryView(storyId: Int32) -> Bool {
        guard SpyGramSettings.shared.isHideStoriesViewEnabled || SpyGramSettings.shared.isGhostModeEnabled else {
            return false
        }
        print("[SpyGram] 👁️ Ghost Mode: Невидимый просмотр Story ID: \(storyId)")
        return true
    }
}
