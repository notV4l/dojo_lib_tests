#[starknet::interface]
trait IExec<T> {
    fn exec(self: @T);
}

#[dojo::contract]
mod store_complex {
    use starknet::{ContractAddress, get_caller_address};

    use dojo_starter::{
        models::complex::{Complex, ComplexFat},
        libs::store::{IStoreLibraryDispatcher, IStoreDispatcherTrait}
    };

    #[abi(embed_v0)]
    impl IExecImpl of super::IExec<ContractState> {
        fn exec(self: @ContractState) {
            let player = get_caller_address();

            let complex = self.s().complex(player);
            self.s().set_complex(complex);
        }
    }

    #[generate_trait]
    impl InternalImpl of InternalTrait {
        #[inline(always)]
        fn s(self: @ContractState,) -> IStoreLibraryDispatcher {
            let (class_hash, _) = self.world().contract('store');
            IStoreLibraryDispatcher { class_hash, }
        }
    }
}

