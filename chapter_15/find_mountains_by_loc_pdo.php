<?php

$conn = new PDO(
    'mysql:host=localhost;dbname=topography', 
    'top_app',
    'pQ3fgR5u5'
);

$location = 'Asia';

$stmt = $conn->prepare('call p_get_mountain_by_loc(:location)');
$stmt->bindParam(':location', $location, PDO::PARAM_STR);

$stmt->execute();

while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
    echo(
        $row['mountain_name'] . ' | ' . 
        $row['height'] . '<br />'
    );
}
$conn = null;
?>
