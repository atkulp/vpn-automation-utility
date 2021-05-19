function Start-SophosVpnConnection([string] $configName, [string] $user, [SecureString] $password, [string] $otpKey, [bool] $killExisting = $false) {

    $configPath = [System.IO.Path]::Combine($MyInvocation.MyCommand.Module.PrivateData.Constants.OpenVpnBasePath, "config\$($configName).ovpn");
    Write-Host "Connecting to $configName using Sophos";

    if( $killExisting ) {
        Write-Host "Stopping any active connections";
        Stop-SophosVpnConnections;
    }

    Write-Host "Checking for available VPN network interface";
    Get-SophosVpnAdapters | Out-Null;

    Write-Host "Generating TOTP ($otpKey)";
    $totp = Get-Totp $otpKey;
    $totp;

    Write-Host "Generating auth file";
    $authFile = Write-SophosAuthFile $user $password $totp;

    Write-Host "Starting connection";
    Connect-SophosVpn $configPath $authFile;
    
    Write-Host "Removing auth file";
    Remove-Item $authFile;
}
