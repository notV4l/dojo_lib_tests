use dojo_starter::models::complex::{Complex, ComplexFat};

#[starknet::interface]
trait IExec<T> {
    fn exec(self: @T);
    fn looper(self: @T) -> Span<ComplexFat>;
}

#[dojo::contract]
mod store_complex_loop_s {
    use starknet::{ContractAddress, get_caller_address};

    use dojo_starter::{
        models::complex::{Complex, ComplexFat},
        libs::looper_s::{ILooperLibraryDispatcher, ILooperDispatcherTrait},
        libs::store::{IStoreLibraryDispatcher, IStoreDispatcherTrait}
    };

    #[abi(embed_v0)]
    impl IExecImpl of super::IExec<ContractState> {
        fn exec(self: @ContractState) {
            let player = get_caller_address();

            let complex = self.s().complex(player);
            self.s().set_complex(complex);
        }


        fn looper(self: @ContractState) -> Span<ComplexFat> {
            self.l().get_complex()
        }
    }

    #[generate_trait]
    impl InternalImpl of InternalTrait {
        #[inline(always)]
        fn s(self: @ContractState,) -> IStoreLibraryDispatcher {
            let (class_hash, _) = self.world().contract('store');
            IStoreLibraryDispatcher { class_hash, }
        }

        #[inline(always)]
        fn l(self: @ContractState,) -> ILooperLibraryDispatcher {
            let (class_hash, _) = self.world().contract('looper_s');
            ILooperLibraryDispatcher { class_hash, }
        }
    }
}

