/*
* trie.v
 * Copyright (C) 2021 Pasha Radchenko <ep4sh2k@gmail.com>
 *
 * Distributed under terms of the MIT license.
*/

// TrieNode is struct which holds children ptr and EOW
struct TrieNode {
mut:
	children    map[byte]&TrieNode
	end_of_word bool
}

// Trie represent a trie
struct Trie {
mut:
	root &TrieNode [required]
}

// new_trie is a fabric for Trie{}
fn new_trie() Trie {
	return Trie{
		root: &TrieNode{}
	}
}

// Search method performs search by word through the Trie
fn (t Trie) search(word string) ?string {
	mut current_node := t.root
	for char in word {
		if char !in current_node.children {
			return error("Word '$word' doesn't exist in Trie")
		}
		current_node = current_node.children[char]
	}
	if current_node.end_of_word == true {
		return "Word '$word' was found"
	}

	return error("Word '$word' doesn't exist in Trie")
}

// Insert method inserts word into the Trie
fn (t Trie) insert(word string) {
	mut current_node := t.root
	for char in word {
		if char !in current_node.children {
			new_node := &TrieNode{}
			current_node.children[char] = new_node
		}
		current_node = current_node.children[char]
	}
	current_node.end_of_word = true
}

fn main() {
	t := new_trie()
	t.insert('in')
	t.insert('info')
	t.insert('infinity')

	result_1 := t.search('info') or { 'NotFound' }
	result_2 := t.search('infinity') or { 'NotFound' }
	result_3 := t.search('Ishvar') or { 'NotFound' }
	result_4 := t.search('alchemist') or { 'NotFound' }

	assert result_1 == "Word 'info' was found"
	assert result_2 == "Word 'infinity' was found"
	assert result_3 == 'NotFound'
	assert result_4 == 'NotFound'
}
