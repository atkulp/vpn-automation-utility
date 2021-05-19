function Start-FortiVpnConnection([string] $vpnhost, [string] $user, [SecureString] $password, [string] $otpKey) {
    
    Write-Host "CONNECTING TO FORTI IS NOT FUNCTIONAL YET!  Just a work-in-progress";

    Write-Host "Stopping active FortiSSLVPNclient"
    Get-Process -Name "FortiSSLVPNclient" -ErrorAction SilentlyContinue | ForEach-Object { Write-Host "Stopping process #$($_.Id)"; $_.Kill(); };

    Write-Host "Generating TOTP";
    $totp = Get-Totp $otpKey;
    $totp;

    Write-Host "Connecting"
    $sw = New-Object System.Diagnostics.Stopwatch;
    $sw.start();

    $args = "connect -h $vpnhost -u $($user):$($password)$($totp) -i -q -m";
    $args;

    $p = Start-Process -FilePath ".\FortiSSLVPNclient.exe" -Args $args -PassThru -RedirectStandardOutput "out.txt" -WindowStyle Hidden;

	$p.WaitForExit(20000);
}