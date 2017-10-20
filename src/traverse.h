
class Traverse;

class Traverse : public Visitor
{
public:
    void visit(AST_program * program);
    void visit(AST_decl_block * decl_block);
    void visit(AST_code_block * code_block);

    void visit(AST_expression_statement * expression_statement);
    void visit(AST_assignment_statement * assignment_statement);
    void visit(AST_block_statement * block_statement);
    void visit(AST_if_statement * if_statement);
    void visit(AST_ifelse_statement * ifelse_statement);
    void visit(AST_for_statement * for_statement);
    void visit(AST_while_statement * while_statement);
    void visit(AST_goto_statement * goto_statement);
    void visit(AST_read_statement * read_statement);
    void visit(AST_print_statement * print_statement);
    void visit(AST_label_statement * label_statement);

    void visit(AST_binary_operator_expression * binary_operator_expression);
    void visit(AST_unary_operator_expression * unary_operator_expression);

    void visit(AST_variable_single_int * variable_single_int);
    void visit(AST_variable_array_int * variable_array_int);
    void visit(AST_int_literal * int_literal);
    void visit(AST_string_literal * string_literal);
};
