
bcc:	parser.tab.c lex.yy.c AST.o
	g++ -std=c++14 parser.tab.c lex.yy.c AST.o -lfl `llvm-config --cxxflags --ldflags --system-libs --libs core` -o bcc

parser.tab.c: parser.y AST.cpp AST.h
	bison -d parser.y

parser.tab.h: parser.y AST.cpp AST.h
	bison -d parser.y

lex.yy.c: scanner.l parser.tab.h AST.cpp AST.h
	flex scanner.l

AST.o: AST.cpp AST.h traverse.cpp traverse.h evaluate.cpp evaluate.h codegen.h codegen.cpp
	g++ -std=c++14 -c AST.cpp  `llvm-config --cxxflags --ldflags --system-libs --libs core` -o AST.o


.PHONY: clean
clean:
	-@rm -rf parser.tab.c parser.tab.h lex.yy.c AST.o bcc flex_output.txt bison_output.txt ir_file bytecode_file 2>/dev/null || true
