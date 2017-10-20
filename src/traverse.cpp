void Traverse::visit(AST_program * program)
{
    program->decl_block->accept(*this);
    program->code_block->accept(*this);
    cout << "program node" << endl;
}
void Traverse::visit(AST_decl_block * decl_block)
{
    cout << "decl_block node" << endl;
}


void Traverse::visit(AST_code_block * code_block)
{
    cout << "code_block node" << endl;
}
