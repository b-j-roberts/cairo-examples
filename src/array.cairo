fn array() {
    // NOTE: Arrays act like queues in Cairo due to immutability of memory
    //       So you can only append to the end of the array and pop from the front
    let mut arr: Array<u32> = ArrayTrait::<u32>::new();
    arr.append(1);
    arr.append(2);
    arr.append(3);

    let val = arr.pop_front().unwrap();
    println!("arr front val: {}", val);
    println!("arr at 0: {}", *arr.at(0));
    match arr.get(1) { // Get gives Option<Box<@T>>
        Option::Some(val) => println!("arr get 1: {}", *val.unbox()),
        Option::None => println!("arr get 1: None"),
    }

    println!("arr len: {}", arr.len());
    println!("arr is_empty: {}", arr.is_empty());

    let compileArr = array![1, 2, 3, 4, 5];
    println!("compileArr len: {}", compileArr.len());
}
