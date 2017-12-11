#!/bin/sh
if [ $# -ne 1 ]
then
echo "This script needs one argument which is the input file"
echo "Usage ./run.sh input_file"
exit 0
fi
echo "Compiling..."
make -j4 # Compile the code
echo "Producing the output LLVM IR Code"
./bcc $1 codegeneration 2> ir_file

echo "Generating Bitecode from IR"
llvm-as ir_file -o bytecode_file

echo "Interpreting Bitecode"
lli bytecode_file
