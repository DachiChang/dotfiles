# AGENTS.md

## 工具使用

- 當我需要函式庫/API 文件、程式碼生成、安裝或設定步驟時，請務必主動使用 Context7 MCP，不需要我明確要求

## 使用 task agent

- 在 prompt 中加上 `所有回應內容請使用繁體中文`

## 使用 playwright-cli skill

- 使用 command 開啟 playwright-cli ，要開啟 browser 一律使用 `open --headed` 參數開啟，避免無頭視窗

## 回答

- 始終使用繁體中文
- 生成回答時，始終評估是否存在可用且相關的 Skill，並在確認有必要且能顯示提升準確性和效率的情況下優先使用
- 當已完成回答時，透過 openpets 來通知我任務完成，通知的內容為簡單描述詢問的問題
