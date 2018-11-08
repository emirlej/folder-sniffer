$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path  = "C:\Users\emirl\Desktop\ps_file_sniffer_test\input" # CHANGE
$Global:logFile = ".\log.txt" # CHANGE

# How to use a function inside the -Action in Register-ObjectEvent
# Found solution here: https://stackoverflow.com/questions/42174731/powershell-console-issue-with-function-executing-in-action-of-register-objecteve
function global:hello_world {
    param($inputParam)
    Write-Host "Hello World $inputParam"
}

function SetupRegisterObjectEvent {
    # Parameters
    Param($EventName) 
    # args[0] = FileSystemWatcher and is required

    # Unique ID of the listener. Avoids creating more than one
    $sourceId = "{0}_Listener" -f $EventName
    $filename = ""
    
    Register-ObjectEvent -InputObject $args[0] -EventName $EventName -SourceIdentifier $sourceId -Action {

        # This will be added to the log
        $logLine = $Event.TimeGenerated, 
                   $Event.SourceEventArgs.FullPath, 
                   $Event.SourceEventArgs.ChangeType            

        # Testing usage of function inside the -Action scope
        global:hello_world -inputParam $Event.SourceEventArgs.ChangeType

        # Write string to log
        Add-Content $Global:logFile -Value $logLine
    }
    $filename
}

# Create the listeners
$changeTypes = "Created", "Changed", "Renamed", "Deleted"

foreach ($ct in $changeTypes) {
    SetupRegisterObjectEvent $watcher -EventName $ct
}
