
class Traverse;

class Traverse : public Visitor
{
public:
    void visit(AST_program * program);
    void visit(AST_decl_block * decl_block);
    void visit(AST_code_block * code_block);
};
