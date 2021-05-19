# vpn-automation-utility
Simple automation script to connect to Sophos VPN without user interaction

## Examples to connect to profiles
Add these to something in your path so you can connect quickly with a single cmdlet.  On first run, it will collect details needed for the connectiong.

### Connect to Sophos VPN profile
```
function Connect-SophosSample([bool] $killExisting = $false) {
    $props = Get-VpnAuthDetails "profile-name";
    Start-SophosVpnConnection $props.profileName $props.userName $props.securePassword $props.otpKey $killExisting;
}
```

### Connect to Forti VPN profile (not actually supported yet...)
```
function Connect-FortiSample([bool] $killExisting = $false) {
    $props = Get-VpnAuthDetails "profile-name" $true;
    $totp = Get-Totp $props.otpKey;
    Write-Host "Unsupported vpn (Forti).  Generated TOTP.";
    $totp;
}
```

