use core::debug::PrintTrait;

#[derive(Copy, Drop)]
struct User {
    active: bool,
    username: felt252,
    email: felt252
}

impl UserPrintImpl of PrintTrait<User> {
    fn print(self: User) {
        self.username.print();
        self.email.print();
    }
}

trait UserTrait {
    fn new(username: felt252, email: felt252) -> User;
    fn msg(self: @User, msg: u64) -> u64;
}

impl UserTraitImpl of UserTrait {
    fn new(username: felt252, email: felt252) -> User {
        User { active: true, username, email, }
    }

    fn msg(self: @User, msg: u64) -> u64 {
        println!("Sent message {} to {}", msg, *self.username);
        0
    }
}

fn structs() {
    let mut user1 = User { active: false, username: 'me', email: 'me@example.com' };
    user1.active = true;
    user1.print();

    let user2 = UserTrait::new('you', 'you@example.com');
    user2.print();
    user2.msg(42);
}
