return 'This file is for interactive demo purposes and should not be executed as a script'

# What are Common Parameters and what do they give us?
## "...common parameters are also available on advanced functions that use the CmdletBinding attribute or the Parameter attribute..."
Get-Help about_CommonParameters -Online

## 'about_CommonParameters' gave us a lot of info.. but it looks like we need to look into "Advanced Functions" first
## "Advanced functions allow you to write functions that can perform operations that are similar to the operations you can perform with cmdlets."
Get-Help about_Functions_Advanced -Online
Get-Help about_Functions_Advanced -ShowWindow

# Comparing 'Functions' to 'Advanced Functions'
## ISE has templates (ctrl + j), and there's a Function template
## VS Code has templates too (called 'Snippets'), just type "fun" and select the Function snippet

### From ISE's 'Function' template
function Write-Hello ([string[]]$Name = $env:USERNAME) {
    foreach ($item in $Name) {
        Write-Warning -Message "Warning, $Name."
        Write-Debug -Message "Debug, $Name"
        Write-Verbose -Message "Verbose, $Name"
        Write-Information -MessageData "Information, $Name"

        "Hello, $Name"
    }
}

### From ISE's 'Cmdlet (advanced function)' template - equivalent VS Code snippet named "Function-advanced"
#### Gives us some extra goodies that are worth a look
function Write-AdvnancedHello {
    [CmdletBinding()]   #<--- This is the change we care about
    [Alias('wah')]
    [OutputType([string])]

    Param
    (
        [Parameter(ValueFromPipeline = $true)]
        [string[]]$Name = $env:USERNAME
    )
              
    Begin {
        Write-Information -MessageData "Beginning, $name"

    }
    Process {
        foreach ($item in $name) {
            Write-Warning -Message "Warning, $item."
            Write-Debug -Message "Debug, $item"
            Write-Verbose -Message "Verbose, $item"

            "Hello, $item"
        }
    }

    End {
        Write-Information -MessageData "Beginning, $name"
    }
}

## Comparing Help documentation
Get-Help Write-Hello -ShowWindow
Get-Help Write-AdvnancedHello -ShowWindow

## Using Common Parameters Debug and Verbose
Write-Hello -Verbose -Debug
Write-AdvnancedHello -Verbose -Debug

## We FINALLY have the Common Parameters we were looking for
Write-AdvnancedHello -Name 'Test' -Verbose
Write-AdvnancedHello -Debug

## Unrelated, but since we're here - you definately need to look into this more
### "[Parameter(ValueFromPipelineByPropertyName = $true)] let's us to this...
'Aaron', 'Abigail', 'Adam' | Write-AdvnancedHello

# If you take one thing away from this presentation:
## Put your code in functions, always use [CmdletBinding()]

#Advanced functions/[CmdletBinding[]] opens many possibilities, but lets stick with the topic at hand.

function Get-ISEFileItem([string[]]$ItemPath = ((Get-Location).Path), [switch]$Recusive) {
    Write-Verbose -Message "Start Get-ISEFileItem: $(Get-Date)."
    
    foreach ($item in $ItemPath) {
        #Let's see what Write-Debug does for us here
        Write-Debug "Processing '$($item.Name)'"
        
        #Make sure path is valid and on the filesystem (not registry or other PSProvider type)
        if (Test-Path -Path $item.FullName -and $item.PSProvider -eq 'Microsoft.PowerShell.Core\FileSystem') {
            Write-Verbose -Message "Verified $($item.Name) is reachable and a FileSystem object."

            $itemAcl = Get-Acl -Path $item.FullName

            if ($itemAcl) {
                $item | Add-Member -MemberType NoteProperty -Name Owner -Value $itemAcl.Owner

            } else {
                Write-Error -Message "Unable to retrieve owner from '$($item.FullName)'"
            }

            $item

            if ($item.Attributes -match 'Directory' -and $Recusive.IsPresent) {
                Write-Verbose -Message "Recursively processing files/folders in '$($item.Fullname)'"

                Get-ISEFileItem -ItemPath $item.FullNaem -Recusive
            }

        } else {
            Write-Warning -Message "Skipping '$($item.Name)' because PSProvider '$($item.PSProvider)' does not match 'Microsoft.PowerShell.Core\FileSystem'."
        }
    }
}


## This displays an error, which is OK. We're trying to figure out how to gain better insight into what's going on.
Get-ISEFileItem

## Unfortunately the verbose and debut statements don't seem to be doing anything
Get-ISEFileItem -ItemPath 'C:\Users' -Verbose -Debug

### From VS Code's Function snippet
function Get-VSCFileItemName {
    param (
        [string[]]$ItemPath = ((Get-Location).Path),
        [switch]$Recusive
    )

    Write-Verbose -Message "Start Get-ISEFileItem: $(Get-Date)."
    
    foreach ($item in $ItemPath) {
        #Let's see what Write-Debug does for us here
        Write-Debug "Processing '$($item.Name)'"
        
        #Make sure path is valid and on the filesystem (not registry or other PSProvider type)
        if (Test-Path -Path $item.FullName -and $item.PSProvider -eq 'Microsoft.PowerShell.Core\FileSystem') {
            Write-Verbose -Message "Verified $($item.Name) is reachable and a FileSystem object."

            $itemAcl = Get-Acl -Path $item.FullName

            if ($itemAcl) {
                $item | Add-Member -MemberType NoteProperty -Name Owner -Value $itemAcl.Owner

            } else {
                Write-Error -Message "Unable to retrieve owner from '$($item.FullName)'"
            }

            $item

            if ($item.Attributes -match 'Directory' -and $Recusive.IsPresent) {
                Write-Verbose -Message "Recursively processing files/folders in '$($item.Fullname)'"

                Get-ISEFileItem -ItemPath $item.FullNaem -Recusive
            }

        } else {
            Write-Warning -Message "Skipping '$($item.Name)' because PSProvider '$($item.PSProvider)' does not match 'Microsoft.PowerShell.Core\FileSystem'."
        }
    }
}

get-help Get-VSCFileItemName -ShowWindow
Get-help Get-ISEFileItem -ShowWindow


# Trying the "CmdletBinding attribute" route