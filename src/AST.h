#include <vector>
#include <string>
using namespace std;

// main AST node
class AST_node;
class AST_program;

// declaration block nodes
class AST_decl_block;
class AST_decl_statement;
class AST_decl_variable;
class AST_decl_int_single;
class AST_decl_int_array;

// code block node
class AST_code_block;

// a statement node
class AST_statement;


// all statements nodes derived from AST_statement
class AST_expression_statement;
class AST_assignment_statement;
class AST_block_statement;
class AST_if_statement;
class AST_ifelse_statement;
class AST_for_statement;
class AST_while_statement;
class AST_goto_statement;
class AST_read_statement;
class AST_print_statement;
class AST_label_statement;


// expression node and derived expressions nodes
class AST_expression;
class AST_binary_operator_expression;
class AST_unary_operator_expression;

class AST_variable;
class AST_variable_single_int;
class AST_variable_array_int;
class AST_int_literal;
class AST_string_literal;



// union for TTSTYPE
union _NODE_
{
    int int_val;
    char * string_val;
    //AST_node * node;
    AST_program * program;

    AST_decl_block * decl_block;
    AST_decl_statement * decl_statement;
    AST_decl_variable * decl_variable;
    AST_decl_int_single * decl_single_int;
    AST_decl_int_array * decl_int_array;

    AST_code_block * code_block;

    AST_statement * statement;
    AST_assignment_statement * assignment_statement;
    AST_block_statement * block_statement;
    AST_if_statement * if_statement;
    AST_ifelse_statement * ifelse_statement;
    AST_for_statement * for_statement;
    AST_while_statement * while_statement;
    AST_goto_statement * goto_statement;
    AST_read_statement * read_statement;
    AST_print_statement * print_statement;
    AST_label_statement * label_statement;

    AST_expression * expression;
    AST_binary_operator_expression * binary_operator_expression;
    AST_unary_operator_expression * unary_operator_expression;

    AST_variable * variable;
    AST_variable_single_int * variable_single_int;
    AST_variable_array_int * variable_array_int;
    AST_int_literal * int_literal;
    AST_string_literal * string_literal;
};
typedef union _NODE_ YYSTYPE;
#define YYSTYPE_IS_DECLARED 1


class Visitor
{
public:
    virtual void visit(AST_program *) = 0;
    virtual void visit(AST_decl_block *) = 0;
    virtual void visit(AST_code_block *) = 0;
};



// main AST_node and AST_program
class AST_node
{
public:
    virtual void accept(Visitor &) = 0;
};

class AST_program : public AST_node
{
private:
    friend class Traverse;
    AST_decl_block * decl_block;
    AST_code_block * code_block;
public:
    AST_program(AST_decl_block * decl_block, AST_code_block * code_block);
    void accept(Visitor &);
};


// declaration block nodes
class AST_decl_block : public AST_node
{
private:
    vector<AST_decl_statement*> decl_statements;
public:
    void push_back(AST_decl_statement * decl_statement);
    void accept(Visitor &);
};

class AST_decl_statement : public AST_node
{
private:
    vector<AST_decl_variable*> decl_variables;
public:
    void push_back(AST_decl_variable * decl_variable);
    void accept(Visitor &);
};

class AST_decl_variable : public AST_node
{
public:

};

class AST_decl_int_single : public AST_decl_variable
{
private:
    string id;
public:
    AST_decl_int_single(string id);
    void accept(Visitor &);
};

class AST_decl_int_array : public AST_decl_variable
{
private:
    string id;
    int size;
public:
    AST_decl_int_array(string id, int size);
    void accept(Visitor &);
};


// code block node
class AST_code_block : public AST_node
{
private:
    AST_block_statement * block_statement;
public:
    AST_code_block(AST_block_statement * block_statement = NULL);
    void accept(Visitor &);
};



/*
======================== all statements =======================
main statement node and all other derived statements node except expression
*/

class AST_statement : public AST_node
{
};

class AST_expression_statement : public AST_statement
{
private:
    AST_expression * expression;
public:
    AST_expression_statement(AST_expression * expression);
    void accept(Visitor &);
};

