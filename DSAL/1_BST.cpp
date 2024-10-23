#include <iostream>
#include <cmath>
#include <stack>
using namespace std;

class node
{
    public:
    int data;
    node *right;
    node *left;
    node(int x)
    {
        data=x;
        right=NULL;
        left=NULL;
    }
    friend class bst;
};
class bst
{
    public:
    void create(int x)
    {
        node *new1=new node(x);
        new1->data=x;
        new1->right=NULL;
        new1->left=NULL;
    }
    void input(node* &root)
    {
        int x;
        cout<<"Enter root:";
        cin>>x;
        cout<<"Enter data or enter -1 if data entry is over:"<<endl;
        while(x!=-1)
        {
            root=insert(root,x);
            cin>>x;
        }
    }
    node* insert(node* &root,int data)
    {
        if(root==NULL)
        {
            root=new node(data);
            return root;
        }
        if(root->data<data)
        {
            root->right=insert(root->right,data);
        }
        else
        {
            root->left=insert(root->left,data);
        }
        return root;
    }
    void inorder(node* &root)
    {
        // if(root==NULL)
        // {
        //     return;
        // }
        // else
        // {
        //     inorder(root->left);
        //     cout<<root->data<<" ";
        //     inorder(root->right);
        // }
        stack<node*> s;
        node* curr = root;
        while(!s.empty() || curr != NULL){
            while(curr != NULL){
                s.push(curr);
                curr = curr->left;
            }
            curr = s.top();
            cout<<curr->data<<" ";
            s.pop();
            curr = curr->right;

        }

    }
    void preorder(node* &root)
    {
        // if(root==NULL)
        // {
        //     return;
        // }
        // else
        // {
        //     cout<<root->data<<" ";
        //     preorder(root->left);
        //     preorder(root->right);
        // }
        node* curr = root;
        stack<node*> s;
        while(!s.empty() || curr!= NULL){
            while(curr!= NULL){
                s.push(curr);
                cout<<curr->data<<" ";
                curr=curr->left;
            }
            curr = s.top()->right;
            s.pop();
        }
    }
    void postorder(node* &root)
    {
        /*if(root==NULL)
        {
            return;
        }
        else
        {
            postorder(root->left);
            postorder(root->right);
            cout<<root->data<<" ";
        }*/
        if (root == NULL) 
        return; 
        
    stack<Node *> s1, s2; 
    s1.push(root); 
    Node* node; 
    while (!s1.empty()) { 
        node = s1.top(); 
        s1.pop(); 
        s2.push(node); 
        if (node->left) 
            s1.push(node->left); 
        if (node->right) 
            s1.push(node->right); 
    } 
  
    while (!s2.empty()) { 
        node = s2.top(); 
        s2.pop(); 
        cout << node->data << " "; 
    } 
    }
    
    
    int longest_path(node* &root)
    {
        if(root==NULL)
        {
            return 0;
        }
        else
        {
            return (max((longest_path(root->left)),(longest_path(root->right)))+1);
        }
        cout<<endl;
    }
    int search(node* &root,int data)
    {
        if(root!=NULL)
        {
            if(root->data==data)
            {
                cout<<"Record found"<<endl;
                return 1;
            }
            else if(root->data<data)
            {
                return search(root->right,data);
            }
            else if(root->data>data)
            {
                return search(root->left,data);
            }
        }
        else
        {
            cout<<"Record not found"<<endl;
            return 0;
        }
        return 0;
    }
    void min_value(node* &root)
    {
        node *q=root;
        while(q->left!=NULL)
        {
            q=q->left;
        }
        cout<<"Minimum value is:"<<q->data<<endl;
    }
    void max_value(node* &root)
    {
        node *q=root;
        while(q->right!=NULL)
        {
            q=q->right;
        }
        cout<<"Maximum value is:"<<q->data<<endl;
    }
    void mirror(node* &root)
    {
        if(root==NULL)
        {
            return;
        }
        else
        {
            node *p=root;
            mirror(root->left);
            mirror(root->right);
            p=root->left;
            root->left=root->right;
            root->right=p;
        }
    }
};
int main()
{
    bst b;
    int c=1;
    node *root=NULL;
    while(c>0)
    {
        cout<<"================MENU==============="<<endl;
        cout<<"1.INSERT"<<endl;
        cout<<"2.LONGEST PATH"<<endl;
        cout<<"3.MINIMUM VALUE AND MAXIMUM VALUE"<<endl;
        cout<<"4.MIRROR"<<endl;
        cout<<"5.SEARCH"<<endl;
        cout<<"Enter choice from 1 to 5:";
        cin>>c;
        if(c==1)
        {
            b.input(root);
            cout<<"Inorder Traversal"<<endl;
            b.inorder(root);
            cout<<endl;
            cout<<"Preorder Traversal"<<endl;
            b.preorder(root);
            cout<<endl;
            cout<<"Postorder Traversal"<<endl;
            b.postorder(root);
            cout<<endl;
        }
        else if(c==2)
        {
            int a=b.longest_path(root);
            cout<<"Longest path is:"<<a<<endl;
        }
        else if(c==3)
        {
            b.min_value(root);
            b.max_value(root);
        }
        else if(c==4)
        {
            b.mirror(root);
            cout<<"Inorder Traversal of mirror"<<endl;
            b.inorder(root);
            cout<<endl;
            b.mirror(root);
            cout<<"Inorder Traversal "<<endl;
            b.inorder(root);

        }
        else if(c==5)
        {
            int a;
            cout<<"Enter data to be searched:"<<endl;
            cin>>a;
            b.search(root,a);
        }
        else
        {
            cout<<"Wrong Choice"<<endl;
        }
    }
    return 0;
}
