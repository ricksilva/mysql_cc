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
     values (:mountain, :location, :height)'
);

$stmt->bindParam(':mountain', $new_mountain, PDO::PARAM_STR);
$stmt->bindParam(':location', $new_location, PDO::PARAM_STR);
$stmt->bindParam(':height', $new_height,   PDO::PARAM_INT);

$stmt->execute();

$conn = null;
?>
