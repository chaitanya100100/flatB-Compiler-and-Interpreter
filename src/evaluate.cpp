
// program
int Evaluate::visit(AST_program * program)
{
    //cout << "program" << endl;
    program->decl_block->accept(*this);
    program->code_block->accept(*this);
    return 0;
}

// decl_block
int Evaluate::visit(AST_decl_block * decl_block)
{
    //cout << "decl_block" << endl;

    //cout << "single ints : ";
    for(int i = 0; i < (int)decl_block->single_ints.size(); i++)
        ST_single_int[decl_block->single_ints[i]] = 0;
    //cout << endl;

    //cout << "array ints : ";
    for(int i = 0; i < (int)decl_block->array_ints.size(); i++)
        ST_array_int[decl_block->array_ints[i].first] = vector<int>(decl_block->array_ints[i].second, 0);
    //cout << endl;
    //cout << ST_single_int.size() << endl;
    //cout << ST_array_int.size() << endl;
    return 0;
}


// code_block
int Evaluate::visit(AST_code_block * code_block)
{
    //cout << "code_block" << endl;
    code_block->block_statement->accept(*this);
    return 0;
}

//
// all statements
//
int Evaluate::visit(AST_expression_statement * expression_statement)
{
    //cout << "expression_statement" << endl;
    expression_statement->expression->accept(*this);
    return 0;
}

int Evaluate::visit(AST_assignment_statement * assignment_statement)
{
    //cout << "assignment_statement" << endl;
    int value = assignment_statement->expression->accept(*this);
    assignment_statement->variable->accept(*this);
    string type = assignment_statement->variable->type;

    if(type == "array")
        ST_array_int[str][num] = value;
    else
        ST_single_int[str] = value;
    return 0;
}

int Evaluate::visit(AST_block_statement * block_statement)
{
    //cout << "block_statement" << endl;
    for(int i = 0; i < (int)block_statement->statements.size(); i++)
        block_statement->statements[i]->accept(*this);
    return 0;
}

int Evaluate::visit(AST_if_statement * if_statement)
{
    //cout << "if_statement" << endl;
    //cout << "if condition" << endl;
    int value = if_statement->condition->accept(*this);
    if(value)
    {
        //cout << "if_block" << endl;
        if_statement->if_block->accept(*this);
    }
    return 0;
}

int Evaluate::visit(AST_ifelse_statement * ifelse_statement)
{
    //cout << "ifelse_statement" << endl;
    //cout << "if condition" << endl;
    int value = ifelse_statement->condition->accept(*this);
    if(value)
    {
        //cout << "if_block" << endl;
        ifelse_statement->if_block->accept(*this);
    }
    else
    {
        //cout << "else_block" << endl;
        ifelse_statement->else_block->accept(*this);
    }
    return 0;
}

int Evaluate::visit(AST_for_statement * for_statement)
{
    //cout << "for_statement" << endl;

    //cout << "from" << endl;
    int from = for_statement->from->accept(*this);

    for_statement->variable->accept(*this);
    string type = for_statement->variable->type;
    string name = str;
    int idx = num;

    if(type == "array") ST_array_int[name][idx] = from;
    else ST_single_int[name] = from;

    while(1)
    {
        for_statement->variable->accept(*this);
        string type = for_statement->variable->type;
        string name = str;
        int idx = num;
        int val;
        if(type == "array") val = ST_array_int[name][idx];
        else val = ST_single_int[name];
        //cout << name << endl;

        int to = for_statement->to->accept(*this);

        if(val >= to) break;
        for_statement->for_block->accept(*this);

        //cout << "step" << endl;
        int step = for_statement->step->accept(*this);

        for_statement->variable->accept(*this);
        type = for_statement->variable->type;
        name = str;
        idx = num;
        //cout << type << " " << name << " " << ST_single_int[name];
        if(type == "array") ST_array_int[name][idx] += step;
        else ST_single_int[name] += step;
    }

    return 0;
}

