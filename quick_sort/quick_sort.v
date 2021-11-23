/*
* quick_sort.v
 * Copyright (C) 2021 Pasha Radchenko <ep4sh2k@gmail.com>
 *
 * Distributed under terms of the MIT license.

 Complexity: O(n lb n) || O(n^2) in worst case
*/

// quick_sort sorts array using divide and conquer approach
fn quick_sort(mut arr []int) []int {
	if arr.len < 2 {
		return arr
	}
	mut less := []int{}
	mut greater := []int{}
	mut pivot := arr[0]

	for i := 1; i < arr.len; i++ {
		match true {
			arr[i] <= pivot { less << arr[i] }
			else { greater << arr[i] }
		}
	}
	mut result := quick_sort(mut less)
	result << [pivot]
	result << quick_sort(mut greater)
	return result
	// Currently impossilbe, but nice to have: (fn) << (fn); fn is not array
	// return (quick_sort(mut less)) << (quick_sort(mut greater))
}

fn main() {
	mut existing_array := [3, 88, 12, -7, 44, 1, 55, 72, 251, 0, 9000200]
	desired_array := [-7, 0, 1, 3, 12, 44, 55, 72, 88, 251, 9000200]

	existing_array = quick_sort(mut existing_array)
	assert existing_array == desired_array
}
