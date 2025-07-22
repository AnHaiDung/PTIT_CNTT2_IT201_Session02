#include <stdio.h>
#include <stdlib.h>

typedef struct Node {
    int data;
    struct Node *left;
    struct Node *right;
}Node;

Node *createNode(int data) {
    Node *newNode = (Node *)malloc(sizeof(Node));
    if(newNode == NULL) {
        printf("cap phat khong thanh cong\n");
        return NULL;
    }
    newNode->data = data;
    newNode->left = NULL;
    newNode->right = NULL;
    return newNode;
}

void addNum(Node *root, int data) {
    if(root == NULL) {
        return;
    }
    Node* queue[100];
    int front = 0;
    int rear = 0;
    queue[rear++] = root;
    while(front < rear) {
        Node* temp = queue[front++];
        if(temp-> left == NULL) {
            temp->left = createNode(data);
            break;
        }else {
            queue[rear++] = temp->left;
        }
        if(temp->right == NULL) {
            temp->right = createNode(data);
            break;
        }else {
            queue[rear++] = temp->right;
        }
    }
}



void levelOrder(Node *root) {
    if(root == NULL) {
        return;
    }
    Node* queue[100];
    int front = 0;
    int rear = 0;
    queue[rear++]= root;
    while(front < rear) {
        Node* temp = queue[front++];
        printf("%d\n", temp->data);
        if(temp->left != NULL) {
            queue[rear++] = temp->left;
        }
        if(temp->right != NULL) {
            queue[rear++] = temp->right;
        }
    }
}

int main(void) {
    Node *root = createNode(1);
    root->left = createNode(2);
    root->right = createNode(3);
    root->left->left = createNode(4);
    root->left->right = createNode(5);
    int num;
    printf("nhap so muon them");
    scanf("%d", &num);
    addNum(root, num);
    levelOrder(root);
    return 0;
}