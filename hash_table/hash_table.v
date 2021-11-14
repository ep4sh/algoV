/*
* hash_table.v
 * Copyright (C) 2021 Pasha Radchenko <ep4sh2k@gmail.com>
 *
 * Distributed under terms of the MIT license.
*/

const size = 5

// HashTable is hash table struct
struct HashTable {
mut:
	arr [size]Bucket
}

// init initialize HashTable with Emptys
fn (mut hs HashTable) init() {
	for i := 0; i < size; i++ {
		hs.arr[i] = Bucket(Empty{})
	}
}

// hs_insert performs insert into hash table
fn (mut hs HashTable) hs_insert(s string) int {
	idx := hash(s)
	hs.arr[idx] = bucket_insert(hs.arr[idx], s)
	return idx
}

// hs_search performs search in hash table
fn (hs HashTable) hs_search(s string) ?string {
	idx := hash(s)
	existing_data := bucket_search(hs.arr[idx], s)
	if existing_data != '' {
		return existing_data
	}
	return error("Key with data '$s' doesn't exist in HashTable")
}

// hs_delete performs idempotent-like delete of element in hash table
fn (mut hs HashTable) hs_delete(s string) bool {
	idx := hash(s)
	hs.arr[idx] = bucket_delete(hs.arr[idx], s)
	return true
}

// Bucket is hash table node (linked list)
type Bucket = BucketNode | Empty

// Empty is empty struct for Bucket linked list
struct Empty {}

// BucketNode is struct which holds data and links for Bucket
struct BucketNode {
	data string
	link Bucket
}

// bucket_insert performs insert into the node
fn bucket_insert(b Bucket, val string) &Bucket {
	match b {
		Empty {
			return &BucketNode{val, Empty{}}
		}
		BucketNode {
			return &BucketNode{
				...b
				link: bucket_insert(b.link, val)
			}
		}
	}
}

// bucket_search performs search in node
fn bucket_search(b Bucket, val string) string {
	match b {
		Empty {
			return ''
		}
		BucketNode {
			return match b.data {
				val { b.data }
				else { bucket_search(b.link, val) }
			}
		}
	}
}

// bucket_delete performs delete of element in the node
fn bucket_delete(b Bucket, val string) Bucket {
	return match b {
		Empty {
			b
		}
		BucketNode {
			if b.data == val {
				b.link
			} else {
				BucketNode{
					...b
					link: bucket_delete(b.link, val)
				}
			}
		}
	}
}

// has returns very simple hash for particular key
fn hash(str string) int {
	mut sum := 0
	for s in str {
		sum = sum + int(s)
	}
	return sum % size
}

fn main() {
	mut hs := HashTable{}
	hs.init()
	hs.hs_insert('deadbeef')
	hs.hs_insert('coyote')
	hs.hs_insert('moo')
	hs.hs_insert('lurker')

	result_1 := hs.hs_search('coyote') or { 'NotFound' }
	result_2 := hs.hs_search('voodoo') or { 'NotFound' }
	assert result_1 == 'coyote'
	assert result_2 == 'NotFound'

	hs.hs_delete('moo')
	result_3 := hs.hs_search('moo') or { 'NotFound' }
	result_4 := hs.hs_search('lurker') or { 'NotFound' }
	assert result_3 == 'NotFound'
	assert result_4 == 'lurker'
	println(hs)
}
