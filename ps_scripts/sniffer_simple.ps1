$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path  = "C:\Users\emirl\Desktop\ps_file_sniffer_test\input"

Register-ObjectEvent -InputObject $watcher -EventName "Created" -SourceIdentifier "Created_Listener" -Action {

    $logString  = "{1}: {2} - {0}" -f 
        $Event.SourceEventArgs.FullPath,
        $Event.SourceEventArgs.ChangeType, 
        $Event.TimeGenerated      
    
    $logString | Out-File -FilePath ".\log.txt" -Append
}