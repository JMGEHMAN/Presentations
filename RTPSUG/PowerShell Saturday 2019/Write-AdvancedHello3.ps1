#This advanced function shows how adding tags to 'Write-Information' commands can help with collecting data, and that Write-Host does not support tagging.

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
        #Adding 'Write-Host' for a splash of color, which is the reason everyone uses it, and to demonstrate how it compares to usage of 'Write-Information'
        Write-Host -ForegroundColor ([enum]::GetValues([System.ConsoleColor]) | Get-Random) -BackgroundColor ([enum]::GetValues([System.ConsoleColor]) | Get-Random) "Write-Host: I'm as chill as a cat with a lazer pointer"

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