#include<stdio.h>

int isprime[5000005];
int N;
int primes[5000005];
int i, j, k;

int main()
{
    N = 5000000;
    for(i = 0; i < N; i++)
        isprime[i] = 1;
    k = 0;
    for(i = 2; i < N; i++)
        if(isprime[i])
        {
            for(j = 2 * i; j < N; j += i)
                isprime[j] = 0;
            primes[k] = i;
            k++;
        }
    printf("Total Number of Primes up to %d is %d\n", N, k);
    return 0;
}
