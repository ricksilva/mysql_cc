<?php

$conn = new PDO(
    'mysql:host=localhost;dbname=topography', 
    'top_app',
    'pQ3fgR5u5'
);

$new_mountain = 'K2';
$new_location = 'Asia';
$new_height = 28252;

$stmt = $conn->prepare(
    'insert into mountain (mountain_name, location, height)
     values (?, ?, ?)'
);

$stmt->bindParam(1, $new_mountain, PDO::PARAM_STR);
$stmt->bindParam(2, $new_location, PDO::PARAM_STR);
$stmt->bindParam(3, $new_height,   PDO::PARAM_INT);

$stmt->execute();

$conn = null;
?>
