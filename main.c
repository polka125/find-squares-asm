#include <stdio.h>
#include <stdlib.h>
#include <stddef.h>
#include <stdbool.h>

int min(int a, int b) {
	return (a < b) ? a : b;
}


void findsq(int n, int* arr, int* workspace);

int main() {
	int n;
	scanf("%d", &n);
	
	int* arr = (int *)malloc(n * n * sizeof(int));
	if (arr == NULL) {
		printf("Bad malloc");
		return -1;
	}

	//reading input array
	for (int i = 0; i < n * n; i++) {
		scanf("%c", arr + i);
		if (arr[i] == '\n' || arr[i] == ' ') {
			i--;
			continue;
		}
	}	

	int* workspace = (int *)malloc(n * n * sizeof(int));
	if (workspace == NULL) {
		free(arr);
		printf("Bad malloc");
		return -1;
	}


	// MAIN EFFORTS IN THIS CALL
	//  | | |
	//  v v v

	findsq(n, arr, workspace);
	

	
	printf("resulting field:\n");

	for (int i = 0; i < n * n; i++) {
		printf("%d ", workspace[i]);
		if ((i + 1) % n == 0)
			printf("\n");
	}


	printf("List of all squares:\n");

	bool square_exist = false;
	for (int i = 0; i < n; i++) {
		for (int j = 0; j < n; j++) {
			int max_side_len = workspace[j + i * n];
			for (int k = 1; k <= max_side_len; k++) {
				square_exist = true;
				printf("LeftUp corner: (%d, %d); DownRight corner: (%d, %d)\n", i, j, i + k, j + k);
			}
		}
	}

	if (!square_exist) {
		printf("There is no squares!");
	}


	free(arr);
	free(workspace);
	
	return 0;
}
