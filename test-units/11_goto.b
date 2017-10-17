declblock{
    int x;
    int a[20];
}

codeblock{

    start:
    read x;

    goto start if x < 1;

    for i = 1, 10
    {
        read a[i];
    }
    goto start;
}
