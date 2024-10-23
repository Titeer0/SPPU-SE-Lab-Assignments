#include <iostream>
#include<bits/stdc++.h>
using namespace std;

/*
steps - 
insert like bst left<root<right. but while inserting call balance function and return the root
in balance func, check balance factor of root, if its -2 -> left if +2->right
wapas if -2 and left side is -ve then ll if +2 and right side is +ve then rr
in balance factor we find height left-right
height func is same as bst
then we write func for rr and ll

RR = ANTI CLOCK 
LL = CLOCK
*/

class node{
    int data;
    int height;
    node* left;
    node* right;
public:
    node(int x){
        data = x;
        left = right = nullptr;
        height = 1;
    }
    node(){
        data = 0;
        left = right = nullptr;
        height = 1;
    }
    friend class avl;
};

class avl{

    public:
    int cost = 0;
    node* root;
    stack<int> s;
    avl(){
        root = NULL;
    }

    int updateHeight(node* c){
        if(c == nullptr)return 0;
        c->height = max((updateHeight(c->left))+1,(updateHeight(c->right))+1);
        return c->height;
    }

    int balanceFactor(node* c){
        if(c == nullptr) return 0;
        return (updateHeight(c->left) - updateHeight(c->right));
    }

    node* balance(node* c){
        if(balanceFactor(c)==2){
            if(balanceFactor(c->left)<0){
                c = LRrotation(c);
            }else{
                c=LLrotation(c);
            }
        }
        else if(balanceFactor(c) == -2){
            if(balanceFactor(c->right)>0){
               c = RLrotation(c);
            }else{
                c= RRrotation(c);
            }
        }
        updateHeight(c);
        return c;
    }

    node* RRrotation(node* c){
        node* newRoot = c->right;
        c->right = newRoot->left;
        newRoot->left = c;
        updateHeight(c);
        updateHeight(newRoot);
        return(newRoot);
    }

    node* LLrotation(node* c){
        node* newRoot = c->left;
        c->left = newRoot->right;
        newRoot->right = c;
        updateHeight(c);
        updateHeight(newRoot);
        return newRoot;
    }

    node* RLrotation(node* c){
        c->right = LLrotation(c->right);
        return RRrotation(c);
    }

    node* LRrotation(node* c){
        c->left = RRrotation(c->left);
        return LLrotation(c);
    }

    node* insert(node* &c,int key){
        if(c == nullptr){
            c = new node(key);
            return c;
        }
        if(key > c->data){
            c->right=insert(c->right,key);
        }else{
            c->left=insert(c->left,key);
        }

        return balance(c);
        //return c;

    }

    void inorder(node* root){
        if(root == NULL) return;
        inorder(root->left);
        cout<<root->data<<" ";
        inorder(root->right);
    }

    bool search(node* root,int key){
        if(root == nullptr) return false;
        else if(key>root->data){
            cost ++;
            search(root->right,key);
        }else if(key<root->data){
            cost ++;
            search(root->left,key);
        }
        return true;
    }

    void avl::level_traverse(node *c)
{
    if(c==NULL)
    {
        return;
    }
    node *queue[1000];
    int front=0;
    int rear=0;
    queue[rear++]=c;
    while(front!=rear)
    {
        node *new1=queue[front++];
        cout<<new1->data<<" ";
        if(new1->left!=NULL)
        {
            queue[rear++]=new1->left;
        }
        if(new1->right!=NULL)
        {
            queue[rear++]=new1->right;
        }
    }
}


};

int main()
{
    int c;
    avl t;
    int key;
    node *p=NULL;
    cout<<"MENU"<<endl;
        cout<<"1.Insert"<<endl;
        cout<<"2.Search"<<endl;
        cout<<"3.Inorder"<<endl;
        cout<<"4.Level Order Traversing"<<endl;
        cout<<"5.Exit"<<endl;
    bool exit = false;
    while(!exit)
    {
        cout<<"Enter Your Choice:";
        cin>>c;
        switch(c){
            case 1:
            int n;
            cout<<"n: ",cin>>n;
            for(int i =0;i<n;i++){
            cout<<"value: ",cin>>key;
            p = t.insert(p,key);
                }
            break;
            case 2:
            t.inorder(p);
            cout<<"\n";
            break;
            case 3:
            int x;
            cout<<"key ",cin>>x;
            if(t.search(p,key)) cout<<"found\n";
            else cout<<"no\n";
            cout<<t.cost;
            cout<<"\n";
            break;
    
            case 5:
            exit = true;
            break;
            default:
            cout<<"invalid";
        }

    }
};
