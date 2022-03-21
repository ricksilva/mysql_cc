<?php

$conn = mysqli_connect(
          'localhost',
          'top_app',
          'pQ3fgR5u5',
          'topography'
);

$location = 'Asia';

$stmt = mysqli_prepare($conn, 'call p_get_mountain_by_loc(?)');
mysqli_stmt_bind_param($stmt, 's', $location);
mysqli_stmt_execute($stmt);
$result = mysqli_stmt_get_result($stmt);

while ($row = mysqli_fetch_assoc($result)) {
  echo(
    $row['mountain_name'] . ' | ' . 
    $row['height'] . '<br />'
  );
}

mysqli_close($conn);
?>
