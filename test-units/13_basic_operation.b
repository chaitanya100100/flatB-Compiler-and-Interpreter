declblock{
    int a, b, c, d;
}

codeblock{
    read a, b;
    read d;
    if d == 1
    {
        print "Summation", a + b;
    }
    if d == 2
    {
        print "Subtraction", a - b;
    }
    if d == 3
    {
        print "Multiply", a * b;
    }
    if d == 4
    {
        print "Divide", a / b;
    }
}
