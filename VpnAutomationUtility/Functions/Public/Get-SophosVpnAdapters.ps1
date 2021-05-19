function Get-SophosVpnAdapters() {
    $availableVpnAdapters = [System.Net.NetworkInformation.NetworkInterface]::GetAllNetworkInterfaces() `
        | Where-Object {$_.Description -Contains "Sophos SSL VPN Adapter" -and $_.OperationalStatus -eq [System.Net.NetworkInformation.OperationalStatus]::Down }

    if ($availableVpnAdapters.Length -eq 0 ) {
        $ADD_TAP_PATH = [System.IO.Path]::Combine($MyInvocation.MyCommand.Module.PrivateData.Constants.OpenVpnBasePath, "bin\addtap.bat");
        Write-Error "There are no available VPN Adapters to use.  You need to have one VPN adapter per simultaneous VPN connection.  To add more VPN adapters, run the following command as Administrator: $ADD_TAP_PATH";
    }

    $availableVpnAdapters;
}