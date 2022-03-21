<?php

$conn = mysqli_connect(
          'localhost',
          'top_app',
          'pQ3fgR5u5',
          'topography'
);

$new_mountain = 'Lhotse';
$new_location = 'Asia';
$new_height = 27940;

$stmt = mysqli_prepare(
	$conn,
    'insert into mountain (mountain_name, location, height)
     values (?, ?, ?)'
);

mysqli_stmt_bind_param(
    $stmt,
    'ssi',
	$new_mountain,
	$new_location,
	$new_height
);

mysqli_stmt_execute($stmt);
mysqli_close($conn);
?>