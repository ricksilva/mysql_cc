<?php

$conn = new PDO(
    'mysql:host=localhost;dbname=topography', 
    'top_app',
    'pQ3fgR5u5'
);

$sql = 'select mountain_name, location, height from mountain';

$stmt = $conn->query($sql);

while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
    echo(
        $row['mountain_name'] . ' | ' . 
        $row['location'] . ' | ' . 
        $row['height'] . '<br />'
    );
}

$conn = null;
?>
