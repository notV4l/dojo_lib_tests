use starknet::ContractAddress;

#[derive(Model, Copy, Drop, Serde)]
struct Simple {
    #[key]
    player: ContractAddress,
    f1: felt252,
    f2: felt252,
}


#[derive(Model, Copy, Drop, Serde)]
struct SimpleFat {
    #[key]
    player: ContractAddress,
    f1: felt252,
    f2: felt252,
    f3: felt252,
    f4: felt252,
    f5: felt252,
    f6: felt252,
    f7: felt252,
    f8: felt252,
    f9: felt252,
}

