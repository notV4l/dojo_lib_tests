use dojo_starter::models::complex::{Complex, ComplexFat};

#[starknet::interface]
trait IExec<T> {
    fn exec(self: @T);
    fn looper(self: @T) -> Span<ComplexFat>;
}

#[dojo::contract]
mod store_complex_loop {
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


        fn looper(self: @ContractState) -> Span<ComplexFat> {
            let mut iterator: Span<felt252> = array![1, 2, 3, 4, 5, 6, 7, 8, 9].span();
            let mut res: Array<ComplexFat> = array![];

            while let Option::Some(i) = iterator
                .pop_front() {
                    res.append(self.s().complex((*i).try_into().unwrap()));
                };

            res.span()
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

