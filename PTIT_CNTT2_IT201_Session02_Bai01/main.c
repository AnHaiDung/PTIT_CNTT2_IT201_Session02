#include <stdio.h>

int main() {
    int arr[100];
    int num;
    printf("nhap so luong phan tu: ");
    scanf("%d", &num);
    for (int i = 0; i < num; i++) {
        printf("nhap phan tu thu %d: ",i);
        scanf("%d", &arr[i]);
    }
    int maxNumber = arr[0];
    for (int i = 1; i < num; i++) {
        if (arr[i] > maxNumber) {
            maxNumber = arr[i];
        }
    }
    printf("so lon nhat trong mang: %d", maxNumber);

    return 0;
}