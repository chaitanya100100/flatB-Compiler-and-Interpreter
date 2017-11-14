declblock {
    int arr[5000005];
    int N, Q;
    int queries[5000005];
    int p, P;
    int MOD;
    int answers[5000005];
    int q, i, j, k, l, r, m;
}

codeblock {
    MOD = 100003;
    Q = 5000000;
    N = 5000000;
    P = 37;

    p = 1;
    for i = 0, N {
        p = p * P % MOD;
        if i != 0 {
            arr[i] = (arr[i - 1] + p % 100) % MOD;
        }
        else{
            arr[i] = p % 10;
        }
    }
    p = 1;
    for i = 0, Q {
        p = p * P % MOD;
        queries[i] = p;
    }


    for i = 0, Q {

        q = queries[i];
        l = 0;
        r = N - 1;
        answers[i] = -1;

        while l < r {
            m = (l + r) / 2;
            if arr[m] == q {
                answers[i] = m;
                l = 1;
                r = 0;
            }
            else {
                if arr[m] > q {
                    r = m - 1;
                }
                else {
                    l = m + 1;
                }
            }
        }
    }

}
