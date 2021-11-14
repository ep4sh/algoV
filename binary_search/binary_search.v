/*
* binary_search.v
 * Copyright (C) 2021 Pasha Radchenko <ep4sh2k@gmail.com>
 *
 * Distributed under terms of the MIT license.
*/

fn bin_search(arr []int, dig int) bool {
	mid := arr.len / 2
	if dig == arr[mid] {
		return true
	}
	if dig < arr[mid] && mid != 0 {
		return bin_search(arr[..mid], dig)
	}
	if dig > arr[mid] && mid != 0 {
		return bin_search(arr[mid..], dig)
	}

	return false
}

fn main() {
	x0 := [3]
	x1 := [3, 7, 10, 13, 21, 25]
	x2 := [3, 7, 10, 87, 114, 227, 345, 422]
	assert bin_search(x0, 10) == false
	assert bin_search(x0, 3) == true
	assert bin_search(x1, 3) == true
	assert bin_search(x1, 10) == true

	assert bin_search(x1, 11) == false
	assert bin_search(x1, 77) == false

	assert bin_search(x2, 422) == true
	assert bin_search(x2, 345) == true
}