class AST_assignment_statement : public AST_statement
{
private:
    AST_variable * variable;
    AST_expression * expression;
public:
    AST_assignment_statement(AST_variable * variable, AST_expression * expression);
    void accept(Visitor &);
};

class AST_block_statement : public AST_statement
{
private:
    vector<AST_statement*> statements;
public:
    void push_back(AST_statement * statement);
    void accept(Visitor &);
};

class AST_if_statement : public AST_statement
{
private:
    AST_expression * condition;
    AST_block_statement * if_block;
public:
    AST_if_statement(AST_expression * condition, AST_block_statement * if_block);
    void accept(Visitor &);
};

class AST_ifelse_statement : public AST_statement
{
private:
    AST_expression * condition;
    AST_block_statement * if_block;
    AST_block_statement * else_block;
public:
    AST_ifelse_statement(AST_expression * condition, AST_block_statement * if_block, AST_block_statement * else_block);
    void accept(Visitor &);
};


class AST_for_statement : public AST_statement
{
private:
    AST_variable * variable;
    AST_expression * from;
    AST_expression * step;
    AST_expression * to;
    AST_block_statement * for_block;
public:
    AST_for_statement(AST_variable * variable, AST_expression * from, AST_expression * step, AST_expression * to, AST_block_statement * for_block);
    AST_for_statement(AST_variable * variable, AST_expression * from, AST_expression * to, AST_block_statement * for_block);
    void accept(Visitor &);
};

class AST_while_statement : public AST_statement
{
private:
    AST_expression * condition;
    AST_block_statement * while_block;
public:
    AST_while_statement(AST_expression * condition, AST_block_statement * while_block);
    void accept(Visitor &);
};

class AST_goto_statement : public AST_statement
{
private:
    AST_expression * condition;
    string label;
public:
    AST_goto_statement(AST_expression * condition, string label);
    AST_goto_statement(string label);
    void accept(Visitor &);
};

class AST_read_statement : public AST_statement
{
private:
    vector<AST_variable*> variables;
public:
    void push_back(AST_variable * variable);
    void accept(Visitor &);
};


struct AST_printable
{
    AST_string_literal * string_literal;
    AST_expression * expression;
};
class AST_print_statement : public AST_statement
{
private:
    vector<AST_printable> printables;
public:
    void push_back(AST_string_literal * string_literal);
    void push_back(AST_expression * expression);
    void accept(Visitor &);
};


class AST_label_statement : public AST_statement
{
private:
    string label;
public:
    AST_label_statement(string label);
    void accept(Visitor &);
};


/*
==================== all expressions =======================
main expression node and all derived expressions nodes
*/
class AST_expression : public AST_node
{
public:

};

class AST_binary_operator_expression : public AST_expression
{
public:
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

private:
    AST_expression * left;
    AST_expression * right;
    int op;
public:
    AST_binary_operator_expression(AST_expression * left, AST_expression * right, string op_);
    void accept(Visitor &);
};


class AST_unary_operator_expression : public AST_expression
{
public:
    static const int ERROR = 0;
    static const int UMINUS = 1;
private:
    AST_expression * expression;
    int op;
public:
    AST_unary_operator_expression(AST_expression * expression, string op);
    void accept(Visitor &);
};



class AST_variable : public AST_expression
{
public:

};

class AST_variable_single_int : public AST_variable
{
private:
    string variable_name;
public:
    AST_variable_single_int(string variable_name);
    void accept(Visitor &);
};

class AST_variable_array_int : public AST_variable
{
private:
    string array_name;
    AST_expression* index;
public:
    AST_variable_array_int(string array_name, AST_expression * index);
    void accept(Visitor &);
};

class AST_int_literal : public AST_expression
{
private:
    int int_literal;
public:
    AST_int_literal(int int_literal);
    void accept(Visitor &);
};

class AST_string_literal : public AST_node
{
private:
    string string_literal;
public:
    AST_string_literal(string string_literal);
    void accept(Visitor &);
};


#include "traverse.h"
