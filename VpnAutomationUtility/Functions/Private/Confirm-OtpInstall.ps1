function Confirm-OtpInstall {
    $packageLocation = $env:TEMP;
    $dllPath = [System.IO.Path]::Combine($packageLocation, "Otp.NET.1.2.2\lib\net45\Otp.NET.dll");

    if( -not (Test-Path $dllPath) ) {
        Write-Host "Installing Otp.NET ($dllPath)";
        Install-Package -Name Otp.NET -ProviderName NuGet -Scope CurrentUser -RequiredVersion 1.2.2 -Destination "$packageLocation" -SkipDependencies -Force -ErrorAction SilentlyContinue;
    } else {
        Write-Host "Skipping Otp.NET download.  Found at $dllPath";
    }

    $dllPath;
}