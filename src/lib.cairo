mod hello_world;
mod flow;
mod array;
mod dict;
mod structs;
mod enums;
mod generics;
mod hashs;

#[cfg(test)]
mod tests;

fn main() {
    hello_world::hello_world();
    flow::flow();
    array::array();
    dict::dict();
    structs::structs();
    enums::enums();
    generics::generics();
    hashs::hashs();
}
