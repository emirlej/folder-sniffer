# Powershell version
The version I have been working with:
```ps
Get-Host | Select-Object Version

Version
-------
5.1.17134.228
```

# Example output of `$Event`

Changed `$Event`
```
ComputerName     : 
RunspaceId       : 0b68649b-a60b-4c7b-b6ed-fe02d5ef9b13
EventIdentifier  : 1
Sender           : System.IO.FileSystemWatcher
SourceEventArgs  : System.IO.FileSystemEventArgs
SourceArgs       : {System.IO.FileSystemWatcher, hei.txt}
SourceIdentifier : Changed_Listener
TimeGenerated    : 06.11.2018 22:07:31
MessageData      : 
```

Changed `$Event.SourceEventArgs`
```
ChangeType FullPath                                                   Name    
---------- --------                                                   ----    
   Changed C:\Users\emirl\Desktop\ps_file_sniffer_test\input\hei3.txt hei3.txt
```

Renamed `$Event.SourceEventArgs` shows info about old file:
```
OldFullPath : C:\Users\emirl\Desktop\ps_file_sniffer_test\input\emir.txt
OldName     : emir.txt
ChangeType  : Renamed
FullPath    : C:\Users\emirl\Desktop\ps_file_sniffer_test\input\emirs.txt
Name        : emirs.txt
```



# Powershell References
- [Powershell FileSystemWatcher][1]
- [Monitoring file system changes with PowerShell][2]
- [Manage Event Subscriptions with PowerShell][3] 
- [Using function inside Register-Object Action][4]


<!-- Refs -->
[1]: https://gallery.technet.microsoft.com/scriptcenter/Powershell-FileSystemWatche-dfd7084b
[2]: https://dereknewton.com/2011/05/monitoring-file-system-changes-with-powershell/
[3]: https://blogs.technet.microsoft.com/heyscriptingguy/2011/06/17/manage-event-subscriptions-with-powershell/
[4]: https://stackoverflow.com/questions/42174731/powershell-console-issue-with-function-executing-in-action-of-register-objecteve