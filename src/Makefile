bcc:	parser.tab.c lex.yy.c AST.o
	g++ -std=c++14 parser.tab.c lex.yy.c AST.o -lfl -o bcc

parser.tab.c: parser.y AST.cpp AST.h
	bison -d parser.y

parser.tab.h: parser.y AST.cpp AST.h
	bison -d parser.y

lex.yy.c: scanner.l parser.tab.h AST.cpp AST.h
	flex scanner.l

AST.o: AST.cpp AST.h traverse.cpp traverse.h evaluate.cpp evaluate.h
	g++ -std=c++14 -c AST.cpp -o AST.o


.PHONY: clean
clean:
	-@rm -rf parser.tab.c parser.tab.h lex.yy.c AST.o  traverse.o bcc 2>/dev/null || true
