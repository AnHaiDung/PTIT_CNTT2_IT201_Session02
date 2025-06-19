#include <stdio.h>

int main() {
    int arr[100];
    int len;
    printf("nhap do dai mang: ");
    scanf("%d", &len);
    for (int i = 0; i < len; i++) {
        printf("nhap phan tu thu %d: ",i);
        scanf("%d", &arr[i]);
    }
    for (int i = len - 1; i >=0 ; i--) {
        printf("%d ", arr[i]);
    }
    return 0;
}