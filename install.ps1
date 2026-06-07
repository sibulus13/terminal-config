# dotfiles install script — Windows (PowerShell)
# Run once after cloning: .\install.ps1
# Creates junctions from ~/.config/<tool> -> dotfiles/<tool>
# Junctions work without elevation; existing dirs are backed up, not deleted.

param(
  [switch]$DryRun
)

$DOTFILES = $PSScriptRoot
$CONFIG   = "$env:USERPROFILE\.config"

# Map: dotfiles subdir -> target path (Windows-side junctions)
$links = @{
  "wezterm" = "$CONFIG\wezterm"
}

# Dependencies reminder
Write-Host ""
Write-Host "=== dotfiles install ===" -ForegroundColor Cyan
Write-Host "Windows dependencies:"
Write-Host "  - Git for Windows  (provides bash at C:\Program Files\Git\bin\bash.exe)"
Write-Host "  - JetBrains Mono font  (https://www.jetbrains.com/lp/mono/)"
Write-Host "  - WezTerm  (https://wezfurlong.org/wezterm/)"
Write-Host ""
Write-Host "Optional (persistent context panel):"
Write-Host "  - WSL2 + Ubuntu  (run: wsl --install, then restart)"
Write-Host "  - Zellij in WSL2 (after WSL2: curl -L <release> | tar xz && mv zellij /usr/local/bin/)"
Write-Host "  - dotfiles/zellij/ will be symlinked to ~/.config/zellij inside WSL2"
Write-Host "  - Run zellij/install-wsl.sh from inside WSL2 after setup"
Write-Host ""

if (-not (Test-Path $CONFIG)) { New-Item -ItemType Directory -Path $CONFIG | Out-Null }

foreach ($entry in $links.GetEnumerator()) {
  $src  = Join-Path $DOTFILES $entry.Key
  $dest = $entry.Value

  if (-not (Test-Path $src)) {
    Write-Host "SKIP  $($entry.Key) — source not found at $src" -ForegroundColor Yellow
    continue
  }

  if (Test-Path $dest) {
    $item = Get-Item $dest
    if ($item.LinkType -eq "Junction" -and $item.Target -eq $src) {
      Write-Host "OK    $dest  (junction already correct)" -ForegroundColor Green
      continue
    }
    # Back up before replacing
    $backup = "$dest.bak"
    Write-Host "BACKUP $dest -> $backup" -ForegroundColor Yellow
    if (-not $DryRun) { Rename-Item $dest $backup }
  }

  Write-Host "LINK  $dest -> $src" -ForegroundColor Cyan
  if (-not $DryRun) {
    New-Item -ItemType Junction -Path $dest -Target $src | Out-Null
  }
}

Write-Host ""
Write-Host "Done. Open WezTerm to verify." -ForegroundColor Green
