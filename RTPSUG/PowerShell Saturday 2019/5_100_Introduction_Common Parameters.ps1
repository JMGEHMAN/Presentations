return 'This file is for interactive demo purposes and should not be executed as a script'

# What are Common Parameters and what do they give us?
## "...common parameters are also available on advanced functions that use the CmdletBinding attribute or the Parameter attribute..."
Get-Help about_CommonParameters -Online

# Trying the "Parameter attribute" route
## ISE has templates (ctrl + j), and there's a Function template
## VS Code has templates too (called 'Snippets'), just type "fun" and select the Function snippet

### From ISE's Function template
function Get-RandomFromInput([int]$NumberMax = (Read-Host -Prompt "Enter a number between 1 and $validMax")) {

    $isValidNumber = $numberMax -ge 1 -and $numberMax -le $validMax

    if ($isValidNumber) {

        Write-Host -ForegroundColor Green "SUCCESS: Using numberMax of '$numberMax'."
    } else {
        #Mimicing a PowerShell error message
        Write-Host -ForegroundColor Red 'ERROR: Really?!'

    }

    #Mimicing a PowerShell verbose message
    Write-Host -ForegroundColor Cyan "VERBOSE: Selecting Random number between '1' and '$numberMax'"
    1..$numberMax | Get-Random
}


### From VS Code's Function snippet
function FunctionName {
    param (
        OptionalParameters
    )

}



# Trying the "CmdletBinding attribute" route