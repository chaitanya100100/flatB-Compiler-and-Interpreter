// program
int Traverse::visit(AST_program * program)
{
    cout << "program" << endl;
    program->decl_block->accept(*this);
    program->code_block->accept(*this);
    return 0;
}

// decl_block
int Traverse::visit(AST_decl_block * decl_block)
{
    cout << "decl_block" << endl;

    cout << "single ints : ";
    for(int i = 0; i < (int)decl_block->single_ints.size(); i++)
        cout << decl_block->single_ints[i] << ", ";
    cout << endl;

    cout << "array ints : ";
    for(int i = 0; i < (int)decl_block->array_ints.size(); i++)
        cout << decl_block->array_ints[i].first << ":" << decl_block->array_ints[i].second << ", ";
    cout << endl;
    return 0;
}

// code_block
int Traverse::visit(AST_code_block * code_block)
{
    cout << "code_block" << endl;
    code_block->block_statement->accept(*this);
    return 0;
}

//
// all statements
//
int Traverse::visit(AST_expression_statement * expression_statement)
{
    cout << "expression_statement" << endl;
    expression_statement->expression->accept(*this);
    return 0;
}

int Traverse::visit(AST_assignment_statement * assignment_statement)
{
    cout << "assignment_statement" << endl;
    assignment_statement->expression->accept(*this);
    return 0;
}

int Traverse::visit(AST_block_statement * block_statement)
{
    cout << "block_statement" << endl;
    for(int i = 0; i < (int)block_statement->statements.size(); i++)
        block_statement->statements[i]->accept(*this);
    return 0;
}

int Traverse::visit(AST_if_statement * if_statement)
{
    cout << "if_statement" << endl;
    cout << "if condition" << endl;
    if_statement->condition->accept(*this);
    cout << "if_block" << endl;
    if_statement->if_block->accept(*this);
    return 0;
}

int Traverse::visit(AST_ifelse_statement * ifelse_statement)
{
    cout << "ifelse_statement" << endl;
    cout << "if condition" << endl;
    ifelse_statement->condition->accept(*this);
    cout << "if_block" << endl;
    ifelse_statement->if_block->accept(*this);
    cout << "else_block" << endl;
    ifelse_statement->else_block->accept(*this);
    return 0;
}

int Traverse::visit(AST_for_statement * for_statement)
{
    cout << "for_statement" << endl;
    cout << "from" << endl;
    for_statement->from->accept(*this);
    cout << "step" << endl;
    for_statement->step->accept(*this);
    cout << "to" << endl;
    for_statement->to->accept(*this);
    cout << "for_block" << endl;
    for_statement->for_block->accept(*this);
    return 0;
}

int Traverse::visit(AST_while_statement * while_statement)
{
    cout << "while_statement" << endl;
    cout << "while condition" << endl;
    while_statement->condition->accept(*this);
    cout << "while_block" << endl;
    while_statement->while_block->accept(*this);
    return 0;
}

int Traverse::visit(AST_goto_statement * goto_statement)
{
    cout << "goto_statement : " << goto_statement->label << endl;
    if(goto_statement->condition) goto_statement->condition->accept(*this);
    return 0;
}

int Traverse::visit(AST_read_statement * read_statement)
{
    cout << "read_statement" << endl;
    return 0;
}

int Traverse::visit(AST_print_statement * print_statement)
{
    cout << "print_statement" << endl;
    return 0;
}

int Traverse::visit(AST_label_statement * label_statement)
{
    cout << "label_statement : " << label_statement->label << endl;
    return 0;
}


//
// all expressions
//
int Traverse::visit(AST_binary_operator_expression * binary_operator_expression)
{
    cout << "binary_operator_expression : " << binary_operator_expression->op << endl;
    cout << "left" << endl;
    binary_operator_expression->left->accept(*this);
    cout << "right" << endl;
    binary_operator_expression->right->accept(*this);
    return 0;
}

int Traverse::visit(AST_unary_operator_expression * unary_operator_expression)
{
    cout << "unary_operator_expression : " << unary_operator_expression->op << endl;
    unary_operator_expression->expression->accept(*this);
    return 0;
}


//
// variables and literals
//
int Traverse::visit(AST_variable_single_int * variable_single_int)
{
    cout << "variable_single_int : " << variable_single_int->variable_name << endl;
    return 0;
}

int Traverse::visit(AST_variable_array_int * variable_array_int)
{
    cout << "variable_array_int : " << variable_array_int->array_name << endl;
    cout << "index expression" << endl;
    variable_array_int->index->accept(*this);
    return 0;
}

int Traverse::visit(AST_int_literal * int_literal)
{
    cout << "int_literal : " << int_literal->int_literal << endl;
    return 0;
}

int Traverse::visit(AST_string_literal * string_literal)
{
    cout << "string_literal : " << string_literal->string_literal << endl;
    return 0;
}
