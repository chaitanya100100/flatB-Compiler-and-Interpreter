#include <vector>
using namespace std;

class AST_node
{

};

class AST_decl_block;
class AST_decl_variable;
class AST_decl_single_int;
class AST_decl_int_array;

class AST_code_block;
class AST_statement;

class AST_expression;
class AST_condition;

class AST_block_statement;
class AST_if_statement;
class AST_ifelse_statement;



class AST_program : public AST_node
{
private:
    AST_decl_block * decl_block;
    AST_code_block * code_block;
};

class AST_decl_block : public AST_node
{
private:
    vector<AST_decl_variable*> decl_variables;
};

class AST_decl_variable : public AST_node
{

};

class AST_decl_single_int : public AST_decl_variable
{
private:
    int value;
};

class AST_decl_int_array : public AST_decl_variable
{
private:
    int size;
    int * arr;
};



class AST_code_block : public AST_node
{
private:
    vector<AST_statement*> statements;
};

class AST_statement : public AST_node
{

};

class AST_expression : public AST_statement
{

};

class AST_condition : public AST_node
{

};


class AST_block_statement : public AST_statement
{
private:
    vector<AST_statement*> statements;
};

class AST_if_statement : public AST_statement
{
private:
    AST_condition * condition;
    AST_block_statement * if_block;
};

class AST_ifelse_statement : public AST_statement
{
private:
    AST_condition * condition;
    AST_block_statement * if_block;
    AST_block_statement * else_block;
};
