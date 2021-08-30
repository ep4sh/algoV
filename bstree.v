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

// Insert method inserts key into the tree
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
}
