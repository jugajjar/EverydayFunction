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