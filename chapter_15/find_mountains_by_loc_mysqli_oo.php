<?php

$conn = new mysqli(
          'localhost',
          'top_app',
          'pQ3fgR5u5',
          'topography'
);

$location = 'Asia';

$stmt = $conn->prepare('call p_get_mountain_by_loc(?)');
$stmt->bind_param('s', $location);
$stmt->execute();

$result = $stmt->get_result();

while ($row = $result->fetch_assoc()) {
  echo(
    $row['mountain_name'] . ' | ' . 
    $row['height'] . '<br />'
  );
}

$conn->close();
?>