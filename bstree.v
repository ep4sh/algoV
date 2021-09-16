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

fn min(t Tree) int {
	match t {
		Empty {
			return 1 << 31 - 1
		}
		BSNode {
			// replace Empty{} value by finding min in left subtree
			return if t.key < min(t.left) { t.key } else { min(t.left) }
		}
	}
}

// delete performs recursive deletion of the key in the tree
fn delete_key(t Tree, key int) Tree {
	return match t {
		Empty {
			// reached end of the tree
			t
		}
		BSNode {
			// there is two children
			if t.left is BSNode && t.right is BSNode {
				if key == t.key {
					// TODO: Get on how to run anonymous fns recursively
					// function that finds min in the subtree
					// min := fn (t Tree) int {
					//	return match t {
					//		Empty {
					//			1 << 31 - 1
					//		}
					//		BSNode {
					//			if t.key < min(t.left) { t.key } else { min(t.left) }
					//		}
					//	}
					//}
					BSNode{
						...t
						key: min(t.right)
						right: delete_key(t.right, min(t.right))
					}
				} else if key < t.key {
					BSNode{
						...t
						left: delete_key(t.left, key)
					}
				} else {
					BSNode{
						...t
						right: delete_key(t.right, key)
					}
				}
			} else if t.left is BSNode {
				// only left child, t.right is Empty
				if key == t.key {
					t.left
				} else {
					BSNode{
						...t
						left: delete_key(t.left, key) // recursive deletion
					}
				}
			} else {
				// only right child, t.left is Empty
				if key == t.key {
					t.right
				} else {
					BSNode{
						...t
						right: delete_key(t.right, key) // recursive deletion
					}
				}
			}
		}
	}
}

fn main() {
	mut tree := Tree(Empty{})
	keys := [100, 50, 150, 40, 60, 140, 180]
	for key in keys {
		tree = insert_tree(tree, key)
	}
	mut desired_tree := Tree(BSNode{
		key: 100
		left: Tree(BSNode{
			key: 50
			left: Tree(BSNode{
				key: 40
				left: Tree(Empty{})
				right: Tree(Empty{})
			})
			right: Tree(BSNode{
				key: 60
				left: Tree(Empty{})
				right: Tree(Empty{})
			})
		})
		right: Tree(BSNode{
			key: 150
			left: Tree(BSNode{
				key: 140
				left: Tree(Empty{})
				right: Tree(Empty{})
			})
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

	tree = delete_key(tree, 150)
	desired_tree = Tree(BSNode{
		key: 100
		left: Tree(BSNode{
			key: 50
			left: Tree(BSNode{
				key: 40
				left: Tree(Empty{})
				right: Tree(Empty{})
			})
			right: Tree(BSNode{
				key: 60
				left: Tree(Empty{})
				right: Tree(Empty{})
			})
		})
		right: Tree(BSNode{
			key: 180
			left: Tree(BSNode{
				key: 140
				left: Tree(Empty{})
				right: Tree(Empty{})
			})
			right: Tree(Empty{})
		})
	})
	assert tree == desired_tree
}
