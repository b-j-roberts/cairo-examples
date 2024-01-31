fn another_function(x: u32, label: ByteArray) {
    println!("The value of x is: {}{}", x, label);
}

fn returning_function(x: u32) -> u32 {
    x + 1
}

fn hello_world() {
    // Comment containing info
    println!("Hello, world!");
    another_function(5, "hr");

    let z = {
        let mut y = 4;
        y = returning_function(y);
        y + 1
    };
    let label: ByteArray = "min";
    another_function(x: z, :label);
}
