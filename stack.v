/*
* stack.v
 * Copyright (C) 2021 Pasha Radchenko <ep4sh2k@gmail.com>
 *
 * Distributed under terms of the MIT license.
*/

// Stack data structure holds stack of elements (LIFO)
struct Stack {
mut:
	items []int
}

// push add new element into the stack
fn (mut s Stack) push(i int) {
	s.items << i
}

// pop removes first element from the stack and returns it
fn (mut s Stack) pop() int {
	pop_val := s.items.pop()
	return pop_val
}

fn main() {
	mut stk := Stack{
		items: []int{cap: 3}
	}

	stk.push(10)
	stk.push(11)
	stk.push(9)
	assert stk.items == [10, 11, 9]

	stk.pop()
	assert stk.items == [10, 11]
}
