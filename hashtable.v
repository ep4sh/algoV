/*
* hashtable.v
 * Copyright (C) 2021 Pasha Radchenko <ep4sh2k@gmail.com>
 *
 * Distributed under terms of the MIT license.
*/

const size = 3

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
	println(idx)
	hs.arr[idx] = bucket_insert(hs.arr[idx], s)
	return idx
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

// hs_search performs search in hash table
// hs_delete performs delete of element in hash table

// bucket_search performs search in node
// bucket_delete performs delete of element in the node

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
	hs.hs_insert('pashaa')
	hs.hs_insert('pashaaa')
	hs.hs_insert('z')
	hs.hs_insert('paaa')
	hs.hs_insert('raaa')
	hs.hs_insert('raaz')
	println(hs)
}
