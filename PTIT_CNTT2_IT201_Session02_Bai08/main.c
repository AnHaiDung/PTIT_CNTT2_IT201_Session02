#include <stdio.h>

int main(void) {
    int arr[100];
    int len;
    printf("nhap do dai mang: ");
    scanf("%d", &len);
    for (int i = 0; i < len; i++) {
        printf("nhap phan tu thu %d: ",i);
        scanf("%d", &arr[i]);
    }
    for (int i = 0; i < len; i++) {
        if (arr[i] > arr[i + 1]) {
            printf("%d ", arr[i]);
        }
    }
    printf("%d\n", arr[len-1]);
    return 0;
}