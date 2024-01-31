#[derive(Drop)]
enum Direction {
    Up,
    Down,
    Left,
    Right,
}

trait DirectionPrinter {
    fn to_string(self: Direction) -> ByteArray;
}

impl DirectionPrinterImpl of DirectionPrinter {
    fn to_string(self: Direction) -> ByteArray {
        match self {
            Direction::Up => "Up",
            Direction::Down => "Down",
            Direction::Left => "Left",
            Direction::Right => "Right",
        }
    }
}

#[derive(Drop)]
enum Message {
    Quit,
    Echo: felt252,
    Move: (Direction, u32),
}

trait MessageHandler {
    fn handle(self: Message);
}

impl MessageHandlerImpl of MessageHandler {
    fn handle(self: Message) {
        match self {
            Message::Quit => println!("Quitting!"),
            Message::Echo => println!("Echo!"),
            Message::Move((
                direction, distance
            )) => { println!("Moving {} by {} pixels", direction.to_string(), distance) }
        }
    }
}

fn enums() {
    let direction = Direction::Up;
    match direction {
        Direction::Up => println!("We are heading up!"),
        Direction::Down => println!("We are heading down!"),
        Direction::Left => println!("We are heading left!"),
        Direction::Right => println!("We are heading right!"),
    }

    let message: Message = Message::Move((Direction::Down, 10));
    message.handle();
}
