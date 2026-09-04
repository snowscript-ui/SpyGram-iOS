import Foundation

/// **Магический Кристалл Настроек SpyGram**
/// Отвечает за хранение и мгновенную передачу флагов конфиденциальности по всему клиенту.
public final class SpyGramSettings {
    public static let shared = SpyGramSettings()
    
    private let defaults = UserDefaults.standard
    
    private enum Keys {
        static let ghostMode = "spygram_ghost_mode"
        static let hideTyping = "spygram_hide_typing"
        static let hideStoriesView = "spygram_hide_stories_view"
        static let antiDelete = "spygram_anti_delete"
        static let saveEditHistory = "spygram_save_edit_history"
        static let bypassScreenshots = "spygram_bypass_screenshots"
        static let bypassCopyProtection = "spygram_bypass_copy_protection"
        static let saveSelfDestructMedia = "spygram_save_self_destruct_media"
        static let disableAds = "spygram_disable_ads"
        static let ayuSyncEnabled = "spygram_ayusync_enabled"
    }
    
    private init() {}
    
    // MARK: - Конфиденциальность (Ghost Mode)
    
    /// Скрывает статус чтения сообщений
    public var isGhostModeEnabled: Bool {
        get { defaults.bool(forKey: Keys.ghostMode) }
        set { defaults.set(newValue, forKey: Keys.ghostMode) }
    }
    
    /// Скрывает индикатор «печатает...»
    public var isHideTypingEnabled: Bool {
        get { defaults.bool(forKey: Keys.hideTyping) }
        set { defaults.set(newValue, forKey: Keys.hideTyping) }
    }
    
    /// Невидимый просмотр историй (Stories)
    public var isHideStoriesViewEnabled: Bool {
        get { defaults.bool(forKey: Keys.hideStoriesView) }
        set { defaults.set(newValue, forKey: Keys.hideStoriesView) }
    }
    
    // MARK: - Анти-Удаление (Spy Mode)
    
    /// Сохранять удаленные собеседником сообщения
    public var isAntiDeleteEnabled: Bool {
        get { defaults.object(forKey: Keys.antiDelete) as? Bool ?? true }
        set { defaults.set(newValue, forKey: Keys.antiDelete) }
    }
    
    /// Сохранять историю редактирования сообщений
    public var isSaveEditHistoryEnabled: Bool {
        get { defaults.object(forKey: Keys.saveEditHistory) as? Bool ?? true }
        set { defaults.set(newValue, forKey: Keys.saveEditHistory) }
    }
    
    // MARK: - Снятие Ограничений
    
    /// Разрешить скриншоты в секретных чатах и каналах
    public var bypassScreenshots: Bool {
        get { defaults.object(forKey: Keys.bypassScreenshots) as? Bool ?? true }
        set { defaults.set(newValue, forKey: Keys.bypassScreenshots) }
    }
    
    /// Разрешить копирование и сохранение из защищенных каналов
    public var bypassCopyProtection: Bool {
        get { defaults.object(forKey: Keys.bypassCopyProtection) as? Bool ?? true }
        set { defaults.set(newValue, forKey: Keys.bypassCopyProtection) }
    }
    
    /// Запретить автоматическое сгорание одноразовых фото/видео
    public var saveSelfDestructMedia: Bool {
        get { defaults.object(forKey: Keys.saveSelfDestructMedia) as? Bool ?? true }
        set { defaults.set(newValue, forKey: Keys.saveSelfDestructMedia) }
    }
    
    // MARK: - Премиум фишки и Синхронизация
    
    /// Отключение спонсорских постов в каналах
    public var disableAds: Bool {
        get { defaults.bool(forKey: Keys.disableAds) }
        set { defaults.set(newValue, forKey: Keys.disableAds) }
    }
    
    /// Синхронизация истории SpyGram между устройствами
    public var ayuSyncEnabled: Bool {
        get { defaults.bool(forKey: Keys.ayuSyncEnabled) }
        set { defaults.set(newValue, forKey: Keys.ayuSyncEnabled) }
    }
}
