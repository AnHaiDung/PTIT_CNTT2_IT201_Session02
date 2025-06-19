#include <stdio.h>

int main(void) {
    int arr[100];
    int len;
    int sum = 0;
    int check =0;
    printf("nhap do dai mang: ");
    scanf("%d", &len);
    for (int i = 0; i < len; i++) {
        printf("nhap phan tu thu %d: ",i);
        scanf("%d", &arr[i]);
    }
    printf("nhap so nguyen: ");
    scanf("%d", &sum);
    for (int i = 0; i < len-1; i++) {
        for (int j = i+1; j < len; j++) {
            if (arr[i] + arr[j] == sum) {
                printf("%d, %d\n", arr[i], arr[j]);
                check = 1;
            }
        }
    }
    if (check == 0) {
        printf("khong thay so can tim\n");
    }
    return 0;
}