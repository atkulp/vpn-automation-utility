function Write-SophosAuthFile([string] $user, [securestring] $password, [string] $otpKey) {
    $plainpwd = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password))

    $path = [System.IO.Path]::GetTempFileName();
    Set-Content -Path $path -Value "$user`r`n$plainpwd$otpKey";
    $path;
}