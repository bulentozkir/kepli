$ErrorActionPreference = 'Stop'
$toolArguments = @($args)
$privateTools = Join-Path $env:LOCALAPPDATA 'KepliDev'
$projectRoot = Split-Path $PSScriptRoot -Parent
$pinned = (Get-Content -LiteralPath (Join-Path $projectRoot '.fvmrc') -Raw | ConvertFrom-Json).flutter
$installedFlutter = Get-Command flutter -CommandType Application -ErrorAction SilentlyContinue
$flutter = @(
    (Join-Path $projectRoot '.fvm\flutter_sdk\bin\flutter.bat'),
    (Join-Path $privateTools "flutter-$pinned\bin\flutter.bat"),
    $(if ($installedFlutter) { $installedFlutter.Source }),
    (Join-Path $privateTools 'flutter\bin\flutter.bat')
) | Where-Object { $_ -and (Test-Path -LiteralPath $_) } | Select-Object -First 1
if (-not $flutter) {
    throw "Install Flutter $pinned and put its bin directory on PATH."
}
$executable = $flutter
if ($toolArguments.Count -gt 0 -and $toolArguments[0] -eq 'dart') {
    $executable = Join-Path (Split-Path $flutter) 'dart.bat'
    $toolArguments = @($toolArguments | Select-Object -Skip 1)
}
$previous = @{}
foreach ($name in @('PATH', 'JAVA_HOME', 'ANDROID_HOME', 'ANDROID_SDK_ROOT', 'FLUTTER_SUPPRESS_ANALYTICS', 'DART_SUPPRESS_ANALYTICS')) {
    $previous[$name] = [Environment]::GetEnvironmentVariable($name, 'Process')
}
$exitCode = 1
Push-Location $projectRoot
try {
    $env:FLUTTER_SUPPRESS_ANALYTICS = 'true'
    $env:DART_SUPPRESS_ANALYTICS = 'true'
    $javaRoot = Join-Path $privateTools 'java'
    if (-not $env:JAVA_HOME -and (Test-Path -LiteralPath $javaRoot)) {
        $jdk = Get-ChildItem -LiteralPath $javaRoot -Directory |
            Where-Object { Test-Path -LiteralPath (Join-Path $_.FullName 'bin\java.exe') } |
            Sort-Object LastWriteTime -Descending |
            Select-Object -First 1
        if ($jdk) { $env:JAVA_HOME = $jdk.FullName }
    }
    if ($env:JAVA_HOME) { $env:PATH = "$env:JAVA_HOME\bin;$env:PATH" }
    $android = Join-Path $privateTools 'android-sdk'
    if (-not $env:ANDROID_HOME -and -not $env:ANDROID_SDK_ROOT -and (Test-Path -LiteralPath $android)) {
        $env:ANDROID_HOME = $android
        $env:ANDROID_SDK_ROOT = $android
    }
    & $executable @toolArguments
    $exitCode = $LASTEXITCODE
} finally {
    Pop-Location
    foreach ($entry in $previous.GetEnumerator()) {
        [Environment]::SetEnvironmentVariable($entry.Key, $entry.Value, 'Process')
    }
}
exit $exitCode
