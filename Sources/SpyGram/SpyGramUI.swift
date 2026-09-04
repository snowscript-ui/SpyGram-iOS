import UIKit

/// **Алтарь Управления SpyGram (Интерфейс Вкладки)**
/// Предоставляет UI для настройки всех магических опций клиентом Telegram-iOS
public final class SpyGramUIController: UITableViewController {
    
    private let settings = SpyGramSettings.shared
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "spyGram"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SettingCell")
    }
    
    // MARK: - Table View Data Source
    
    public override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 3 // Ghost Mode (В сети, Тайпинг, Истории)
        case 1: return 3 // Anti-Delete (Сообщения, Редактирование, Одноразовые медиа)
        case 2: return 2 // Снятие ограничений (Скриншоты, Копирование)
        case 3: return 2 // Дополнительно (Отключение рекламы, AyuSync)
        default: return 0
        }
    }
    
    public override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "👻 Конфиденциальность и скрытность (Ghost Mode)"
        case 1: return "🕵️ История и сохранность (Spy Mode)"
        case 2: return "🔓 Снятие ограничений"
        case 3: return "✨ Дополнительные удобства"
        default: return nil
        }
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "SettingCell")
        let switchView = UISwitch()
        switchView.tag = indexPath.section * 10 + indexPath.row
        switchView.addTarget(self, action: #selector(switchChanged(_:)), for: .valueChanged)
        
        var titleText = ""
        var isValueOn = false
        
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            titleText = "Режим Призрака (Ghost Mode)"
            isValueOn = settings.isGhostModeEnabled
        case (0, 1):
            titleText = "Скрывать статус «печатает»"
            isValueOn = settings.isHideTypingEnabled
        case (0, 2):
            titleText = "Анонимный просмотр историй"
            isValueOn = settings.isHideStoriesViewEnabled
            
        case (1, 0):
            titleText = "Анти-удаление сообщений"
            isValueOn = settings.isAntiDeleteEnabled
        case (1, 1):
            titleText = "Сохранять историю правок"
            isValueOn = settings.isSaveEditHistoryEnabled
        case (1, 2):
            titleText = "Сохранять одноразовые фото/видео"
            isValueOn = settings.saveSelfDestructMedia
            
        case (2, 0):
            titleText = "Скриншоты в секретных чатах"
            isValueOn = settings.bypassScreenshots
        case (2, 1):
            titleText = "Обход защиты от копирования"
            isValueOn = settings.bypassCopyProtection
            
        case (3, 0):
            titleText = "Отключение рекламы в каналах"
            isValueOn = settings.disableAds
        case (3, 1):
            titleText = "Активировать AyuSync"
            isValueOn = settings.ayuSyncEnabled
            
        default: break
        }
        
        cell.textLabel?.text = titleText
        switchView.isOn = isValueOn
        cell.accessoryView = switchView
        cell.selectionStyle = .none
        return cell
    }
    
    @objc private func switchChanged(_ sender: UISwitch) {
        let section = sender.tag / 10
        let row = sender.tag % 10
        
        switch (section, row) {
        case (0, 0): settings.isGhostModeEnabled = sender.isOn
        case (0, 1): settings.isHideTypingEnabled = sender.isOn
        case (0, 2): settings.isHideStoriesViewEnabled = sender.isOn
            
        case (1, 0): settings.isAntiDeleteEnabled = sender.isOn
        case (1, 1): settings.isSaveEditHistoryEnabled = sender.isOn
        case (1, 2): settings.saveSelfDestructMedia = sender.isOn
            
        case (2, 0): settings.bypassScreenshots = sender.isOn
        case (2, 1): settings.bypassCopyProtection = sender.isOn
            
        case (3, 0): settings.disableAds = sender.isOn
        case (3, 1): settings.ayuSyncEnabled = sender.isOn
            
        default: break
        }
    }
}
