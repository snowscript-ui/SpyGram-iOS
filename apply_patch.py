#!/usr/bin/env python3
"""
Свиток Автоматического Патчинга Telegram-iOS
Внедряет вызовы модуля SpyGram в репозиторий TelegramMessenger/Telegram-iOS
"""

import os
import sys
import re

def patch_file(filepath, search_pattern, replacement):
    if not os.path.exists(filepath):
        print(f"[!] Файл не найден: {filepath}")
        return False
    
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
        
    if search_pattern in content:
        if replacement not in content:
            new_content = content.replace(search_pattern, replacement)
            with open(filepath, 'w', encoding='utf-8') as f:
                f.write(new_content)
            print(f"[+] Патч успешно применён к: {filepath}")
            return True
        else:
            print(f"[*] Патч уже применён: {filepath}")
            return True
    else:
        print(f"[-] Шаблон для замены не найден в: {filepath}")
        return False

def main():
    print("=== Магический Ритуал Внедрения SpyGram в Telegram-iOS ===")
    telegram_repo_dir = sys.argv[1] if len(sys.argv) > 1 else "."
    
    if not os.path.exists(os.path.join(telegram_repo_dir, "Telegram")):
        print(f"[!] Укажите верный путь к репозиторию Telegram-iOS! Директория '{telegram_repo_dir}' не содержит Telegram.xcodeproj или Bazel файлов.")
        sys.exit(1)
        
    print(f"[+] Целевой репозиторий: {os.path.abspath(telegram_repo_dir)}")
    
    # 1. Патч Ghost Mode (TelegramCore/Sources/Network/ApiNetwork.swift)
    api_network_path = os.path.join(telegram_repo_dir, "submodules", "TelegramCore", "Sources", "Network", "ApiNetwork.swift")
    patch_file(
        api_network_path,
        "func request<T>(_ function: T)",
        "func request<T>(_ function: T) {\n    if SpyGramGhostMode.shared.shouldInterceptReadHistory(peerId: 0) { return }\n"
    )
    
    # 2. Патч Anti-Delete (submodules/Postbox/Sources/MessageHistoryTable.swift)
    message_table_path = os.path.join(telegram_repo_dir, "submodules", "Postbox", "Sources", "MessageHistoryTable.swift")
    patch_file(
        message_table_path,
        "func removeMessage(id: MessageId)",
        "func removeMessage(id: MessageId) {\n    if SpyGramAntiDelete.shared.handleMessageDeletion(messageId: id.id, text: nil) { return }\n"
    )
    
    # 3. Патч Bypass Restrictions (submodules/TelegramUI/Sources/ChatController.swift)
    chat_controller_path = os.path.join(telegram_repo_dir, "submodules", "TelegramUI", "Sources", "ChatController.swift")
    patch_file(
        chat_controller_path,
        "let isCopyProtected = peer.isCopyProtected",
        "let isCopyProtected = SpyGramBypass.shared.isCopyProtectedOverride(isChannelProtected: peer.isCopyProtected)"
    )

    print("\n[✓] Ритуал внедрения завершён! Модули SpyGram готовы к сборке через Bazel.")

if __name__ == "__main__":
    main()
