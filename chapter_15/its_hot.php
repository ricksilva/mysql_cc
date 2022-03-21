<?php

$temp = 87;

function setTemp($tmp) {
	echo "<br/>in setTemp. Setting temperature to $tmp<br/>";	
}

if ($temp > 70) { 
    echo "It's hot in here. Turning down the temperature.";
    $new_temp = $temp - 2;
    setTemp($new_temp);
} 
?>
