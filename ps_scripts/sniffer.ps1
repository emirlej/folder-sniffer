$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path  = "C:\Users\emirl\Desktop\ps_file_sniffer_test\input"
$logFile = ".\log.txt"

#Write-Output $watcher

#TODO: Git this shit!!!


# Actions
# $action_log_event = { $path = $Event.SourceEventArgs.FullPath
#                     $changeType = $Event.SourceEventArgs.ChangeType
#                     $logline = $(Get-Date), $changeType, $path
#                     Add-Content $logFile -value $logline



function SetupRegisterObjectEvent {
    #TODO: $args[0] is necessary
    #TODO: Need to explain the input parameters
    Param($EventName) 
    $sourceId = "{0}_Listener" -f $EventName
    
    # Setup ObjectEvent
    Register-ObjectEvent -InputObject $args[0] -EventName $EventName -SourceIdentifier $sourceId -Action {

        $logString  = "{1}: {2} - {0}" -f 
            $Event.SourceEventArgs.FullPath,
            $Event.SourceEventArgs.ChangeType, 
            $Event.TimeGenerated     
        #FIXME: How to add path to file as parameter? String is the only possibility
        $logString | Out-File -FilePath ".\log.txt" -Append
    }
}

#FIXME: Do this in a for-loop
foreach ($changeType in "Created", "Changed", "Renamed", "Deleted") {
    #Write-Output "Creating eventlistener for {0}" -f $changeType
    SetupRegisterObjectEvent $watcher -EventName $changeType 
}

#Exit
