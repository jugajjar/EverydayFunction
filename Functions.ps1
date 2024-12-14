function Get-Greeting {
    <#
.SYNOPSIS
    Displays a personalized greeting based on the current time of day.

.DESCRIPTION
    The `Get-Greeting` function determines the current hour and selects an appropriate greeting based on the time of day (Morning, Afternoon, Evening, or Night). It then greets the current user by name, displaying a message such as "Good Morning, [User]!" in the PowerShell console.

.PARAMETER None
    This function does not accept any parameters.

.EXAMPLE
    Get-Greeting
    Output:
        Good Morning, JohnDoe! Welcome to your PowerShell session.
        (The greeting will change depending on the current time of day.)
    #>
    # Get the current hour
    $currentHour = (Get-Date).Hour

    # Determine the greeting based on the current time of day
    if ($currentHour -ge 5 -and $currentHour -lt 12) {
        $greeting = "Good Morning"
    }
    elseif ($currentHour -ge 12 -and $currentHour -lt 17) {
        $greeting = "Good Afternoon"
    }
    elseif ($currentHour -ge 17 -and $currentHour -lt 21) {
        $greeting = "Good Evening"
    }
    else {
        $greeting = "Good Night"
    }

    # Get the current user's name
    $user = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name.Split('\')[-1]

    # Combine the greeting with the user's name
    Write-Host "$greeting, $user! Welcome to your PowerShell session."
}
function Get-MyComputerDetails {
    # Get basic system information
    $computerName = $env:COMPUTERNAME
    $windowsVersion = [System.Environment]::OSVersion.Version
    $makeAndModel = (Get-WmiObject -Class Win32_ComputerSystem)
    $serialNumber = (Get-WmiObject -Class Win32_BIOS).SerialNumber

    # Get current logged in user
    $loggedInUser = (Get-WmiObject -Class Win32_ComputerSystem).UserName

    # Get Windows activation key (if available via the registry)
    $activationKey = (Get-WmiObject -Class SoftwareLicensingService).OA3xOriginalProductKey

    # Get BIOS version
    $biosVersion = (Get-WmiObject -Class Win32_BIOS).Version

    # Get battery health
    $batteryHealth = ""
    if ($makeAndModel.SystemType -match "x86|x64") {
        $battery = Get-WmiObject -Class Win32_Battery
        if ($battery) {
            $batteryHealth = "Battery Status: $($battery.Status), Estimated Charge: $($battery.EstimatedChargeRemaining)%"
        } else {
            $batteryHealth = "Battery not detected."
        }
    }

    # Return a custom object with all the details
    [PSCustomObject]@{
        ComputerName   = $computerName
        Make           = $makeAndModel.Manufacturer
        Model          = $makeAndModel.Model
        SerialNumber   = $serialNumber
        BIOSVersion    = $biosVersion
        WindowsVersion = "$($windowsVersion.Major).$($windowsVersion.Minor) ($($windowsVersion.Build))"
        LoggedInUser   = $loggedInUser
        ActivationKey  = $activationKey
        BatteryHealth  = $batteryHealth
    }
}