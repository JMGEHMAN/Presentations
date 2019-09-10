# PowerShell Streams and Using the right "Write-*" Cmdlet

## The Problem

### Write-Host is great. Until it isn't

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

| Stream # | Description | Introduced in | Preference Variable | Default Value | Common Parameter |
| --- | --- | --- | --- | --- | --- |
| 1 | Success Stream | PowerShell 2.0 | | | |
| 2 | Error Stream | PowerShell 2.0 | ErrorActionPreference | Continue | ErrorAction
| 3 | Warning Stream | PowerShell 3.0 | WarningPreference | Continue | WarningAction
| 4 | Verbose Stream | PowerShell 3.0 | VerbosePreference | SilentlyContinue | Verbose
| 5 | Debug Stream | PowerShell 3.0 | DebugPreference | SilentlyContinue | Debug
| 6 | Information Stream | PowerShell 5.0 | InformationPreference | SilentlyContinue | InformationAction 
| * | All Streams | PowerShell 3.0 | | | |

## Other Resources

* [Understanding Streams, Redirection, and Write-Host in PowerShell](https://devblogs.microsoft.com/scripting/understanding-streams-redirection-and-write-host-in-powershell/)
* [PowerShell Best Practices & Style Guide: Output and Formatting](https://poshcode.gitbooks.io/powershell-practice-and-style/Best-Practices/Output-and-Formatting.html)
* [about_functions_adanced](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions_advanced)
