function add-two {
    param ($x, $y) # Optional paramters
    $result = $x + $y 
    
    # Return
    $result
}

add-two 2 4
add-two -x 3 -y 4


function print-some-stuff {
    param ($x)
    Write-Output $args[0]
    Write-Output $args[0] $x
}

print-some-stuff "Hi, world" -x 10
print-some-stuff 10 