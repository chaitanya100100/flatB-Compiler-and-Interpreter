# flatB Compiler and Interpreter
Compiler and Interpreter for a c-like language `flatB` using `flex` scanner, `bison` parser and `llvm` code generator framework

## flatB Description
- Keywords : `int`, `codeblock`, `declblock`, `print`, `read`, `if`, `else`, `while`, `for`, `goto`
- Data Types : Inegers and Array of Integers.
  `int data, array[100];`
  `int sum;`
- Identifiers contains only alpha-numerical characters starting with an alphabet.
- All the variables have to be declared in the `declblock{....}` before being used in the `codeblock{...}`. Multiple variables can be declared in the statement and each declaration statement ends with a semi-colon. Variables can't be assigned in declblock.
- Expressions
  - C like expressions
  - Expressions can have arithmetic operators and conditional operators : Both are treated same.
  - Conditional operation returns 1 for true condition and 0 for false condition (flatB supports only integers).
  - Some Examples :
    - `a + b`
    - `a + (b + c) / (x + y) % p`
    - `(a == 0) + (b < (a + d))`
- for loop
  - `for i = a, b {}` is same as `for(i = a, i < b, i++)` in C.
  - `for i = a, x, b {}` is same as `for(i = a, i < b, i+=x)` in C.
- if-else statement
  - `if expression {}`
  - `if expression {} else {}`
- while statment
  - `while expression {}`
- conditional and unconditional goto
  - `goto label`
  - `goto label if expression`
- print/read
  - `print "blah...blah", val`       // New line at the end of each print
  - `read sum`
  - `read data[i]`

## Dependencies
- flex
- bison
- llvm

## Testing
- ![test-units](test-units/) directory has some codes written in flatB
- they were used while developing the compiler hence not all codes are syntactically/semantically correct, they may not work in interpretion and code-generation

## Compile and Run
- Compile using `make`
- Run with command `./bcc <input_file> <command>`
  - `<input_file>` is the source code written in flatB language
  - `<command>` can take one of the three arguments : `traverse`, `interpret`, `codegeneration`

### traverse
- `./bcc <input_file> traverse`
- it makes an abstract syntax tree (AST) from flatB input file and traverse through it
- it prints nodes representing terminals and non-terminals
- it does only syntactic checks, wrong syntax will raise an error
- it doesn't do semantic checks

### interpret
- `./bcc <input_file> interpret`
- it makes an abstract syntax tree (AST) from flatB input file and interpret it
- it supports all flatB features including reading from terminal in case of read statement and printing on terminal in case of print statement (`goto` is not supported because in case of interpretation, forward 'goto' doesn't make sense)
- it does syntactic checks, wrong syntax will raise an error
- it doesn't do semantic checks. if `<input_file>` has semantic errors, then output is undefined (mostly it will give segmentation fault)

### code generation
- `./bcc <input_file> codegeneration`
- it makes an abstract syntax tree (AST) from flatB input file and outputs `llvm IR` which can be either interpreted or compiled
- as of now, it supports all features except read statement (reading user input is not included in code generation)
- it does syntactic checks, wrong syntax will raise an error
- it doesn't do semantic checks. if `<input_file>` has semantic errors, then output is undefined (mostly it will give segmentation fault)
- `llvm IR` can be stored in a file which can be compiled to form interpretable `llvm bytecode`
  `./bcc <input_file> codegeneration 2> <IR_file>`
  `llvm-as <IR_file> -o <bytecode_file>`
  `lli <bytecode_file>`
 - all of the above commands can be run directly by calling ![codegen_interpret.sh](src/codegen_interpret.sh) script as
   `./codegen_interpret.sh <input_file>`



## implementation Details
### Scanner (![scanner.l](src/scanner.l))
- `flex` scanner for scanning tokens
- tokens are self explanatory in scanner file

### Parser (![parser.y](src/parser.y))
- `bison` parser
- it inheritely does some semantic checks and generates AST
- context free grammar is defined ![here](docs/grammar.txt)


### Abstract Syntax Tree (![AST.h](src/AST.h) / ![AST.cpp](src/AST.cpp))
AST class hierarchy is as follows
- AST_node
  - AST_program
  - AST_decl_block
  - AST_code_block
  - AST_statement
    - AST_expression_statement
      - AST_binary_operator_expression
      - AST_unary_operator_expression
      - AST_variable
        - AST_variable_single_int
        - AST_variable_array_int
      - AST_int_literal
    - AST_assignment_statement
    - AST_block_statement
    - AST_if_statement
    - AST_ifelse_statement
    - AST_for_statement
    - AST_while_statement
    - AST_goto_statement
    - AST_read_statement
    - AST_print_statement
    - AST_label_statement
  - AST_string_literal


### Traverser (![traverse.h](src/traverse.h) / ![traverse.cpp](src/traverse.cpp))
- implemented using `Visitor design pattern`

### Interpreter (![evaluate.h](src/evaluate.h) / ![evaluate.cpp](src/evaluate.cpp))
- implemented using `Visitor design pattern`

### Code Generator (![codegen.h](src/codegen.h) / ![codegen.cpp](src/codegen.cpp))
- implemented using `Visitor design pattern`


## Performance

### Binary Search
- Array of 5,000,000 numbers sorted
- 5,000,000 Queries

##### lli interpreter
real		0m1.201s  
user	0m1.172s  
sys		0m0.024s  

##### llc static compiler
real		0m1.181s  
user	0m1.152s  
sys		0m0.028s  

##### My interpreter
real		1m16.621s  
user	1m16.124s  
sys		0m0.472s  


### Sieve of Eranthoses
- Finding primes up to 5,000,000

##### lli interpreter
real		0m0.286s  
user	0m0.264s  
sys		0m0.020s  

##### llc static compiler
real		0m0.279s  
user	0m0.268s  
sys		0m0.008s  

##### My interpreter
real		0m7.556s  
user	0m7.488s  
sys		0m0.056s  


### Bubblesort
- bubblesort over 20,000 numbers

##### lli interpreter
real		0m0.996s  
user	0m0.992s  
sys		0m0.000s  

##### llc static compiler
real		0m0.851s  
user	0m0.848s  
sys		0m0.000s  

##### My Interpreter
real		2m10.433s  
user	2m10.364s  
sys		0m0.020s  
