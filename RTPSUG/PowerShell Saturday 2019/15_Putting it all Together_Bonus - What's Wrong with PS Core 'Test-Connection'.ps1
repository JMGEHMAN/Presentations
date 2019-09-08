return 'This file is for interactive demo purposes and should not be executed as a script'

# PowerShell Streams and Using the right "Write-*" Cmdlet

## The Problem (#1)

### Write-Host is great...
#### Write the rainbow
for ($i = 0; $i -lt 10000; $i++) {
    $fColor = [enum]::GetValues([System.ConsoleColor]) | Get-Random
    $bColor = [enum]::GetValues([System.ConsoleColor]) | Get-Random

    #Let's display all the pretty colors!
    Write-Host -ForegroundColor $fColor -BackgroundColor $bColor -Object 'PowerShell is Awesome!'
}

#### Using Write-Host to mimic Verbose, Error, and Informational output
function Get-RandomFromInput {
    $validMax = 100

    do {
        [int]$numberMax = Read-Host -Prompt "Enter a number between 1 and $validMax"
        $isValidNumber = $numberMax -ge 1 -and $numberMax -le $validMax

        if ($isValidNumber) {
            Write-Host -ForegroundColor Green "Using numberMax of '$numberMax'."
        } else {
            Write-Host -ForegroundColor Red 'Really?!'

        }
    }until($isValidNumber)

    #Spinkle in some debugging output as I try to fix an issue
    Write-Host -ForegroundColor Cyan "Selecting Random number between '1' and '$numberMax'"
    1..$numberMax | Get-Random
}


### ...Until it isn't
for ($i = 0; $i -lt 1000; $i++) {
    $fColor = [enum]::GetValues([System.ConsoleColor]) | Get-Random
    $bColor = [enum]::GetValues([System.ConsoleColor]) | Get-Random

    #Let's save our messages to a log file
    Write-Host -ForegroundColor $fColor -BackgroundColor $bColor -Object 'PowerShell is Awesome!' |
    Out-File -FilePath .\Output\Write-Host.log
}

### Where my log at?!
Get-Content -Path .\Output\Write-Host.log

### Maybe Tee-Object will do the trick?
for ($i = 0; $i -lt 1000; $i++) {
    $fColor = [enum]::GetValues([System.ConsoleColor]) | Get-Random
    $bColor = [enum]::GetValues([System.ConsoleColor]) | Get-Random

    #Let's save our messages to a log file
    Write-Host -ForegroundColor $fColor -BackgroundColor $bColor -Object 'PowerShell is Awesome!' |
    Tee-Object -FilePath .\Output\Write-Host.log
}

#Still no logs
Get-Content -Path .\Output\Write-Host.log


### When Write-Host isn't right

## Introducing the "Write" Family

```powershell
#Option A
Get-Command Write-*

#Option B
Get-Command -Verb Write

#Eliminate the noise - show only the core PowerShell cmdlets
Get-Command -Verb Write -Module Microsoft.PowerShell.Utility
```

## Testing each Write cmdlet

```powershell
Write-Debug -Message 'This is a debug message'
Write-Error -Message 'This is an error message'
Write-Host
Write-Information
Write-Output
Write-Progress
Write-Verbose
Write-Warning

```

## Other Resources

* [Understanding Streams, Redirection, and Write-Host in PowerShell](https://devblogs.microsoft.com/scripting/understanding-streams-redirection-and-write-host-in-powershell/)
* [PowerShell Best Practices & Style Guide: Output and Formatting](https://poshcode.gitbooks.io/powershell-practice-and-style/Best-Practices/Output-and-Formatting.html)
* [about_functions_adanced](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions_advanced)




[console]::beep()