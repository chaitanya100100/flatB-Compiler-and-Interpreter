declblock{
    int a[100];
    int b, c;
}

codeblock{
    b = 0;
    c = -1;

    goto loop if c > 0;
    goto revloop;

    loop :

    b = b + c;
    print b;
    goto loop if b < 1000;
    goto end;

    revloop:

    if c == 0 {
        print "No increment or decrement";
        goto end;
    }

    c = -c;
    goto loop;

    end:
        print "end of program";

}
