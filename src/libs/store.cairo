use starknet::ContractAddress;
use dojo_starter::models::{complex::{Complex, ComplexFat}, simple::{Simple, SimpleFat}};

#[starknet::interface]
trait IStore<T> {
    fn simple(self: @T, player: ContractAddress) -> SimpleFat;
    fn complex(self: @T, player: ContractAddress) -> ComplexFat;

    fn set_simple(self: @T, simple: SimpleFat);
    fn set_complex(self: @T, complex: ComplexFat);
}


#[dojo::contract]
mod store {
    use starknet::ContractAddress;
    use dojo_starter::models::{complex::{Complex, ComplexFat}, simple::{Simple, SimpleFat}};

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {}

    #[abi(embed_v0)]
    impl StoreImpl of super::IStore<ContractState> {
        fn simple(self: @ContractState, player: ContractAddress) -> SimpleFat {
            get!(self.world(), (player), (SimpleFat))
        }

        fn complex(self: @ContractState, player: ContractAddress) -> ComplexFat {
            get!(self.world(), (player), (ComplexFat))
        }

        //
        fn set_simple(self: @ContractState, simple: SimpleFat) {
            set!(self.world(), (simple))
        }

        fn set_complex(self: @ContractState, complex: ComplexFat) {
            set!(self.world(), (complex))
        }
    }
}
