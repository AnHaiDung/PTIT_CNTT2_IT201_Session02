#include <stdio.h>

int main() {
    int arr[100];
    int leg;
    int findNumber=0;
    int count=0;
    printf("nhap so luong phan tu: ");
    scanf("%d", &leg);
    for (int i = 0; i < leg; i++) {
        printf("nhap phan tu thu %d: ", i);
        scanf("%d", &arr[i]);
    }
    printf("nhap phan tu thu can tim: ");
    scanf("%d", &findNumber);
    for (int i = 0; i < leg; i++) {
        if (arr[i] == findNumber) {
            count++;
        }
    }
    printf("so luong xuat hien cua phan tu %d la %d\n", findNumber, count);
    return 0;
}