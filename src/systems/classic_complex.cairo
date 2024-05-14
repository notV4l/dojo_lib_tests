#[starknet::interface]
trait IExec<T> {
    fn exec(self: @T);
}

#[dojo::contract]
mod classic_complex {
    use starknet::{ContractAddress, get_caller_address};
    use dojo_starter::models::complex::{Complex, ComplexFat};

    #[abi(embed_v0)]
    impl IExecImpl of super::IExec<ContractState> {
        fn exec(self: @ContractState) {
            let player = get_caller_address();
            let complex = get!(self.world(), player, (ComplexFat));
            set!(self.world(), (complex));
        }
    }
}

