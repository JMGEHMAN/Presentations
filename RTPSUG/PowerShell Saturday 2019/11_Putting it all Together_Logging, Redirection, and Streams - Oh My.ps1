return 'This file is for interactive demo purposes and should not be executed as a script'

# How do I redirect verbose, informational, error, or warning output?
## You'll never guess - there's a help document for that
Get-Help about_Redirection -Online  #sign, it's always worth a try

## What happens when you try to redirect the basic function output?
### Remember, this is what we are working with
Get-command Write-Hello | Select-Object -ExpandProperty Definition

### Baseline: No redirection (Where is 'Write-Host' output?)
Write-Hello -Name 'name1', $env:USERNAME, 'PSSaturday' > .\Hello-NoRedirection.log
. .\Hello-NoRedirection.log

### Redirect all the things!
#### Note: Write-Host output included in PS 5.0+
Write-Hello -Name 'name1', $env:USERNAME, 'PSSaturday' *> .\Hello-TotalRedirection.log
. .\Hello-TotalRedirection.log

### Repeat test with advanced function
### Baseline: No redirection (same results as basic function)
Write-AdvancedHello -Name 'name1', $env:USERNAME, 'PSSaturday' > .\AdvancedHello-NoRedirection.log
. .\AdvancedHello-NoRedirection.log

### Redirect all the things! (No Debug or Verbose)
Write-AdvancedHello -Name 'name1', $env:USERNAME, 'PSSaturday' *> .\AdvancedHello-TotalRedirection.log
. .\AdvancedHello-TotalRedirection.log

### Can we redirect debug and verbose only?
Write-AdvancedHello -Name 'name1', $env:USERNAME, 'PSSaturday' 4>&1 5>&1 > .\AdvancedHello-DebugVerboseRedirection.log
. .\AdvancedHello-DebugVerboseRedirection.log

### Can we redirect debug and verbose only (round 2)?
Write-AdvancedHello -Name 'name1', $env:USERNAME, 'PSSaturday' -Debug 4>&1 5>&1 > .\AdvancedHello-DebugVerboseRedirection2.log
. .\AdvancedHello-DebugVerboseRedirection2.log
