#include<stdio.h>

int arr[1000005];
int N, Q;
int queries[1000005];
int p, P;
int MOD;
int answers[1000005];
int q, i, j, k, l, r, m;

int main()
{
    MOD = 100003;
    Q = 1000000;
    N = 1000000;
    P = 37;

    p = 1;

    for(i = 0; i < N; i++)
    {
        p = p * P % MOD;
        if(i != 0)
            arr[i] = (arr[i - 1] + p % 100) % MOD;
        else
            arr[i] = p % 10;
    }
    p = 1;
    for(i = 0; i < Q; i++)
    {
        p = p * P % MOD;
        queries[i] = p;
    }

    for(i = 0; i < Q; i++)
    {
        q = queries[i];
        l = 0;
        r = N - 1;
        answers[i] = -1;

        while(l < r)
        {
            m = (l + r) / 2;
            if (arr[m] == q)
            {
                answers[i] = m;
                l = 1;
                r = 0;
            }
            else
            {
                if (arr[m] > q)
                    r = m - 1;
                else
                    l = m + 1;
            }
        }
    }
    //for(i = 0; i < Q; i++)
    //    printf("%d\n", answers[i]);
    return 0;
}
