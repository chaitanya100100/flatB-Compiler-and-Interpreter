class CodeGen;

Value *ErrorV(const char *str);

class CodeGen : public Visitor
{
private:
    Value * ret;
    Function * main_function;
    int load_variable;
    string str_;
    map<string, BasicBlock*> goto_labels;

    static const int ERROR = 0;
    static const int PLUS = 1;
    static const int MINUS = 2;
    static const int MULTIPLY = 3;
    static const int DIVIDE = 4;
    static const int MODULO = 5;
    static const int LESS = 6;
    static const int GREATER = 7;
    static const int LESS_OR_EQUAL = 8;
    static const int GREATER_OR_EQUAL = 9;
    static const int EQUAL = 10;
    static const int NOT_EQUAL = 11;
    static const int OR = 12;
    static const int AND = 13;
    static const int UMINUS = 1;
public:
    CodeGen();
    void dump();

    int visit(AST_program * program);
    int visit(AST_decl_block * decl_block);
    int visit(AST_code_block * code_block);

    int visit(AST_expression_statement * expression_statement);
    int visit(AST_assignment_statement * assignment_statement);
    int visit(AST_block_statement * block_statement);
    int visit(AST_if_statement * if_statement);
    int visit(AST_ifelse_statement * ifelse_statement);
    int visit(AST_for_statement * for_statement);
    int visit(AST_while_statement * while_statement);
    int visit(AST_goto_statement * goto_statement);
    int visit(AST_read_statement * read_statement);
    int visit(AST_print_statement * print_statement);
    int visit(AST_label_statement * label_statement);

    int visit(AST_binary_operator_expression * binary_operator_expression);
    int visit(AST_unary_operator_expression * unary_operator_expression);

    int visit(AST_variable_single_int * variable_single_int);
    int visit(AST_variable_array_int * variable_array_int);
    int visit(AST_int_literal * int_literal);
    int visit(AST_string_literal * string_literal);
};
