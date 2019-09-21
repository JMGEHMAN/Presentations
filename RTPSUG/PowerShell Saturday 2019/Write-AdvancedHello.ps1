#This advanced function shows how simply adding '[CmdletBinding()]' to a script or function
#opens up a lot of new possibilities

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