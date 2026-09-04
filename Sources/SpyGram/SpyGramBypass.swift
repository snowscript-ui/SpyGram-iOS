import Foundation

/// **Разрушитель Ограничений (Bypass Restrictions & Copy Protection)**
/// Снимает встроенные защиты экрана, запреты на пересылку/сохранение и скриншоты в iOS
public final class SpyGramBypass {
    public static let shared = SpyGramBypass()
    
    private init() {}
    
    /// Проверяет, можно ли делать скриншот экрана секретного чата / защищенной медиа
    /// - Returns: true, если защита скриншота должна быть отключена
    public func shouldAllowScreenshots() -> Bool {
        return SpyGramSettings.shared.bypassScreenshots
    }
    
    /// Проверяет, отключена ли защита от копирования для данного чата/канала
    /// - Parameter isChannelProtected: Оригинальный флаг защиты канала (`isCopyProtected`)
    /// - Returns: false, если защита должна быть снята
    public func isCopyProtectedOverride(isChannelProtected: Bool) -> Bool {
        if SpyGramSettings.shared.bypassCopyProtection {
            print("[SpyGram] 🔓 Bypass: Защита от копирования и пересылки снята для канала/чата.")
            return false // Разрешаем выделение, пересылку и копирование
        }
        return isChannelProtected
    }
    
    /// Проверяет, следует ли скрыть рекламный/спонсорский пост в канале
    /// - Parameter isSponsorMessage: Флаг спонсорского сообщения
    /// - Returns: true, если пост нужно скрыть
    public func shouldFilterAdMessage(isSponsorMessage: Bool) -> Bool {
        guard isSponsorMessage else { return false }
        return SpyGramSettings.shared.disableAds
    }
}
