/*
* selection_sort.v
 * Copyright (C) 2021 Pasha Radchenko <ep4sh2k@gmail.com>
 *
 * Distributed under terms of the MIT license.

 Complexity: O(n^2)
*/

fn selection_sort(mut arr []int) []int {
	mut sorted := []int{}
	iterations := arr.len
	for i := 0; i < iterations; i++ {
		mut min := arr[0]
		mut imin := 0
		for index, value in arr {
			if value < min {
				min = value
				imin = index
			}
		}
		arr.delete(imin)
		sorted << min
	}
	return sorted
}

fn main() {
	mut existing_array := [3, 88, 12, 72, 251, 0, 9000200]
	desired_array := [0, 3, 12, 72, 88, 251, 9000200]

	existing_array = selection_sort(mut existing_array)
	assert existing_array == desired_array
}
