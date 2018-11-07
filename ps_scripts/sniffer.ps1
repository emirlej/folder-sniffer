$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path  = "C:\Users\emirl\Desktop\ps_file_sniffer_test\input" # CHANGE
$Global:logFile = ".\log.txt" # CHANGE


function SetupRegisterObjectEvent {
    # Parameters
    Param($EventName) 
    # args[0] = FileSystemWatcher and is required

    # Unique ID of the listener. Avoids creating more than one
    $sourceId = "{0}_Listener" -f $EventName
    
    Register-ObjectEvent -InputObject $args[0] -EventName $EventName -SourceIdentifier $sourceId -Action {

        # This will be added to the log
        $logLine = $Event.TimeGenerated, 
                   $Event.SourceEventArgs.FullPath, 
                   $Event.SourceEventArgs.ChangeType            

        # Write string to log
        Add-Content $Global:logFile -Value $logLine
    }
}

# Create the listeners
foreach ($changeType in "Created", "Changed", "Renamed", "Deleted") {
    SetupRegisterObjectEvent $watcher -EventName $changeType
}

#Exit
