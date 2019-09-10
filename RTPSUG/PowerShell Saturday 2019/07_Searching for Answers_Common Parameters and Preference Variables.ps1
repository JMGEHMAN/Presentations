return 'This file is for interactive demo purposes and should not be executed as a script'

# How can we control Common Parameters?
## "Several common parameters override system defaults or preferences that you set by using the Windows PowerShell preference variables. Unlike the preference variables, the common parameters affect only the commands in which they are used."
Get-Help about_CommonParameters -Online  #-Online doesn't work. Just search online for 'about_CommonParameters'.

## Looks like we're looking up Preference Variables now
Get-Help about_Preference_Variables -Online  #Sign. Doing online search for 'about_Preference_Variables' again.

## Let's get the preference variables and their current values (sort by default setting)
Get-Variable *preference | Sort-Object Value

## Let's focus on InformationPreference
## Getting Informational output (for current command only)
'name1', 'name2', 'name3' | Write-AdvancedHello -InformationAction 'Continue'

## Getting Informational output (for all commands)
$InformationPreference = 'Continue'
'name1', 'name2', 'name3' | Write-AdvancedHello

# Preference variables can be set (ignoring 'Confirm' and 'WhatIf' preference variables):
## * 'SilentlyContinue' = no output
## * 'Continue          = message displayed/action taken
## * 'Stop'             = Processing is halted

## The informational messages can be set to halt processing
$InformationPreference = 'Stop'
'name1', 'name2', 'name3' | Write-AdvancedHello

## Setting 'InformationPreference' back to default value
$InformationPreference = 'SilentlyContinue'

# But wait, there's even MORE fun with variables!
## Not only can common parameters be configured per command, they can be saved to their own variables - per command

## Save error, warning, and informational messages to their own variable
### Remember, '$' is not part of the variable name
'name1', $env:USERNAME, 'PSSaturday' | Write-AdvancedHello -ErrorVariable wahErrors -WarningVariable wahWarnings -InformationVariable wahInfo

## Which variables will be populated? Does it matter if the preference is set to 'Continue' or 'SilentlyContinue'?
### As a reminder...
$ErrorActionPreference
$WarningPreference
$InformationPreference

### Drumroll...
$wahErrors
$wahWarnings
$wahInfo

## Having these messages saved to their own variables lets you determine what to do next - log messages, parse for content, logical decisions, etc