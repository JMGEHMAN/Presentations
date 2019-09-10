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
function Write-AdvancedHello {
    [CmdletBinding()]   #<--- This is the change we care about
    [Alias('wah')]
    [OutputType([string])]

    Param
    (
        [Parameter(ValueFromPipeline = $true)]
        [string[]]$Name = $env:USERNAME
    )
              
    Begin {
        Write-Information -MessageData "WRITE-INFORMATION: Beginning - Name = $name" -Tags 'Example', 'Begin'
    }

    Process {
        foreach ($item in $name) {
            if ($item -eq $env:USERNAME) {
                Write-Warning -Message "WRITE-WARNING: Default value used to populate '$item'." 

            } elseif ($item -eq 'PSSaturday') {
                Write-Error -Message "WRITE-ERROR: '$item' is right out!"
                break
            } 
            Write-Debug -Message "WRITE-DEBUG: Not sure if '$item' is the correct value for 'item'."
            Write-Verbose -Message "WRITE-VERBOSE: We're using '$item'"

            Write-Information -MessageData "WRITE-INFORMATION: Process - Name = $name" -Tags 'Example', 'Process'
            "Hello, $item"
        }
    }

    End {
        Write-Information -MessageData "WRITE-INFORMATION: End - Name = $name" -Tags 'Example', 'End'
    }
}

'name1', $env:USERNAME, 'PSSaturday' | Write-AdvancedHello -InformationVariable wahInfo
$wahInfo

$wahInfo | Select * | Format-Table

$wahInfo | Where-Object Tags -contains 'Example'
$wahInfo | Where-Object Tags -contains 'Begin'
$wahInfo | Where-Object Tags -contains 'Process'
$wahInfo | Where-Object Tags -contains 'End'



https://devblogs.microsoft.com/scripting/weekend-scripter-welcome-to-the-powershell-information-stream/