int Evaluate::visit(AST_while_statement * while_statement)
{
    //cout << "while_statement" << endl;
    while(1)
    {
        //cout << "while condition" << endl;
        int value = while_statement->condition->accept(*this);
        if(!value) break;
        //cout << "while_block" << endl;
        while_statement->while_block->accept(*this);
    }
    return 0;
}

int Evaluate::visit(AST_goto_statement * goto_statement)
{
    //cout << "goto_statement : " << goto_statement->label << endl;
    if(goto_statement->condition) goto_statement->condition->accept(*this);
    return 0;
}

int Evaluate::visit(AST_read_statement * read_statement)
{
    //cout << "read_statement" << endl;
    for(int i = 0; i < (int)read_statement->variables.size(); i++)
    {
        int x;
        cin >> x;
        read_statement->variables[i]->accept(*this);
        string type = read_statement->variables[i]->type;
        //cout << str << " " << num << endl;
        if(type == "array") ST_array_int[str][num] = x;
        else ST_single_int[str] = x;
    }
    return 0;
}

int Evaluate::visit(AST_print_statement * print_statement)
{
    //cout << "print_statement" << endl;
    for(int i = 0; i < (int)print_statement->printables.size(); i++)
    {
        if(print_statement->printables[i].expression)
        {
            //cout << "expression in print" << endl;
            int value = print_statement->printables[i].expression->accept(*this);
            cout << value << " ";
        }
        else
        {
            print_statement->printables[i].string_literal->accept(*this);
            cout << str.substr(1, str.length()-2) << " ";
        }
    }
    cout << endl;
    return 0;
}

int Evaluate::visit(AST_label_statement * label_statement)
{
    //cout << "label_statement : " << label_statement->label << endl;
    return 0;
}


//
// all expressions
//
int Evaluate::visit(AST_binary_operator_expression * binary_operator_expression)
{
    int op = binary_operator_expression->op;
    //cout << "binary_operator_expression : " << op << endl;
    //cout << "left" << endl;
    int l = binary_operator_expression->left->accept(*this);
    //cout << "right" << endl;
    int r = binary_operator_expression->right->accept(*this);

    //cout << "binary expression " << l << " " << r << " " << " op " << op << endl;
    int ans;
    if(op == 1) ans = l + r;
    else if(op == 2) ans = l - r;
    else if(op == 3) ans = l * r;
    else if(op == 4) ans = l / r;
    else if(op == 5) ans = l % r;
    else if(op == 6) ans = l < r;
    else if(op == 7) ans = l > r;
    else if(op == 8) ans = l <= r;
    else if(op == 9) ans = l >= r;
    else if(op == 10) ans = l == r;
    else if(op == 11) ans = l != r;
    else if(op == 12) ans = l || r;
    else if(op == 13) ans = l && r;
    else cout << "ERROR" << endl;

    return ans;
}

int Evaluate::visit(AST_unary_operator_expression * unary_operator_expression)
{
    int op = unary_operator_expression->op;
    //cout << "unary_operator_expression : " << op << endl;
    int v = unary_operator_expression->expression->accept(*this);

    int ans;
    if(op == 1) ans = -v;
    else cout << "ERROR" << endl;

    return ans;
}


//
// variables and literals
//
int Evaluate::visit(AST_variable_single_int * variable_single_int)
{
    //cout << "variable_single_int : " << variable_single_int->variable_name << endl;
    str = variable_single_int->variable_name;
    return ST_single_int[str];
}

int Evaluate::visit(AST_variable_array_int * variable_array_int)
{
    //cout << "variable_array_int : " << variable_array_int->array_name << endl;
    //cout << "index expression" << endl;
    num = variable_array_int->index->accept(*this);
    str = variable_array_int->array_name;
    return ST_array_int[str][num];
}

int Evaluate::visit(AST_int_literal * int_literal)
{
    //cout << "int_literal : " << int_literal->int_literal << endl;
    num = int_literal->int_literal;
    return num;
}

int Evaluate::visit(AST_string_literal * string_literal)
{
    //cout << "string_literal : " << string_literal->string_literal << endl;
    str = string_literal->string_literal;
    return 0;
}
