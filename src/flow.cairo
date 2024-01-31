fn flow() {
    // NOTE: if & loop are expressions so can return values
    let mut i: u32 = 0;
    loop {
        i += 1;
        if i == 10 {
            break;
        } else if i % 2 == 0 {
            print!("even number: ");
        } else if i == 5 {
            println!("five");
            continue;
        } else {
            print!("odd number: ");
        }
        println!("{}", i);
    };
}
