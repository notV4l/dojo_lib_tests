use starknet::ContractAddress;

#[derive(Model, Copy, Drop, Serde)]
struct Complex {
    #[key]
    player: ContractAddress,
    direction: Direction,
    vec: Vec3,
}

#[derive(Model, Copy, Drop, Serde)]
struct ComplexFat {
    #[key]
    player: ContractAddress,
    direction1: Direction,
    vec1: Vec3,
    direction2: Direction,
    vec2: Vec4,
    direction3: Direction2,
    vec3: Vec5,
    direction4: Direction3,
    fat1: FatStruct,
    fat2: FatStruct,
    fat3: FatStruct,
}


#[derive(Introspect, Copy, Drop, Serde)]
struct Vec3 {
    x: u256,
    y: u256,
    z: u256,
}


#[derive(Introspect, Copy, Drop, Serde)]
struct Vec4 {
    x: u256,
    y: u256,
    z: u256,
    t: felt252,
}


#[derive(Introspect, Copy, Drop, Serde)]
struct Vec5 {
    x: u256,
    y: u256,
    z: u256,
    t: felt252,
    u: felt252,
}

#[derive(Introspect, Copy, Drop, Serde)]
struct FatStruct {
    x: u256,
    y: u256,
    z: u128,
    t: u256,
    u: u256,
    v: u128,
    a: u256,
    b: u256,
    c: u256,
    d: u256,
    vec1: Vec5,
    vec2: Vec5,
    vec3: Vec5,
    vec4: Vec5,
}


#[derive(Serde, Copy, Drop, Introspect)]
enum Direction {
    None,
    Left,
    Right,
    Up,
    Down,
}

#[derive(Serde, Copy, Drop, Introspect)]
enum Direction2 {
    None,
    Left,
    Right,
    Up,
    Down,
}

#[derive(Serde, Copy, Drop, Introspect)]
enum Direction3 {
    None,
    Left,
    Right,
    Up,
    Down,
    AAA,
    BBB,
    CCC,
    DDD,
    EEE
}


impl DirectionIntoFelt252 of Into<Direction, felt252> {
    fn into(self: Direction) -> felt252 {
        match self {
            Direction::None => 0,
            Direction::Left => 1,
            Direction::Right => 2,
            Direction::Up => 3,
            Direction::Down => 4,
        }
    }
}

impl Direction2IntoFelt252 of Into<Direction2, felt252> {
    fn into(self: Direction2) -> felt252 {
        match self {
            Direction2::None => 0,
            Direction2::Left => 1,
            Direction2::Right => 2,
            Direction2::Up => 3,
            Direction2::Down => 4,
        }
    }
}


impl Direction3IntoFelt252 of Into<Direction3, felt252> {
    fn into(self: Direction3) -> felt252 {
        match self {
            Direction3::None => 0,
            Direction3::Left => 1,
            Direction3::Right => 2,
            Direction3::Up => 3,
            Direction3::Down => 4,
            Direction3::AAA => 5,
            Direction3::BBB => 6,
            Direction3::CCC => 7,
            Direction3::DDD => 8,
            Direction3::EEE => 9,
        }
    }
}
