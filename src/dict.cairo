use core::nullable::{nullable_from_box, match_nullable, FromNullableResult};

struct UserDatabase<T> {
    users_amount: u64,
    balances: Felt252Dict<T>,
}

trait UserDatabaseTrait<T> {
    fn new() -> UserDatabase<T>;
    fn add_user<+Drop<T>>(ref self: UserDatabase<T>, name: felt252, balance: T);
    fn get_balance<+Copy<T>>(ref self: UserDatabase<T>, name: felt252) -> T;
}

impl UserDatabaseImpl<T, +Felt252DictValue<T>> of UserDatabaseTrait<T> {
    // Creates a database
    fn new() -> UserDatabase<T> {
        UserDatabase { users_amount: 0, balances: Default::default() }
    }

    // Get the user's balance
    fn get_balance<+Copy<T>>(ref self: UserDatabase<T>, name: felt252) -> T {
        self.balances.get(name)
    }

    // Add a user
    fn add_user<+Drop<T>>(ref self: UserDatabase<T>, name: felt252, balance: T) {
        self.balances.insert(name, balance);
        self.users_amount += 1;
    }
}

impl UserDatabaseDestruct<T, +Drop<T>, +Felt252DictValue<T>> of Destruct<UserDatabase<T>> {
    fn destruct(self: UserDatabase<T>) nopanic {
        self.balances.squash();
    }
}

fn dict() {
    // Maps
    let mut balances: Felt252Dict<u64> = Default::default();
    balances.insert('Alex', 100);
    balances.insert('Bob', 200);
    balances.insert('Alex', 300);

    let alexBalance = balances.get('Alex');
    println!("Alex balance: {}", alexBalance);

    let mut d: Felt252Dict<Nullable<Span<felt252>>> = Default::default();

    let a = array![8, 9, 10];
    d.insert(0, nullable_from_box(BoxTrait::new(a.span())));

    let val = d.get(0);
    let span = match match_nullable(val) {
        FromNullableResult::Null => panic!("No value found"),
        FromNullableResult::NotNull(val) => val.unbox(),
    };

    assert!(*span.at(0) == 8, "Expecting 8");
    assert!(*span.at(1) == 9, "Expecting 9");
    assert!(*span.at(2) == 10, "Expecting 10");
    let mut i = 0;
    loop {
        match span.get(i) {
            Option::Some(val) => println!("span get {}: {}", i, *val.unbox()),
            Option::None => println!("span get {}: None", i)
        }

        i += 1;
        if i == span.len() {
            break;
        }
    };

    let mut db = UserDatabaseTrait::new();

    db.add_user('Alex', 100);
    db.add_user('Maria', 80);

    db.add_user('Alex', 40);
    db.add_user('Maria', 0);

    let alex_latest_balance = db.get_balance('Alex');
    let maria_latest_balance = db.get_balance('Maria');

    assert!(alex_latest_balance == 40, "Expected 40");
    assert!(maria_latest_balance == 0, "Expected 0");
    println!("Alex latest balance: {}", alex_latest_balance);
    println!("Maria latest balance: {}", maria_latest_balance);
}
