use starknet::ContractAddress;
use dojo_starter::models::{complex::{Complex, ComplexFat}, simple::{Simple, SimpleFat}};

#[starknet::interface]
trait ILooper<T> {
    fn get_simple(self: @T) -> Span<SimpleFat>;
    fn get_complex(self: @T) -> Span<ComplexFat>;
}


#[dojo::contract]
mod looper {
    use starknet::ContractAddress;
    use dojo_starter::models::{complex::{Complex, ComplexFat}, simple::{Simple, SimpleFat}};

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {}

    #[abi(embed_v0)]
    impl LooperImpl of super::ILooper<ContractState> {
        fn get_simple(self: @ContractState) -> Span<SimpleFat> {
            let mut iterator: Span<felt252> = array![
                1, 2, 3, 4, 5, 6, 7, 8, 9, 10
            ]
                .span();
            let mut res: Array<SimpleFat> = array![];

            while let Option::Some(i) = iterator
                .pop_front() {
                    res.append(get!(self.world(), (*i), (SimpleFat)));
                };

            res.span()
        }

        fn get_complex(self: @ContractState) -> Span<ComplexFat> {
            let mut iterator = array![
                1, 2, 3, 4, 5, 6, 7, 8, 9, 10
            ]
                .span();
            let mut res: Array<ComplexFat> = array![];

            while let Option::Some(i) = iterator
                .pop_front() {
                    res.append(get!(self.world(), (*i), (ComplexFat)));
                };

            res.span()
        }
    }
}
