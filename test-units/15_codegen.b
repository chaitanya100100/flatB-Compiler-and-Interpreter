declblock{
    int a[100];
    int b, c;
}

codeblock{
    b = 2;
    c = 3;
    a[2] = b;
    a[4] = c;
    print a[2];
    print a[4];
    for b = 0, 2, 10 {
        print a[b];
    }
}
