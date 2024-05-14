#[starknet::interface]
trait IExec<T> {
    fn exec(self: @T);
}

#[dojo::contract]
mod classic_simple {
    use starknet::{ContractAddress, get_caller_address};

    use dojo_starter::models::simple::{Simple, SimpleFat};

    #[abi(embed_v0)]
    impl IExecImpl of super::IExec<ContractState> {
        fn exec(self: @ContractState) {
            let player = get_caller_address();
            let simple = get!(self.world(), player, (SimpleFat));
            set!(self.world(), (simple));
        }
    }
}

