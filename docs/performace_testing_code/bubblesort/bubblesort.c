#include<stdio.h>

int N, arr[100005];
int i, j, temp;
int p, P;

int main()
{
	P = 31;
	p = 1;
	N = 20000;
	
	for(i = 0; i < N; i++) 
	{
		arr[i] = p;
        	p = (p * P) % 123456;
	}

	for(i = 0; i < N; i++)
		for(j = 0; j < N - i - 1; j++)
			if(arr[j] > arr[j + 1])
			{
				temp = arr[j];
				arr[j] = arr[j + 1];
				arr[j + 1] = temp;
			}    

	return 0;
}
