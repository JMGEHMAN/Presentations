#This advanced function shows how to leverage the "Cmdlet (Advanced Function)" code snippet in ISE

[CmdletBinding()]
[Alias('wah2')]             #<--- New: allows you to use command 'wah' instead of 'Write-AdvancedHello2'
[OutputType([string])]      #<--- New: Declares function outputs a string

Param (
    [Parameter(ValueFromPipeline = $true, #<--- New: Allows "'Name' | Write-AdvancedHello2"
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