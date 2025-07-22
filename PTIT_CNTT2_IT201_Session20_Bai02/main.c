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

void preorder(Node *root) {
    if(root == NULL) {
        return;
    }
    printf("%d\n", root->data);
    preorder(root->left);
    preorder(root->right);
}

void inorder(Node *root) {
    if(root == NULL) {
        return;
    }
    inorder(root->left);
    printf("%d\n", root->data);
    inorder(root->right);
}

void postorder(Node *root) {
    if(root == NULL) {
        return;
    }
    postorder(root->left);
    postorder(root->right);
    printf("%d\n", root->data);
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
    preorder(root);
    printf("\n");
    inorder(root);
    printf("\n");
    postorder(root);
    printf("\n");
    levelOrder(root);
    return 0;
}