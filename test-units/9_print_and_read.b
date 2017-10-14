declblock{
    int i, j, k;
    int key[100];
    int val[100];
    int sum;
}

codeblock{

    read n;
    for i = 1, 100 {
        read data[i], val[i];
    }

    sum = 0;
    i = 1;

label1:
    goto label3;

label2:
    print "sum is greater than", n, " !![alsfsa9487*&%EE*(//)] ";
    goto label5;

label3:

    while i <= n {
        print "Key :", key[i], "Value :", val[i] ;
        sum = sum + val[i];
    }

label4:
    goto label2 if sum > n;

label5:
    print "Exiting...";

}
