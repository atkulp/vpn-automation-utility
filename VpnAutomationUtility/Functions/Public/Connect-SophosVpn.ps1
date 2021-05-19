function Connect-SophosVpn([string] $configPath, [string] $authPath) {
    $sw = New-Object System.Diagnostics.Stopwatch;
    $sw.Start();

    $openVpnBinPath = Confirm-SophosInstall;

    $cmdArgs = "--config `"$configPath`" --auth-user-pass `"$authPath`"";
    $p = Start-Process -FilePath $openVpnBinPath -Args $cmdArgs -PassThru -RedirectStandardOutput "out.txt" -WindowStyle Hidden;

    $running = $true;

    while( $running ) {
        Start-Sleep -Seconds 2;
        write-host 'waiting on connection...';
        $out = Get-Content "out.txt" -raw;
        if( $out -match "Initialization Sequence Completed") {
            write-host "Connection successfully started after $($sw.Elapsed.TotalSeconds) seconds";
            $running = $false;
        } elseif( $p.HasExited ) {
            Write-Host "VPN process crashed before connecting";
            $out;
            $running = $false;
        } elseif( $sw.Elapsed.TotalSeconds -ge 30 ) {
            Write-Host "Unable to connect after 30 seconds";
            $out;
            $running = $false;
        }
    }

    $sw.Stop();
    $p;
}