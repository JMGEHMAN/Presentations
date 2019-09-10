return 'This file is for interactive demo purposes and should not be executed as a script'

# Fitting nicely within the PowerShell pipeline is reason enough to leverage the Write-* cmdlet and common parameters and variables

## Anti-pattern: messages that "polute the pipeline"
### Bringing back our basic function example...
Get-command Write-Hello | Select-Object -ExpandProperty Definition

### Things may seem OK now
Write-Hello -Name 'name1', $env:USERNAME, 'PSSaturday'

### But what about now.
Write-Hello -Name 'name1', $env:USERNAME, 'PSSaturday' | Sort-Object

### Or now
Write-Hello -Name 'name1', $env:USERNAME, 'PSSaturday' | ConvertTo-CSV -NoTypeInformation | Out-File -FilePath .\HelloOutput.csv
. .\HelloOutput.csv

## Best-Practice: Function output not poluted by Warning, Error, Verbose, Informational messages
Write-AdvancedHello -Name 'name1', $env:USERNAME, 'PSSaturday'

### Warning and error messages not process by Sort-Object
Write-AdvancedHello -Name 'name1', $env:USERNAME, 'PSSaturday' | Sort-Object

### Warning and error messages not written to log 
Write-AdvancedHello -Name 'name1', $env:USERNAME, 'PSSaturday' | Sort-Object | Out-File -FilePath .\AdvancedHelloOutput.csv
. .\AdvancedHelloOutput.csv

### Optional Verbose and Informational message are not written either
Write-AdvancedHello -Name 'name1', $env:USERNAME, 'PSSaturday' -Verbose -InformationAction 'Continue' | 
Sort-Object | Out-File -FilePath .\AdvancedHelloOutput2.csv
. .\AdvancedHelloOutput2.csv

# Doing things the "PowerShell Way" is awesome! But how is this working, and what if I want to have error messages included in output?