# Check and set the execution policy to allow scripts to run (if needed)
$executionPolicy = Get-ExecutionPolicy
if ($executionPolicy -ne 'RemoteSigned' -and $executionPolicy -ne 'Unrestricted') {
    Write-Host "Setting execution policy to RemoteSigned to allow script execution."
    Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned -Force
} else {
    Write-Host "Execution policy is already set to allow script execution."
}

# Define the profile path
$profilePath = $PROFILE

# Define the line to add to the profile
$iexLine = "iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/jugajjar/EverydayFunction/main/Functions.ps1'))"

# Check if the profile exists
if (Test-Path $profilePath) {
    # If profile exists, check if the line is already present
    $profileContent = Get-Content $profilePath
    if ($profileContent -notcontains $iexLine) {
        # Add the line to the profile if not already there
        Add-Content -Path $profilePath -Value "`r`n$iexLine"
        Write-Host "The line has been added to your PowerShell profile."
    } else {
        Write-Host "The line is already present in your profile."
    }
} else {
    # If the profile doesn't exist, create it and add the line
    New-Item -ItemType File -Path $profilePath -Force
    Add-Content -Path $profilePath -Value "`r`n$iexLine"
    Write-Host "PowerShell profile created and the line has been added."
}