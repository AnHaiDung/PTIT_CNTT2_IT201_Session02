#include <stdio.h>

int main() {
    int arr[100];
    int len;
    int pos;
    printf("nhap do dai mang: ");
    scanf("%d", &len);
    for (int i = 0; i < len; i++) {
        printf("nhap phan tu thu %d: ",i);
        scanf("%d", &arr[i]);
    }
    printf("nhap vi tri muon xoa: ");
    scanf("%d", &pos);
    for (int i = pos; i < len; i++) {
        arr[i] = arr[i + 1];
    }
    len = len - 1;
    for (int i = 0; i < len; i++) {
        printf("%d ", arr[i]);
    }
    return 0;
}