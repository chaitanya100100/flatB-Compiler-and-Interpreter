declblock{
    int i, a[100], n, sum1, sum2;
    int k;
}

codeblock{
    print "Enter n : ";
    read n;
    for i = 0, n
    {
        read a[i];
    }
    sum1 = 0;
    for i = 0, n
    {
        sum1 = sum1 + a[i];
    }

    sum2 = 0;
    i = 0;
    while i < n
    {
        sum2 = sum2 + a[i];
        i = i + 1;
    }
    if sum1 == sum2
    {
        print "both are working finely";
    }
    print "Sum1 is : ", sum1, "Sum2 is : ", sum2;
}
