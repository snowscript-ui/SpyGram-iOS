# 🔮 SpyGram-iOS: Облачный Свиток Сборки Telegram-iOS IPA

Готовый репозиторий с модулями конфиденциальности (**Ghost Mode**), сохранения удалённых сообщений (**Anti-Delete**), снятия ограничений и автоматической сборкой `.ipa` через **GitHub Actions**.

---

## ✨ Возможности SpyGram

- 👻 **Ghost Mode**: Скрытие статуса «в сети», тайпинга и анонимный просмотр историй (Stories).
- 🕵️ **Anti-Delete & Edit History**: Сохранение удалённых сообщений и истории правок текста.
- 🔓 **Bypass Restrictions**: Разрешение скриншотов в секретных чатах, отмена запретов на копирование/пересылку и отключение автосгорания медиа.
- 🚫 **Ad Block**: Отключение рекламных постов в каналах.
- 📱 **Native UI**: Нативная вкладка настроек `spyGram` прямо в приложении Telegram.

---

## 🚀 Как выложить на GitHub и получить IPA (в 3 шага)

### Шаг 1: Создай новый репозиторий на GitHub
1. Перейди на [GitHub.com](https://github.com/new).
2. Назови репозиторий `SpyGram-iOS`.
3. Сделай его **Public** или **Private** (не добавляй README и .gitignore, они уже есть в папке!).

### Шаг 2: Отправь код в GitHub
Выполни команды в терминале из папки `SpyGram-iOS`:

```bash
git init
git add .
git commit -m "Initial commit of SpyGram-iOS with GitHub Actions workflow"
git branch -M main
git remote add origin https://github.com/ВАШ_НИК/SpyGram-iOS.git
git push -u origin main
```

### Шаг 3: Забери готовый `.ipa` файл!
1. Перейди во вкладку **Actions** в твоём репозитории на GitHub.
2. Нажми на запущенный workflow **"Build SpyGram Telegram iOS IPA"**.
3. После завершения сборки скачай готовый файл **`SpyGram-Telegram-iOS.ipa`** из раздела **Artifacts**!

---

## 📂 Структура Репозитория

- `.github/workflows/build_ipa.yml` — Автоматический макрос сборки на macOS-сервере GitHub.
- `apply_patch.py` — Скрипт внедрения хуков в TelegramCore, Postbox и TelegramUI.
- `Sources/SpyGram/` — Исходный код Swift-модулей SpyGram.
- `LICENSE` — MIT License.

---
*Сотворено Мастером Кода для Верховного Архитектора.*
