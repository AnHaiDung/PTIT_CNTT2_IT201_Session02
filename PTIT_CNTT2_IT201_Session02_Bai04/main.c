#include <stdio.h>

int main(void) {
    int arr[100];
    int len;
    int pos;
    int val;
    printf("nhap do dai mang\n");
    scanf("%d", &len);
    for (int i = 0; i < len; i++) {
        printf("nhap phan tu thu %d: ", i);
        scanf("%d", &arr[i]);
    }
    printf("nhap vi tri muon sua\n");
    scanf("%d", &pos);
    printf("nhap gia tri muon sua\n");
    scanf("%d", &val);
    arr[pos] = val;
    for (int i = 0; i < len; i++) {
        printf("%d\n", arr[i]);
    }
    return 0;
}