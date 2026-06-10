---
name: resource-hunting
description: Use when diagnosing local machine resource usage, overheating, high CPU, memory pressure, battery drain, high energy impact, runaway processes, Docker/VM load, browser renderer load, or when mapping process PIDs back to tmux sessions/windows/panes.
---

# ResourceHunting

找出本機上吃資源的 process，包含 CPU、Memory、Power、Energy，並能將任意 PID 回對 tmux `session:window.pane`。

**安全規則**：預設所有診斷為只讀 — 不 kill、不 suspend、不修改系統設定，除非使用者明確要求。

---

## 診斷流程

### Phase 1：建立即時基線

同時執行以下命令（一次發出多個 Bash call）：

```sh
# 目前即時 CPU / memory / 累積 CPU time
ps -axo pid,ppid,user,%cpu,%mem,etime,cputime,comm,args -r | /usr/bin/head -n 30

# macOS energy/thermal/assertion 狀態
pmset -g therm
pmset -g batt
pmset -g assertions

# macOS power 日誌（最近 24h 睡眠/喚醒/散熱相關）
/usr/bin/log show --last 24h --style compact --predicate \
  'eventMessage CONTAINS[c] "thermal" OR eventMessage CONTAINS[c] "Thermal" OR eventMessage CONTAINS[c] "CPU_Scheduler_Limit" OR eventMessage CONTAINS[c] "performance warning" OR eventMessage CONTAINS[c] "power warning"'
```

### Phase 2：分類高資源 Process

對 `ps` 輸出的前 30 名做分類。常見類別（不限定特定程式）：

| 類別 | 特徵 |
|---|---|
| **System** | `_trustd`, `kernel`, `WindowServer`, `mds`, `ecosystemd`, `sysmond` |
| **Docker/VM** | `[Vv]irtualization`, `[Dd]ocker`, `qemu`, `lima`, `colima`, `orbstack` |
| **Browser/Electron** | `Arc`, `Chrome`, `Safari`, `Firefox`, `Electron` render/gpu/utility helper |
| **Editor/IDE/LSP** | `nvim`, `code`, `lua-language-server`, `typescript-language-server`, `tailwindcss-language-server`, `helm_ls` |
| **Cloud CLI** | `aws`, `kubectl`, `k9s`, `helm`, `terraform`, `stern` |
| **Sync/Backup** | `OneDrive`, `iCloud`, `Time Machine`, `Dropbox` |
| **Security** | `CrowdStrike`, `Falcon`, `XProtect`, antivirus |
| **Terminal/tmux** | `tmux`, `alacritty`, `zsh`, `lazygit` |

### Phase 3：找長期累積耗能

累積 CPU time (`cputime`) 是辨識長時間耗能的關鍵。

```sh
ps -axo pid,user,etime,cputime,%cpu,%mem,comm,args \
  | /usr/bin/sort -k3 -r \
  | /usr/bin/head -n 30
```

找以下模式的 PID：
- `etime` > 24h **且** `%CPU` > 10%
- `cputime` 異常大（格式：`[days-]hh:mm:ss` 或 `mm:ss.ss`）
- child process 也都在吃 CPU（同一組 PPID chain）

### Phase 4：深入可疑 Process

對 Phase 2/3 找出的可疑 PID，做以下交叉比對：

```sh
# process tree（PPID chain）
ps -axo pid,ppid,pgid,sess,tty,stat,%cpu,%mem,etime,cputime,comm,args \
  | rg '^ *(可疑PID|可疑PPID|可疑PPID的child)'

# 查工作目錄
lsof -a -p <PID> -d cwd

# 查 open files（含 socket、log）
lsof -a -p <PID>

# 查是否有子程序
ps --ppid <PID> -o pid,%cpu,%mem,etime,comm,args
```

### Phase 5：對 tmux pane mapping

**核心約束**：PID 不一定是 tmux pane 的 direct child（尤其是 daemon、background process、LSP server）。使用多重證據判斷，不硬說確定。

```sh
# 取得所有 tmux pane 資訊
tmux list-panes -a -F '#{session_name}:#{window_index}.#{pane_index} #{window_name} pane_pid=#{pane_pid} active=#{pane_active} current_path=#{pane_current_path} current_command=#{pane_current_command}'
```

**信心等級判斷規則**：

| 條件 | 信心 |
|---|---|
| TTY 相同 + 可追到 pane PID 的 parent chain | 高 |
| `cwd` === pane `current_path` + `current_command` 與 process 一致 | 高 |
| 只有 `cwd` 與 pane `current_path` 路徑接近 | 中 |
| process 是 pane 的 child process 間接啟動（如 LSP、plugin） | 中 |
| process 已 daemonize（PPID=1）、無 TTY、無 direct tmux 關係 | 低 — 僅列為可能來源 |

如果無法精準對到 pane，至少列出 `cwd`、`parent` chain 和 workspace 線索，讓使用者自己判斷。

### Phase 6：Docker/VM 深入檢查

若有 Docker 或 VM：檢查容器層、VM 設定、disk I/O。

```sh
# 容器列表
docker ps --format 'table {{.ID}}\t{{.Image}}\t{{.Status}}\t{{.Names}}'

# 容器資源
docker stats --no-stream --format 'table {{.Container}}\t{{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.NetIO}}\t{{.BlockIO}}'

# 檢查 kind cluster 名稱
docker ps --filter 'name=kindest/node' --format '{{.Names}}'
```

### Phase 7：輸出結論

使用以下格式報告。

```md
## 資源診斷結論

### 最可能造成發熱的主因
- **程序**：`<process> (<PID>)` — `<%CPU>% CPU, <%MEM>% Mem`
- **運作時間**：`<etime>`
- **累積 CPU 時間**：`<cputime>`
- **tmux mapping**：`<session:window.pane>`（如有）
- **證據**：...

### Other Suspects（依影響力排序）

| Rank | PID | Process | CPU | Mem | Runtime | cputime | tmux mapping | Confidence |
|---|---|---|---|---|---|---|---|---|
| 1 | ... | ... | ... | ... | ... | ... | ... | high/中/low |

### Process Groups（同一 parent chain 的關聯程序）

| Group | 總影響 | PID list | 說明 |
|---|---|---|---|

### macOS Thermal/Power 摘要
- Thermal 警告：無 / 有（詳情）
- 電池：充電中 / 放電中
- PreventUserIdleSystemSleep：擁有者、原因

### Recommended Next Steps
1. ...
2. ...
3. ...
```

---

## Edge Cases

- **無法取得 tmux pane 資料**：若使用者在 tmux 外或權限不足，跳過 tmux mapping 步驟，只靠 cwd 和 process tree 歸因。
- **多台 Docker VM**：檢查 `docker info` 找出 VM type。
- **Ventura+ 的 App Nap 干擾**：有些 process 在後台時 macOS 會暫停，不一定是真實耗能。
- **Intel Mac vs Apple Silicon**：Intel 用 `powermetrics`（需 sudo）可看更細的 CPU/GPU power。Apple Silicon 已限制 powermetrics 權限，以 `pmset` 和 `log` 為主。
- **使用者要求 kill / suspend / restart**：只在收到明確指示時行動。行動前再次跟使用者確認。
- **system process 異常高 CPU**：如果系統程序（ecosystemd、trustd）異常，先檢查是否有其他 process 大量呼叫它，而非直接指著系統程序。

---

## 禁用情境

- 不要對遠端或 SSH session 做本機資源診斷。
- 不要修改系統設定（如亮度、自動休息），除非被要求。
- 不要在診斷過程中安裝或更新任何工具 / package。
