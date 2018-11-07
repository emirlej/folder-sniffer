$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path  = "C:\Users\emirl\Desktop\ps_file_sniffer_test\input"
$Global:logFile = ".\log.txt"

# Actions
# $action_log_event = { $path = $Event.SourceEventArgs.FullPath
#                     $changeType = $Event.SourceEventArgs.ChangeType
#                     $logline = $(Get-Date), $changeType, $path
#                     Add-Content $logFile -value $logline

function SetupRegisterObjectEvent {
    Param($EventName) 
    $sourceId = "{0}_Listener_{1}" -f $EventName, $LogFilePath
    
    Register-ObjectEvent -InputObject $args[0] -EventName $EventName -SourceIdentifier $sourceId -Action {

        $logLine  = "{1}: {2} - {0}" -f 
            $Event.SourceEventArgs.FullPath,
            $Event.SourceEventArgs.ChangeType,
            $Event.TimeGenerated

        # Write string to log
        $logLine | Out-File -FilePath $Global:logFile -Append
    }
}

# Create the listeners
foreach ($changeType in "Created", "Changed", "Renamed", "Deleted") {
    #Write-Output "Creating eventlistener for {0}" -f $changeType
    SetupRegisterObjectEvent $watcher -EventName $changeType
}

#Exit
