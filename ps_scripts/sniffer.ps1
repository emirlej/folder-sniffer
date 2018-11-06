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
#  

function Create-Log-String {
    # Function which creates the action
    
    #TODO: Need an input to the action

    #FIXME: Create a switch statement here
    # switch ($EventName) {
    #     "Changed" { 
    #         $doAction = Create-Action
    #     }
    #     Default {
    #         $doAction = Create-Action
    #     }
    # }
    #FIXME: change from args[0] = $Event
    #TODO: Need more of these parameters beøpw
    $logString  = "{1}: {2} - {0}" -f 
        $args[0].SourceEventArgs.FullPath,
        $args[0].SourceEventArgs.ChangeType, 
        $args[0].TimeGenerated
    
    # Return the object
    $logString
}

#TODO: Another name for the function?
function Setup-Register-ObjectEvent {
    #TODO: $args[0] is necessary
    #TODO: Need to explain the input parameters
    Param($EventName) 
    $sourceId = "{0}_Listener" -f $EventName
    
    # Setup ObjectEvent
    Register-ObjectEvent -InputObject $args[0] -EventName $EventName -SourceIdentifier $sourceId -Action {
        #TODO: This should be different depending on the $EventName?
        #FIXME: Change variable name from $Object
        #$logString = Create-Log-String $Event  
        $logString  = "{1}: {2} - {0}" -f 
            $Event.SourceEventArgs.FullPath,
            $Event.SourceEventArgs.ChangeType, 
            $Event.TimeGenerated     
        
        # This works
        #FIXME: How to add path to file as parameter? String is the only possibility
        $logString | Out-File -FilePath ".\log.txt" -Append
    }
}

#FIXME: Do this in a for-loop
foreach ($changeType in "Created", "Changed", "Renamed", "Deleted") {
    #Write-Output "Creating eventlistener for {0}" -f $changeType
    Setup-Register-ObjectEvent $watcher -EventName $changeType 
}

# #Exit
