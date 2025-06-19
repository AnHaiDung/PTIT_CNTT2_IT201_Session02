#include <stdio.h>

int main(void) {
    int arr[100];
    int len;
    int pos;
    int val;
    printf("nhap do dai mang: ");
    scanf("%d", &len);
    for (int i = 0; i < len; i++) {
        printf("nhap phan tu thu %d: ",i);
        scanf("%d", &arr[i]);
    }
    printf("nhap vi tri muon them: ");
    scanf("%d", &pos);
    printf("nhap gia tri: ");
    scanf("%d", &val);
    for (int i = len; i > pos; i--) {
        arr[i] = arr[i - 1];
    }
    arr[pos] = val;
    len = len + 1;
    for (int i = 0; i < len; i++) {
        printf("%d ", arr[i]);
    }
    return 0;
}