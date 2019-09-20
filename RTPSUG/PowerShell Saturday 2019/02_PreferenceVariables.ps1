return 'This file is for interactive demo purposes and should not be executed as a script'

# Back to Preference Variables
Get-Help about_Preference_Variables -ShowWindow

<#
Cmdlet              Preference Variable             Valid Values (Default)
------              -------------------             ----------------------
Write-Error         $ErrorActionPreference          Stop, Inquire, (Continue), Suspend, SilentlyContinue
Write-Warning       $WarningPreference              Stop, Inquire, (Continue), SilentlyContinue
Write-Verbose       $VerbosePreference              Stop, Inquire, Continue, (SilentlyContinue)
Write-Debug         $DebugPreference                Stop, Inquire, Continue, (SilentlyContinue)
Write-Information   $InformationActionPreference    Stop, Inquire, Continue, Suspend, (SilentlyContinue)
#>

## Reviewing default behavior for Verbose and Error
"Verbose Preference: $VerbosePreference"
"Error Preference:   $ErrorActionPreference"
Write-AdvancedHello2 -Name 'PSSaturday2'

## Changing Verbose preference for the current session
$VerbosePreference = 'Continue'

## Changing Error preference for the current session (What Errors?)
$ErrorActionPreference = 'SilentlyContinue'

## Now Verbose is outputted, but Error is not
"Verbose Preference: $VerbosePreference"
"Error Preference:   $ErrorActionPreference"
Write-AdvancedHello2 -Name 'PSSaturday2'

## Overriding Error back to default value of 'Continue' for a single command
Write-AdvancedHello2 -Name 'PSSaturday2' -Verbose -ErrorAction Continue

## Setting Verbose and Error back to their default values
$VerbosePreference = 'SilentlyContinue'
$ErrorActionPreference = 'Continue'

# Regardles of preference variable, output can be stored to their own variables
'PSSaturday', 'PSSaturday2', 'Test Name' | 
Write-AdvancedHello2 -ErrorVariable wahErrors -WarningVariable wahWarnings -InformationVariable wahInfo

#No Verbose Variable, however...
$wahErrors
$wahWarnings
## wahInfo populated even though the messages did not get outputted to the console
$wahInfo