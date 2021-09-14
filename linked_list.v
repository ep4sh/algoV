/*
* linked_list.v
 * Copyright (C) 2021 Pasha Radchenko <ep4sh2k@gmail.com>
 *
 * Distributed under terms of the MIT license.
*/

struct Empty {}

// LLNode is struct which holds data and links
struct LLNode {
	data int
	link LinkedList
}

// LinkedList represent a linked list
type LinkedList = Empty | LLNode

// insert performs inserting of the value into the LinkedList
fn insert(ll LinkedList, val int) LinkedList {
	match ll {
		Empty {
			return LLNode{val, Empty{}}
		}
		LLNode {
			return LLNode{
				...ll
				link: insert(ll.link, val)
			}
		}
	}
}

// prepend performs inserting of the value on the top of the LinkedList
fn prepend(ll LinkedList, val int) LinkedList {
	match ll {
		Empty {
			return LLNode{val, Empty{}}
		}
		LLNode {
			return LLNode{
				data: val
				link: ll
			}
		}
	}
}

fn main() {
	mut ll := LinkedList(Empty{})
	ll = insert(ll, 997)
	ll = insert(ll, 998)
	ll = insert(ll, 999)

	mut desired_ll := LinkedList(LLNode{
		data: 997
		link: LinkedList(LLNode{
			data: 998
			link: LinkedList(LLNode{
				data: 999
				link: Empty{}
			})
		})
	})

	assert ll == desired_ll // compare two LinkedLists

	ll = prepend(ll, 123)
	desired_ll = prepend(desired_ll, 123)

	assert ll == desired_ll // compare prepended LinkedLists
	println('Desired LinkedList: \n$desired_ll')
}
