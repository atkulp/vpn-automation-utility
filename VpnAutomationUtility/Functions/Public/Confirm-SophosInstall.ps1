function Confirm-SophosInstall {
    $OPEN_VPN_BIN_PATH = [System.IO.Path]::Combine($MyInvocation.MyCommand.Module.PrivateData.Constants.OpenVpnBasePath, "bin\openvpn.exe");

    Write-Host (Convertto-json $MyInvocation.MyCommand.Module.PrivateData.Constants);
    Write-Host $OPEN_VPN_BIN_PATH;

    if( -not (Test-Path $OPEN_VPN_BIN_PATH)) {
        Write-Error "Sophos SSL VPN Client doesn't appear to be installed ($OPEN_VPN_BIN_PATH)";
    }

    $OPEN_VPN_BIN_PATH;
}