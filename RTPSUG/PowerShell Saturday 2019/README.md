# PowerShell Stream and using the right "Write-*" Cmdlet

The files in directory are intended to show how PowerShell's design seperates Error, Verbose, Debug, Warning, and Informational output from the actual data that is passed down the pipeline.

| File | Comment |
| ---| --- |
| [PowerShell Streams and using the right Write- Cmdlet.pdf](PowerShell%20Streams%20and%20using%20the%20right%20Write%20Cmdlet.pdf) | Slide Deck - Introductory and Summary information |
| [00_Introduction.ps1](00_Introduction.ps1) | Shows what the Write cmdlets are and how they all behave when included in a function
| [01_CmdletBinding.ps1](01_CmdletBinding.ps1) | Shows that adding ```[CmdletBinding()]``` adds a lot of additional features that directly impact output |
| [02_PreferenceVariables.ps1](02_PreferenceVariables.ps1) | Shows how the streams can be controlled with preference variables |
| [03_WriteInformation.ps1](03_WriteInformation.ps1) | Shows how ```Write-Information``` can be used - specifically tagging messages.
| [Write-Hello.ps1](Write-Hello.ps1) | Shows how basic fuctions are inadquate and do not leverage streams |
| [Write-AdvancedHello.ps1](Write-AdvancedHello.ps1) | Shows how simply adding ```[CmdletBinding()]``` to a script or function opens up a lot of new possibilities |
| [Write-AdvancedHello2.ps1](Write-AdvancedHello2.ps1) | Shows how to leverage the **Cmdlet (Advanced Function)** code snippet in ISE |
| [Write-AdvancedHello3.ps1](Write-AdvancedHello3.ps1) | Shows how adding tags to 'Write-Information' commands can help with collecting data |
