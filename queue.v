// Queue data structure holds queue of elements (FILO)
struct Queue {
mut:
	items []int
}

// enque add new element into the queue
fn (mut q Queue) enque(i int) {
	q.items << i
}

// deque removes first element from the queue and returns it
fn (mut q Queue) deque() int {
	deque_val := q.items.first()
	q.items.delete(0)
	return deque_val
}

fn main() {
	mut qu := Queue{
		items: []int{cap: 3}
	}

	qu.enque(10)
	qu.enque(11)
	qu.enque(9)
	assert qu.items == [10, 11, 9]

	qu.deque()
	assert qu.items == [11, 9]
}
