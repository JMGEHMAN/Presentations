return 'This file is for interactive demo purposes and should not be executed as a script'


Get-Help about_functions_cmdletbindingattribute -ShowWindow

# From 'Hello' to 'AdvancedHello'
function Write-AdvancedHello {
    [CmdletBinding()]           #<--- changing the world one-liner at a time

    Param (                     #<--- CmdletBinding requires a 'Param block'
        [string[]]
        $Name = $env:USERNAME
    )
    
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


## Testing our new 'Advanced Function'
Write-AdvancedHello

Write-AdvancedHello -Verbose

Write-AdvancedHello -Debug -InformationAction 'Continue'

## Tab-completion of function
Write-Hello -

## Tab-complettion of advanced function
Write-AdvancedHello -

#>>> If you take nothing else away from this session. Use "[CmdletBinding()]". Always <<<

## Output to the different streams an now be controlled!


# Best Hello Function yet...
## Borrows from ISE's "Cmdlet (Advanced Function)" template. A better, real-world example.
function Write-AdvancedHello2 {
    [CmdletBinding()]
    [Alias('wah2')]             #<--- New: allows you to use command 'wah' instead of 'Write-AdvancedHello2'
    [OutputType([string])]      #<--- New: Declares function outputs a string

    Param (
        [Parameter(ValueFromPipeline = $true,        #<--- New: Allows "'Name' | Write-AdvancedHello2"
            ValueFromPipelineByPropertyName = $true, #<--- New: Allows "Get-Service | Write-AdvancedHello2"
            Position = 0)]
        [string[]]
        $Name = $env:USERNAME
    )

    begin {
        #<--- NEW: Begin blocks happen only once - used for setup
        $i = 1
        Write-Information -MessageData "$($PSCmdlet.MyInvocation.MyCommand): Started processing $($Name.count) names."
        Write-Verbose -Message 'Show starting - raise the curtain'
    }

    process {
        #<--- NEW: Process blocks happen for every item passed in
        Write-Verbose -Message "Welcoming $($Name.Count) names"

        foreach ($item in $Name) {
            #Only show progress bar for larger, time consuming tasks
            if ($name.count -gt 5) {
                $i += 1
                $percentComplete = [system.math]::Round($i / $Name.Count * 100, 2)
                Write-Progress -Activity 'Welcoming everyone' -Status "$i of $($Name.Count) ($($percentComplete)%)" -PercentComplete $percentComplete -CurrentOperation "Welcoming $item"

                Write-Debug -Message "Does Write-Progress work?"
            }

            #Error if fatal condition is found
            if ($item -eq 'PSSaturday2') {
                Write-Error -Message "Invalid value of 'PSSaturday2' entered for 'Name'"
                break
            }

            #Warning that default value is being used
            if ($item -eq $env:USERNAME) {
                Write-Warning -Message "Default value of '$item' is being used for 'Name'"
            }

            #Output welcome message
            "Hello, $item. Welcome to PSSaturday!"
        }
    }

    end {
        #<--- NEW: End blocks happen only once - used for clean up
        Write-Information -MessageData "$($PSCmdlet.MyInvocation.MyCommand): Completed processing $($Name.count) names."
        Write-Verbose -Message 'Show is over - clean up the popcorn'
    }
}

## Testing our new and improved function
Write-AdvancedHello2

## Having fun with "ValueFromPipeline" and "Alias"
'Test1', 'Test2', 'Test3' | wah2

## Having fun with "ValueFromPipelineByPropertyName" and "Alias"
Get-Service | wah2

## Is Write-Progress working?
wah2 -Name (Get-Service | Select-Object -ExpandProperty Name) -Debug

## Let's see what the Verbose messages look like
'Test1', 'Test2', 'Test3' | wah2 -Verbose

## This is great! Still have some questions.
## Why do Error, and Warning show automatically, but not Verbose and Information?