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

## Other Resources

* [Understanding Streams, Redirection, and Write-Host in PowerShell](https://devblogs.microsoft.com/scripting/understanding-streams-redirection-and-write-host-in-powershell/)
* [PowerShell Best Practices & Style Guide: Output and Formatting](https://poshcode.gitbooks.io/powershell-practice-and-style/Best-Practices/Output-and-Formatting.html)
* [about_functions_adanced](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions_advanced)
