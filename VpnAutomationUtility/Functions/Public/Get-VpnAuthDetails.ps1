function Get-VpnAuthDetails([string] $profileName, $otpOnly = $false) {
    $path = [System.IO.Path]::Combine($env:USERPROFILE, "vpn-$profileName.json");
    $props = Get-Content $path -Raw -ErrorAction SilentlyContinue | ConvertFrom-Json;

    if( -not $props ) {
        $props = @{
            otpKey = Read-Host -Prompt "Enter TOTP key";
        };

        if( -not $otpOnly ) {
            $props.profileName = Read-Host -Prompt "Enter VPN profile name (i.e. first.last@hosting.local...)";
            $props.userName = Read-Host -Prompt "Enter $profileName username";
            $props.securePassword = Read-Host -Prompt "Enter $profileName password" -AsSecureString;

            $props.clone() | `
                Execute-Script { $_.securePassword = ConvertFrom-SecureString $props.securePassword ; } | `
                ConvertTo-Json | `
                Set-Content -Path $path;
        } else {
            $props | ConvertTo-Json | Set-Content -Path $path;
        }

    } elseif (-not $otpOnly ) {
        $props.securePassword = if( $props.securePassword ) { ConvertTo-SecureString $props.securePassword };
    }

    $props;
}