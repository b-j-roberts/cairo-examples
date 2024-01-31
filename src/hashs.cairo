use core::poseidon::PoseidonTrait;
use core::poseidon::poseidon_hash_span;
use core::pedersen::PedersenTrait;
use core::hash::{HashStateTrait, HashStateExTrait};

#[derive(Drop, Hash, Serde, Copy)]
struct StructForHash {
    first: felt252,
    second: felt252,
    third: (u32, u32),
    last: bool,
}

#[derive(Drop)]
struct StructForHashArray {
    first: felt252,
    second: felt252,
    third: Array<felt252>,
}

fn hashs() {
    let struct_to_hash = StructForHash { first: 0, second: 1, third: (1, 2), last: false };

    let hash = PoseidonTrait::new().update_with(struct_to_hash).finalize();
    println!("hash: {:?}", hash);

    let struct_to_hash = StructForHash { first: 3, second: 1, third: (1, 2), last: false };

    // hash1 is the result of hashing a struct with a base state of 0
    let hash1 = PedersenTrait::new(0).update_with(struct_to_hash).finalize();
    println!("hash1: {:?}", hash1);

    let mut serialized_struct: Array<felt252> = ArrayTrait::new();
    Serde::serialize(@struct_to_hash, ref serialized_struct);
    let first_element = serialized_struct.pop_front().unwrap();
    let mut state = PedersenTrait::new(first_element);
    loop {
        match serialized_struct.pop_front() {
            Option::Some(value) => { state = state.update(value); },
            Option::None => { break; }
        };
    };
    // hash2 is the result of hashing only the fields of the struct
    let hash2 = state.finalize();
    println!("hash2: {}", hash2);

    let struct_to_hash = StructForHashArray { first: 0, second: 1, third: array![1, 2, 3, 4, 5] };

    let mut hash = PoseidonTrait::new().update(struct_to_hash.first).update(struct_to_hash.second);
    let hash_felt252 = hash.update(poseidon_hash_span(struct_to_hash.third.span())).finalize();
    println!("hash_felt252: {:?}", hash_felt252);
}
