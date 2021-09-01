/*
* bstree.v
 * Copyright (C) 2021 Pasha Radchenko <ep4sh2k@gmail.com>
 *
 * Distributed under terms of the MIT license.
*/

// https://github.com/vlang/v/blob/master/doc/docs.md#structs-with-reference-fields
struct Empty {}

// BSNode is struct represents binary search tree node
struct BSNode {
	key   int
	left  Tree
	right Tree
}

// Tree is a sum type represents binary search tree (combines BSNode and Empty)
type Tree = BSNode | Empty

// insert performs inserts key into the tree
fn insert_tree(t Tree, key int) Tree {
	match t {
		Empty {
			return BSNode{key, t, t}
		}
		BSNode {
			match true {
				key > t.key {
					return BSNode{
						...t
						right: insert_tree(t.right, key)
					}
				}
				key < t.key {
					return BSNode{
						...t
						left: insert_tree(t.left, key)
					}
				}
				else {
					return t // if key == tree's key return itself
				}
			}
		}
	}
}

// search performs recursive search of the key in the tree
fn search_tree(t Tree, key int) bool {
	return match t {
		Empty {
			false
		}
		BSNode {
			match true {
				key > t.key {
					search_tree(t.right, key) // keep searching in right branch
				}
				key < t.key {
					search_tree(t.left, key) // keep searching in left branch
				}
				key == t.key {
					true // if key found
				}
				else {
					false // if key not found
				}
			}
		}
	}
}

fn main() {
	mut tree := Tree(Empty{})
	keys := [100, 50, 150, 60, 180]
	for key in keys {
		tree = insert_tree(tree, key)
	}
	desired_tree := Tree(BSNode{
		key: 100
		left: Tree(BSNode{
			key: 50
			left: Tree(Empty{})
			right: Tree(BSNode{
				key: 60
				left: Tree(Empty{})
				right: Tree(Empty{})
			})
		})
		right: Tree(BSNode{
			key: 150
			left: Tree(Empty{})
			right: Tree(BSNode{
				key: 180
				left: Tree(Empty{})
				right: Tree(Empty{})
			})
		})
	})
	assert tree == desired_tree

	existing_key := 60
	assert true == search_tree(desired_tree, existing_key)
}
