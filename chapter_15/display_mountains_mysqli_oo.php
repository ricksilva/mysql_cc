<?php

$conn = new mysqli(
          'localhost',
          'top_app',
          'pQ3fgR5u5',
          'topography'
);

$sql = 'select mountain_name, location, height from mountain';

$result = $conn->query($sql);

while ($row = $result->fetch_assoc()) {
  echo(
    $row['mountain_name'] . ' | ' . 
    $row['location'] . ' | ' . 
    $row['height'] . '<br />'
  );
}
$conn->close();
?>