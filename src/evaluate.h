#include<map>

class Evaluate;

class Evaluate : public Visitor
{
private:
    map<string, int> ST_single_int;
    map<string, vector<int> > ST_array_int;
    string str;
    int num;

public:
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
