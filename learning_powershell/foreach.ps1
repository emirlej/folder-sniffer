# Asigning the collection first
$collection = 1, 2, "Emir"

foreach ($item in $collection) {
    Write-Output $item
}

# Directly in foreach
foreach ($item in 1, 2, 3) {
    Write-Output $item  
}
