declblock{
    int N, arr[100005];
    int i, j, temp;
    int p, P;
}

codeblock{

    P = 31;
    p = 1;

    N = 20000;
    for i = 0, N {
        arr[i] = p;
        p = (p * P) % 123456;
    }

    for i = 0, N {
        for j = 0, N - i - 1 {
            if arr[j] > arr[j + 1] {
                temp = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = temp;
            }
        }
    }

}
