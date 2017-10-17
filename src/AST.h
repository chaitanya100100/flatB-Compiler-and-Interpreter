#include <vector>
using namespace std;

class AST_node
{

};

class AST_decl_block;
class AST_code_block;
class AST_decl_statement;
class AST_decl_variable;
class AST_decl_single_int;
class AST_decl_int_array;

class AST_program : AST_node
{
private:
    AST_decl_block * decl_block;
    AST_code_block * code_block;
};

class AST_decl_block : AST_node
{
private:
    vector<AST_decl_statement*> decl_statements;
};

class AST_decl_statement : AST_node
{
private:
    vector<AST_decl_variable*> decl_variables;
};

class AST_decl_variable : AST_node
{

};

class AST_decl_single_int : AST_decl_variable
{
private:
    int value;
};

class AST_decl_int_array : AST_decl_variable
{
private:
    int size;
    int * arr;
};
