
$factor = $Args[0]

$disks = get-psdrive X

$cutoff = (Get-Date).AddDays(-$factor)

$path = $disks.name + ":\Backups\UserDatabases\"

    if ((Test-Path $path) -eq "True")  
    {  
        $count = (Get-ChildItem $path -include *.trn -Exclude *goldcopy*,*donotdelete* -recurse |   
                    ?{$_.LastWriteTime -lt $cutoff -and !$_.PSIsContainer -and $_.PSPath -notlike "*do_not_delete*"}).Count  
        if ($count -eq $null) {$count = 0}  
              
        Get-ChildItem $path -include *.trn  -Exclude *goldcopy*,*donotdelete* -recurse |  
        ?{$_.LastWriteTime -lt $cutoff -and !$_.PSIsContainer -and $_.PSPath -notlike "*do_not_delete*"} |  
        Remove-Item  
        Write-Host "There were" $count "backup files deleted from" $path  
    } 

