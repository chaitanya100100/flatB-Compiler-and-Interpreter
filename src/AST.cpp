#include <vector>
#include <string>
#include <iostream>

using namespace std;
#include "AST.h"

void SymbolTableInsert(AST_decl_variable * var)
{

}

/*
===========================================
=============== methods ====================
===========================================
*/

/*
============== main program ==================
*/
AST_program::AST_program(AST_decl_block * decl_block, AST_code_block * code_block)
{
    this->decl_block = decl_block;
    this->code_block = code_block;
}
void AST_program::accept(Visitor & v)
{
    v.visit(this);
}


/*
============== declaration block ==================
*/
void AST_decl_block::push_back(string name)
{
    single_ints.push_back(name);
}
void AST_decl_block::push_back(string name, int size)
{
    array_ints.push_back(make_pair(name, size));
}
void AST_decl_block::push_back(AST_decl_block * decl_block)
{
    single_ints.insert(single_ints.end(), (decl_block->single_ints).begin(), (decl_block->single_ints).end());
    array_ints.insert(array_ints.end(), (decl_block->array_ints).begin(), (decl_block->array_ints).end());
}
void AST_decl_block::accept(Visitor & v)
{
    v.visit(this);
}


/*
============== code block ==================
*/
//------------------------------
AST_code_block::AST_code_block(AST_block_statement * block_statement)
{
    this->block_statement = block_statement;
}
void AST_code_block::accept(Visitor & v)
{
    v.visit(this);
}


/*
============== statement ==================
*/
//------------------------------
AST_expression_statement::AST_expression_statement(AST_expression * expression)
{
    this->expression = expression;
}
void AST_expression_statement::accept(Visitor & v)
{
    v.visit(this);
}

//------------------------------
AST_assignment_statement::AST_assignment_statement(AST_variable * variable, AST_expression * expression)
{
    this->variable = variable;
    this->expression = expression;
}
void AST_assignment_statement::accept(Visitor & v)
{
    v.visit(this);
}

//------------------------------
void AST_block_statement::push_back(AST_statement * statement)
{
    statements.push_back(statement);
}
void AST_block_statement::accept(Visitor & v)
{
    v.visit(this);
}

//------------------------------
AST_if_statement::AST_if_statement(AST_expression * condition, AST_block_statement * if_block)
{
    this->condition = condition;
    this->if_block = if_block;
}
void AST_if_statement::accept(Visitor & v)
{
    v.visit(this);
}

//------------------------------
AST_ifelse_statement::AST_ifelse_statement(AST_expression * condition, AST_block_statement * if_block, AST_block_statement * else_block)
{
    this->condition = condition;
    this->if_block = if_block;
    this->else_block = else_block;
}
void AST_ifelse_statement::accept(Visitor & v)
{
    v.visit(this);
}

//------------------------------
AST_for_statement::AST_for_statement(AST_variable * variable, AST_expression * from, AST_expression * step, AST_expression * to, AST_block_statement * for_block)
{
    this->variable = variable;
    this->from = from;
    this->step = step;
    this->to = to;
    this->for_block = for_block;
}
AST_for_statement::AST_for_statement(AST_variable * variable, AST_expression * from, AST_expression * to, AST_block_statement * for_block)
{
    this->variable = variable;
    this->from = from;
    this->step = new AST_int_literal(1);
    this->to = to;
    this->for_block = for_block;
}
void AST_for_statement::accept(Visitor & v)
{
    v.visit(this);
}


//------------------------------
AST_while_statement::AST_while_statement(AST_expression * condition, AST_block_statement * while_block)
{
    this->condition = condition;
    this->while_block = while_block;
}
void AST_while_statement::accept(Visitor & v)
{
    v.visit(this);
}

//------------------------------
AST_goto_statement::AST_goto_statement(AST_expression * condition, string label)
{
    this->condition = condition;
    this->label = label;
}
AST_goto_statement::AST_goto_statement(string label)
{
    this->condition = new AST_int_literal(1);
    this->label = label;
}
void AST_goto_statement::accept(Visitor & v)
{
    v.visit(this);
}

//------------------------------
void AST_read_statement::push_back(AST_variable * variable)
{
    variables.push_back(variable);
}
void AST_read_statement::accept(Visitor & v)
{
    v.visit(this);
}

//------------------------------
void AST_print_statement::push_back(AST_string_literal * string_literal)
{
    struct AST_printable x;
    x.string_literal = string_literal;
    x.expression = NULL;
    printables.push_back(x);
}
void AST_print_statement::push_back(AST_expression * expression)
{
    struct AST_printable x;
    x.string_literal = NULL;
    x.expression = expression;
    printables.push_back(x);
}
void AST_print_statement::accept(Visitor & v)
{
    v.visit(this);
}

//------------------------------
AST_label_statement::AST_label_statement(string label)
{
    this->label = label;
}
void AST_label_statement::accept(Visitor & v)
{
    v.visit(this);
}


/*
============== expression ==================
*/

AST_binary_operator_expression::AST_binary_operator_expression(AST_expression * left, AST_expression * right, string op)
{
    this->left = left;
    this->right = right;
    if     (op == "+") this->op = PLUS;
    else if(op == "-") this->op = MINUS;
    else if(op == "/") this->op = DIVIDE;
    else if(op == "*") this->op = MULTIPLY;
    else if(op == "%") this->op = MODULO;
    else if(op == "<") this->op = LESS;
    else if(op == ">") this->op = GREATER;
    else if(op == ">=") this->op = GREATER_OR_EQUAL;
    else if(op == "<=") this->op = LESS_OR_EQUAL;
    else if(op == "==") this->op = EQUAL;
    else if(op == "!=") this->op = NOT_EQUAL;
    else if(op == "||") this->op = OR;
    else if(op == "&&") this->op = AND;
    else                this->op = ERROR;
}
void AST_binary_operator_expression::accept(Visitor & v)
{
    v.visit(this);
}

AST_unary_operator_expression::AST_unary_operator_expression(AST_expression * expression, string op)
{
    this->expression = expression;
    if(op == "-") this->op = UMINUS;
    else          this->op = ERROR;
}
void AST_unary_operator_expression::accept(Visitor & v)
{
    v.visit(this);
}



/*
============== variables and literals ==================
*/
//------------------------------
AST_variable_single_int::AST_variable_single_int(string variable_name)
{
    this->variable_name = variable_name;
}
void AST_variable_single_int::accept(Visitor & v)
{
    v.visit(this);
}

//------------------------------
AST_variable_array_int::AST_variable_array_int(string array_name, AST_expression * index)
{
    this->array_name = array_name;
    this->index = index;
}
void AST_variable_array_int::accept(Visitor & v)
{
    v.visit(this);
}

//------------------------------
AST_int_literal::AST_int_literal(int int_literal)
{
    this->int_literal = int_literal;
}
void AST_int_literal::accept(Visitor & v)
{
    v.visit(this);
}

//------------------------------
AST_string_literal::AST_string_literal(string string_literal)
{
    this->string_literal = string_literal;
}
void AST_string_literal::accept(Visitor & v)
{
    v.visit(this);
}



//------------------------------
#include "traverse.cpp"
