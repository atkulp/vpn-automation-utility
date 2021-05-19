function Get-Totp([string] $key) {
    $dllPath = Confirm-OtpInstall;

    [System.Reflection.Assembly]::LoadFrom($dllPath) | Out-Null;
    $keyBytes = [OtpNet.Base32Encoding]::ToBytes($key);
    $totp = New-Object OtpNet.Totp -ArgumentList @(,$keyBytes);
    $token = $totp.ComputeTotp();
    [System.Reflection.Assembly]::UnsafeLoadFrom($dllPath) | Out-Null;

    Set-Clipboard -Value $token;
    $token;
}