<?php

$conn = new mysqli(
          'localhost',
          'top_app',
          'pQ3fgR5u5',
          'topography'
);

$new_mountain = 'Makalu';
$new_location = 'Asia';
$new_height = 27766;

$stmt = $conn->prepare(
    'insert into mountain (mountain_name, location, height)
     values (?, ?, ?)'
);

$stmt->bind_param('ssi', $new_mountain, $new_location, $new_height);

$stmt->execute();
$conn->close();
?>