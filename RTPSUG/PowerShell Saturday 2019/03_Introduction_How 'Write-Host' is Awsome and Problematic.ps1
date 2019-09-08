return 'This file is for interactive demo purposes and should not be executed as a script'

# Write-Host is great...
## -Foreground and -Background properties allow you to format text to the console to stand out

### Write the rainbow
for ($i = 0; $i -lt 10000; $i++) {
    $fColor = [enum]::GetValues([System.ConsoleColor]) | Get-Random
    $bColor = [enum]::GetValues([System.ConsoleColor]) | Get-Random

    #Let's display all the pretty colors!
    Write-Host -ForegroundColor $fColor -BackgroundColor $bColor -Object 'PowerShell is Awesome!'
}

### Using Write-Host to mimic Verbose, Error, and Informational output
function Get-RandomFromInput {
    $validMax = 100

    do {
        [int]$numberMax = Read-Host -Prompt "Enter a number between 1 and $validMax"
        $isValidNumber = $numberMax -ge 1 -and $numberMax -le $validMax

        if ($isValidNumber) {

            Write-Host -ForegroundColor Green "SUCCESS: Using numberMax of '$numberMax'."
        } else {
            #Mimicing a PowerShell error message
            Write-Host -ForegroundColor Red 'ERROR: Really?!'

        }
    }until($isValidNumber)

    #Mimicing a PowerShell verbose message
    Write-Host -ForegroundColor Cyan "VERBOSE: Selecting Random number between '1' and '$numberMax'"
    1..$numberMax | Get-Random
}

#### Replicating PowerShell's error message format
Get-RandomFromInput #enter 250

#### Replicating PowerShell's verbose message format
Get-RandomFromInput #enter 50


# Write-Host is not great...
## What if I want to keep my verbose/debugging statements around if case, but don't want them to always output?
### It may be easy to comment out write statements in this short exmaple, but what about more complex situations

## What if I want to log everything to a file?
### Output to console does not appear in text file
Get-RandomFromInput | Out-File -FilePath .\RandomOutput.txt

### No problem, Tee-Object was created for this... or not?
Get-RandomFromInput | Tee-Object -FilePath .\RandomOutput.txt


# How are these scenarios handled in native PowerShell commands?...
## Testing with a module that can generate a lot of verbose output
### No output by default
Update-Module

### Generating Verbose output
Update-Module -Verbose

### Generating Verbose and Debug output
Update-Module -Verbose -Debug

### Verbose output doesn't go to a file, so we're still not there yet
Update-Module -Verbose -Debug | Out-File -FilePath .\UpdateModule.txt


# It's clear the example function is missing something compared to 'Update-Module
## Output does not change with -Verbose and -Debug commands
Get-RandomFromInput
Get-RandomFromInput -Verbose -Debug

## And tab-completion and help documentation shows -Verbose and -Debug are not example function
### Help documentation for Get-RandomFromInput
Get-Help Get-RandomFromInput -ShowWindow

### What are 'Common Parameters' and why does Get-RandomFromInput not have them?
Get-Help Update-Module -ShowWindow