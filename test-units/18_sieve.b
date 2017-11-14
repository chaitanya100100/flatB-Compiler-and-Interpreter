declblock{
    int isprime[5000005];
    int N;
    int primes[5000005];
    int i, j, k;
}

codeblock {
    N = 5000000;
    for i = 0, N {
        isprime[i] = 1;
    }

    k = 0;
    for i = 2, N {
        if isprime[i] {
            for j = 2 * i, i, N {
                isprime[j] = 0;
            }
            primes[k] = i;
            k = k + 1;
        }
    }
    print "Total Number of Primes up to", N, "is :", k;
}
