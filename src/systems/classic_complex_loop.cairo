use dojo_starter::models::complex::{Complex, ComplexFat};

#[starknet::interface]
trait IExec<T> {
    fn exec(self: @T);
    fn looper(self: @T) -> Span<ComplexFat>;
}

#[dojo::contract]
mod classic_complex_loop {
    use starknet::{ContractAddress, get_caller_address};
    use dojo_starter::models::complex::{Complex, ComplexFat};

    #[abi(embed_v0)]
    impl IExecImpl of super::IExec<ContractState> {
        fn exec(self: @ContractState) {
            let player = get_caller_address();
            let complex = get!(self.world(), player, (ComplexFat));
            set!(self.world(), (complex));
        }

        fn looper(self: @ContractState) -> Span<ComplexFat> {
            let mut iterator: Span<felt252> = array![
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

