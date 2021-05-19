function Stop-SophosVpnConnections() {
    Get-Process -Name "openvpn" -ErrorAction SilentlyContinue | ForEach-Object { Write-Host "Stopping process #$($_.Id)"; $_.Kill(); };
}