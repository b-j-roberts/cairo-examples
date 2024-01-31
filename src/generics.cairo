fn largest_list<T, impl TDrop: Drop<T>>(l1: Array<T>, l2: Array<T>) -> Array<T> {
    if l1.len() > l2.len() {
        l1
    } else {
        l2
    }
}

fn smallest_element<T, +PartialOrd<T>, +Copy<T>, +Drop<T>>(list: @Array<T>) -> T {
    let mut smallest = *list[0];
    let mut index = 1;
    loop {
        if index >= list.len() {
            break smallest;
        }
        if *list[index] < smallest {
            smallest = *list[index];
        }
        index = index + 1;
    }
}

fn generics() {
    let l1 = array![1, 2, 3];
    let l2 = array![1, 2, 3, 4, 5];

    let l3 = largest_list(l1, l2);
    //println!("largest list: {:?}", l3);

    let l4: Array<u64> = array![11, 13, 12, 9, 14, 15];
    let smallest = smallest_element(@l4);
    println!("smallest element: {}", smallest);
}
