return 'This file is for interactive demo purposes and should not be executed as a script'

# What 'Write-*' cmdlets are we talking about?
## Close, but too much 'noise'
Get-Command Write*
Get-Command -Verb Write

## Eliminate the noise - show only the core PowerShell cmdlets
Get-Command -Verb Write -Module Microsoft.PowerShell.Utility


# Purpose of presentation is to review each cmdlet so you understand how they work and how they should be used
## Difference between Write-Output' and 'Write-Host'?

## Help is always a great place to go (I always use -ShowWindow, or -Online)
### -Online: (Prefered) Displays online, which is the latest, version of documentation in browser
### -ShowWindow: (Backup) Displays local version of documentation in seperate window
Get-Help Write-Output -Online
Get-Help Write-Host -ShowWindow


## Help documentation fo 'Write-Output' states,
###  "...because the default behavior is to display the objects at the end of a pipeline, it is generally not necessary to use the cmdlet."

### Verifying the same thing happens with or without 'Write-Output'
Write-Output 'Testing Write-Output'
'Testing Write-Output'

### ...Including in the pipeline
'Testing with Write-Output.' | Write-Output | Out-File -FilePath .\Write-Output_Test.txt -Append
'Testing without Write-Output.' | Out-File -FilePath .\Write-Output_Test.txt -Append

### Both commands outputted to the text file with or  without 'Write-Output'
Get-Content -Path .\Write-Output_Test.txt


# While 'Write-Output' may not be necessary, people are usually familiar with 'Write-Host'...