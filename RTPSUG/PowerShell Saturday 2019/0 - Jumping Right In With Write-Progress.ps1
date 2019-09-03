#Write-Progress is great for providing status updates during long-running operations...like a presentation

$max = 73

for ($i = 1; $i -le $max; $i++) {
    $percentComplete = $i / $max * 100

    Write-Progress -Activity 'Activity' -Status "$i/$max ($($percentComplete)%)" -PercentComplete $percentComplete -CurrentOperation 'CurrentOperation'
    Start-Sleep -Seconds 1
}

#<----- TIP: Making 'PercentComplete' and nice number ----->
#   * Using "Round", or "Ceiling" to make '$percentComplete' a nice number if you are going to diplay it
#   * Completely optional, but I usually like to display current number, total number, and percentage

#Example:
#   * Current number = 13
#   * Total number = 73
$i = 13
$max = 73

#13/73*100 = 17.8082191780822, which is not a nice number
$i / $max * 100

#Using ROUND: Second number after the comma (,) sets the precision (number of decimal places)
[math]::Round($i / $max * 100, 2)

#Using CEILING: Result is rounded up to the next whole number
[math]::Ceiling($i / $max * 100)

#A nicely-formatted 'percentComplete' in action
for ($i = 1; $i -le $max; $i++) {
    $percentComplete = [math]::Round($i / $max * 100, 1)

    Write-Progress -Activity 'Activity' -Status "[$i/$max ($percentComplete %) Status" -PercentComplete $percentComplete -CurrentOperation 'CurrentOperation'
    Start-Sleep -Seconds 1
}

#<----- Using 'Write-Progress' to run a presentation ----->
#   * All files named <ChapterNumber>_<TopicNumber>_<Parent ID(optional)>_<Chapter Title>_<Topic>.ps1

$presentationFiles = Get-ChildItem -Path .\*_*.ps1 | Sort-Object
$i = 0

foreach ($file in $presentationFiles) {
    $splitFileName = $file.name -split '_'
    $i++

    ise $file.fullName

    #File is a child
    if ($splitFileName[2] -as [int]) {
        $childFiles = Get-ChildItem -Path ".\*_*_$($splitFileName[2])_*.ps1" | Sort-Object
        $childPercentComplete = [math]::Ceiling($childFiles.IndexOf(($childFiles | where name -eq $file.Name))+1 / $childFiles.Count * 100)

        $progressParams = @{
            id               = $splitFileName[0, 1] -join ''
            ParentId         = $splitFileName[2]
            Activity         = $splitFileName[3]
            CurrentOperation = $splitFileName[4]
            Status           = "$($childFiles.IndexOf(($childFiles | where name -eq $file.Name))+1)/$($childFiles.count) ($($childPercentComplete)%)"
            PercentComplete  = $childPercentComplete
        }

    } else {
        $PercentComplete = [math]::Ceiling($i / $presentationFiles.Count * 100)
        $progressParams = @{
            id               = $splitFileName[0, 1] -join ''
            Activity         = $splitFileName[2]
            CurrentOperation = $splitFileName[3]
            Status           = "$i/$($presentationFiles.count) ($($percentComplete)%)"
            PercentComplete  = $percentComplete
        }

    }

    Write-Progress @progressParams

    do {
        Start-Sleep -Seconds 2
    } until ($psise.PowerShellTabs.Files.DisplayName -notcontains $file.Name)

}

