$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path  = "C:\Users\emirl\Desktop\ps_file_sniffer_test\input" # CHANGE
$Global:logFile = ".\log.txt" # CHANGE

# How to use a function inside the -Action in Register-ObjectEvent
# Found solution here: https://stackoverflow.com/questions/42174731/powershell-console-issue-with-function-executing-in-action-of-register-objecteve
#TODO: The function below is not mine. Should be cleaned up and refactored
function global:RunExecNonQuery {
    param (
        $conStr, $cmdText
    )

    Write-Host "Creating SQL Connection..."
            # Instantiate new SqlConnection object.
            $Connection = New-Object System.Data.SQLClient.SQLConnection

            # Set the SqlConnection object's connection string to the passed value.
            $Connection.ConnectionString = $conStr

            # Perform database operations in try-catch-finally block since database operations often fail.
            try
            {
                Write-Host "Opening SQL Connection..."
                # Open the connection to the database.
                $Connection.Open()

                Write-Host "Creating SQL Command..."
                # Instantiate a SqlCommand object.
                $Command = New-Object System.Data.SQLClient.SQLCommand
                # Set the SqlCommand's connection to the SqlConnection object above.
                $Command.Connection = $Connection
                # Set the SqlCommand's command text to the query value passed in.
                $Command.CommandText = $cmdText
                $Command.CommandTimeout = 0

                Write-Host "Executing SQL Command..."
                # Execute the command against the database without returning results (NonQuery).
                $Command.ExecuteNonQuery()
            }
            catch [System.Data.SqlClient.SqlException]
            {
                # A SqlException occurred. According to documentation, this happens when a command is executed against a locked row.
                Write-Host "One or more of the rows being affected were locked. Please check your query and data then try again."
            }
            # General expection
            catch
            {
                # Print out the general error
                Write-Host $_.Exception.Message
                Write-Host $_.Exception.ItemName
            }
            finally {
                # Determine if the connection was opened.
                if ($Connection.State -eq "Open")
                {
                    Write-Host "Closing Connection..."
                    # Close the currently open connection.
                    $Connection.Close()
                }
        }
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
        global:RunExecNonQuery -conStr "NOT SETUP" -cmdText "NOT SETUP"

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
