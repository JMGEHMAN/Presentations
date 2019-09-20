return 'This file is for interactive demo purposes and should not be executed as a script'

# What 'Write-*' cmdlets are we talking about?
## Close, but too much 'noise'
Get-Command Write*
Get-Command -Verb Write

## Eliminate the noise - show only the core PowerShell cmdlets
Get-Command -Verb Write -Module Microsoft.PowerShell.Utility

# Putting the example commands from the slides to the test
## Verbose output does not get passed to next cmdlet in the pipeline
Find-Module -Name AA* -Verbose
Find-Module -Name AA* -Verbose | Sort-Object Name
Find-Module -Name AA* -Verbose | Sort-Object Name | Out-GridView

# Putting the example commands from the slides to the test
## Error output does not get passed to next cmdlet in the pipeline
Get-Item *, 'Fake Item'
Get-Item *, 'Fake Item' | Sort-Object Name
Get-Item *, 'Fake Item' | Sort-Object Name | Out-GridView

# Testing all the cmdlets in a single function
## Building function from a template
### ISE: CTRL + J
### VS Code: type 'function'
function Write-Hello ([string[]]$Name = $env:USERNAME) {
    foreach ($item in $Name) {
        #Streams cmdlets
        Write-Debug -Message "WRITE-DEBUG: Hello, $item. Welcome to PSSaturday."
        Write-Error -Message "WRITE-ERROR: Hello, $item. Welcome to PSSaturday."
        Write-Information -MessageData "WRITE-INFORMATION: Hello, $item. Welcome to PSSaturday."
        Write-Output "WRITE-OUTPUT: Hello, $item. Welcome to PSSaturday."
        Write-Verbose -Message "WRITE-VERBOSE: Hello, $item. Welcome to PSSaturday."
        Write-Warning -Message "WRITE-WARNING: Hello, $item. Welcome to PSSaturday."

        #Non-streams cmdlets
        Write-Progress -Activity "WRITE-Progress: Hello, $item. Welcome to PSSaturday."
        Write-Host "WRITE-HOST: Hello, $item. Welcome to PSSaturday."

        "Hello, $item. This is the actual output."
    }
}

## Testing function output with no input
Write-Hello

## Testing function output with multiple inputs
Write-Hello -Name 'RTPSUG', $env:USERNAME, 'John Doe'

## Why do ERROR and WARNING messages always display?
## Why do DEBUG, INFORMATION, and VERBOSE messages never display?
## Why do WRITE-HOST, WRITE-OUTPUT, always display and how are they different?

# Using PowerShell's documentation
Get-Help Write-Verbose -Online
Get-Help about_CommonParameters -ShowWindow