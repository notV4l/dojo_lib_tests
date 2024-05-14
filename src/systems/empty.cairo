#[starknet::interface]
trait IExec<T> {
    fn exec(self: @T);
}

#[dojo::contract]
mod empty {
    #[abi(embed_v0)]
    impl IExecImpl of super::IExec<ContractState> {
        fn exec(self: @ContractState) {}
    }
}

