// In a sorted array, find the number closest to a given number

$array = [1,4,10,15,16,19,22,25,28]
$num = 13, what about 11
$i = 0;

function findClosest($num, $array, &$i) {

$len = $array.size();

// reached either end of the array
if( $i == 0 || $i == len) {
return array[$i];
}

// chceck middle
if( $num == $array[$len/2]) {
return $num;
}

// num > array[$len/2] traverse right
if($num > $array[len/2]) {
return findCosest($num, array_slice($len/2, $len), $i);
}

// num < array[$len/2] traverse left
if($num < $array[$len/2]) {
return findClosest($num, array_slice(0, $len/2), $i);
}

}


