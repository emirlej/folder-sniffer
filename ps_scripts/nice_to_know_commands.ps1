# Kill a Event bys its SourceIdentifier (unique)
Unregister-Event -SourceIdentifier "ProcessName"

# Kill by the id
Unregister-Event -SubscriptionId 2

# Get all events
Get-EventSubscriber

# Shows what what this alias is
Get-Alias cls
