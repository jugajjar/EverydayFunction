function Get-Greeting {
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