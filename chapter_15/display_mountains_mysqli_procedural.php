<?php

$conn = mysqli_connect(
          'localhost',
          'top_app',
          'pQ3fgR5u5',
          'topography'
);

$sql = 'select mountain_name, location, height from mountain';

$result = mysqli_query($conn, $sql);

while ($row = mysqli_fetch_assoc($result)) {
  echo(
    $row['mountain_name'] . ' | ' . 
    $row['location'] . ' | ' . 
    $row['height'] . '<br />'
  );
}

mysqli_close($conn);

?>
