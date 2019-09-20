return 'This file is for interactive demo purposes and should not be executed as a script'

# Write-Information, and the Information Stream are the relative new kid on the block
## Why was it created?
## What can it do for us?

## Finally, online redirection works
Get-Help Write-Information -Online

## Testing Information action
Write-Information -MessageData 'Test informational message'
Write-Information -MessageData 'Test informational message' -InformationAction 'Continue'
Write-Information -MessageData 'Test informational message' -InformationAction 'Stop'

## Testing tags
Write-Information -MessageData 'Test informational message' -Tags 'Default'
Write-Information -MessageData 'Test informational message' -InformationAction 'Continue' -Tags 'Continue'
Write-Information -MessageData 'Test informational message' -InformationAction 'Stop' -Tags 'Stop'

## Testing tags to variable
Write-Information -MessageData "Test informational $InformationPreference message (Default)." -Tags 'Default' -InformationVariable infoDefaultMessage
Write-Information -MessageData "Test informational $InformationPreference message (Continue)" -InformationAction 'Continue' -Tags 'Continue' -InformationVariable infoContinueMessage
Write-Information -MessageData "Test informational $InformationPreference message (Stop)" -InformationAction 'Stop' -Tags 'Stop' -InformationVariable infoStopMessage

### Messages saved to variable despite InformationAction
$infoDefaultMessage
$infoContinueMessage
$infoStopMessage

### Messages contain more than just the message
$infoDefaultMessage | Select-Object *
$infoContinueMessage | Select-Object *
$infoStopMessage | Select-Object *

## Testing tags on our advanced function
function Write-AdvancedHello3 {
    [CmdletBinding()]
    [Alias('wah3')]
    [OutputType([string])]

    Param (
        [Parameter(ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            Position = 0)]
        [string[]]
        $Name = $env:USERNAME
    )

    begin {
        $i = 1
        # Adding tags to 'Write-Information' statements
        Write-Information -MessageData "$($PSCmdlet.MyInvocation.MyCommand): Started processing $($Name.count) names." -Tags 'Example', 'Begin'
        Write-Verbose -Message 'Show starting - raise the curtain'
    }

    process {
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
            Write-Information -MessageData "Processed '$item'" -Tags 'Example', 'Process'
            "Hello, $item. Welcome to PSSaturday!"
        }
    }

    end {
        Write-Information -MessageData "$($PSCmdlet.MyInvocation.MyCommand): Completed processing $($Name.count) names." -Tags 'Example', 'End'
        Write-Verbose -Message 'Show is over - clean up the popcorn'
    }
}

#Saving informational output to a variable
Write-AdvancedHello3 -Name 'Name 1', 'Name 2', 'PSSaturday', 'PSSaturday2' -InformationVariable wah3Info

#reviewing the contents of informational output
$wah3Info

#But wait - there's more information under the surface
$wah3Info | Select-Object * | Format-Table

$wah3Info | Where-Object Tags -contains 'Example'
$wah3Info | Where-Object Tags -contains 'Begin'
$wah3Info | Where-Object Tags -contains 'Process'
$wah3Info | Where-Object Tags -contains 'End'