#include <iostream>
using namespace std;
template <typename t>
class stack
{
    t arr[50];
    int MAX=50;
    int top;
    public:
    stack()
    {
        top=-1;
    }
    void push(t data)
    {
        if(top==MAX-1)
        {
            cout<<"Stack Overflow"<<endl;
        }
        else
        {
            top++;
            arr[top]=data;
        }
    }
    void pop()
    {
        if(top==-1)
        {
            cout<<"Stack Underflow"<<endl;
        }
        else
        {
            top--;
        }
    }
    t gettop()
    {
        return arr[top];
    }
    bool empty()
    {
        if(top==-1)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
};
class node
{
    int data;
    node *right;
    node *left;
    public:
    node()
    {
        left=NULL;
        right=NULL;
    }
    node(int x)
    {
        data=x;
        right=NULL;
        left=NULL;
    }
    friend class binary_tree;
    friend int main();
};
class binary_tree
{
    node *root;
    int count; //to keep track of nodes / level?
    public:
    binary_tree()
    {
        root=NULL;
        count=0;
    }
    node *getnewnode(int data)
    {
        node *new1=new node(data);
        new1->data=data;
        new1->left=NULL;
        new1->right=NULL;
        return new1;
    }
    void insertiterative(int data)
    {
        count++;
        node *p=new node(data);
        if(root==NULL)
        {
            root=p;
            return;
        }
        bool flag=true;
        node *c=root;
        while(flag==true)
        {
            char side;
            cout<<"On which side of "<<c->data<<" you want to insert(l/r) "<<data<<endl;
            cin>>side;
            if(side=='l')
            {
                if(c->left==NULL)
                {
                    c->left=p;
                    flag=false;
                }
                else
                {
                    c=c->left;
                }
            }
            if(side=='r')
            {
                if(c->right==NULL)
                {
                    c->right=p;
                    flag=false;
                }
                else
                {
                    c=c->right;
                }
            }
        }
    }
    void insertrecursive(node *&root,int data)
    {
        node *new1=new node(data);
        if(root==NULL)
        {
            root=new1;
            return;
        }
        else
        {
            char side;
            cout<<"Enter the side on which the element is to be insert(0 for left,1 for right)"<<endl;
            cin>>side;
            if(side=='0')
            {
                insertrecursive(root->left,data);
            }
            else if(side=='1')
            {
                insertrecursive(root->right,data);
            }
        }
        
    }
    void inorderiterative()
    {
        node *p=root;
        stack<node *>s;
        bool flag=true;
        while(flag==true)
        {
            while(p!=NULL)
            {
                s.push(p);
                p=p->left;
            }
            cout<<s.gettop()->data<<" ";
            p=s.gettop()->right;
            s.pop();
            if(p==NULL&&(s.empty()==true))
            {
                flag=false;
            }
        }

    }
    void inorderrecursive(node* &root)
    {
        if(root==NULL)
        {
            return;
        }
        else
        {
            inorderrecursive(root->left);
            cout<<root->data<<" ";
            inorderrecursive(root->right);
        }
    }
    void preorderiterative()
    {
        node *p=root;
        stack<node *>s;
        bool flag=true;
        while(flag==true)
        {
            while(p!=NULL)
            {
                cout<<p->data<<" ";
                s.push(p);
                p=p->left;
            }
            p=s.gettop()->right;
            s.pop();
            if(p==NULL&&(s.empty()==true))
            {
                flag=false;
            }
        }

    }
    void preorderrecursive(node* &root)
    {
        if(root==NULL)
        {
            return;
        }
        else
        {
            cout<<root->data<<" ";
            preorderrecursive(root->left);
            preorderrecursive(root->right);
        }
        
    }
    void postorderiterative()
    {
        node *p=root;
        stack<node *>s1;
        stack<node *>s2;
        s1.push(p); 
        while(s1.empty()!=true)
        {
            node *temp=s1.gettop();
            s1.pop();
            s2.push(temp);
            if(temp->left!=NULL)
            {
                s1.push(temp->left);
            }
            if(temp->right!=NULL)
            {
                s1.push(temp->right);
            }
        }
        while(s2.empty()!=true)
        {
            cout<<s2.gettop()->data<<" ";
            s2.pop();   
        }
    }
    void postorderrecursive(node* &root)
    {
        if(root==NULL)
        {
            return;
        }
        else
        {
            postorderrecursive(root->left);
            postorderrecursive(root->right);
            cout<<root->data<<" ";

        }
    }
    int height(node *root)
    {
        if(root==NULL)
        {
            return 0;
        }
        else
        {
            int lchild=height(root->left);
            int rchild=height(root->right);
            if(lchild>rchild)
            {
                return (lchild+1);
            }
            else if(lchild<rchild)
            {
                return (rchild+1);
            }
            else
            {
                return lchild;
            }
        }
    }
    node *clone(node *root,int data)
    {
        if(root==NULL)
        {
            return NULL;
        }
        node *new1=getnewnode(data);
        if(root->left)
        {
            new1->left=clone(root->left,root->left->data);
        }
        if(root->right)
        {
            new1->right=clone(root->right,root->right->data);
        }
        return new1;
    }
    void mirror(node *root)
    {
        if(root==NULL)
        {
            return;
        }
        else
        {
            node *temp;
            mirror(root->left);
            mirror(root->right);

            temp = root->left;
            root->left = root->right;
            root->right = temp;
        }
    }
    void deletebt(node *root)
    {
        if(root==NULL)
        {
            return;
        }
        deletebt(root->left);
        deletebt(root->right);
        cout<<"Deleted node:"<<root->data<<endl;
        delete root;
        root=NULL;
    }
    int internal(node *root)
    {
        if(root==NULL||(root->left==NULL&&root->right==NULL))
        {
            return 0;
        }
        else
        {
            int left=internal(root->left);
            int right=internal(root->right);
            return left+right+1;
        }
    }
    int leaf()
    {
        int internalnodes=internal(root);
        int leaf=count-internalnodes;
        return leaf;
    }
    friend int main();
};
int main()
{
    binary_tree b;
    char ans='y';
    while(ans=='y')
    {
        int choice;
        cout<<"########MENU########"<<endl;
        cout<<"1.Insert a node"<<endl;
        cout<<"2.Perform inorder,preorder and postorder traversal of the tree"<<endl;
        cout<<"3.Swapping of binary tree"<<endl;
        cout<<"4.Height of tree"<<endl;
        cout<<"5.Copy this tree to another"<<endl;
        cout<<"6.Number of leaves and internal nodes"<<endl;
        cout<<"7.Erase all nodes in Binary tree"<<endl;
        cout<<"Enter the choice of operation that you want to perform";
        cin>>choice;
        switch(choice)
        {
            case 1:
            {
                int d;
                cout<<"Enter the element:";
                cin>>d;
                b.insertiterative(d);
                break;
            }
            case 2:
            {
                cout<<"Inorder traversal:";
                b.inorderiterative();
                cout<<endl;
                cout<<"Preorder traversal:";
                b.preorderiterative();
                cout<<endl;
                cout<<"Postorder traversal:"<<endl;
                b.postorderiterative();
                break;
            }
            case 3:
            {
                node *newroot = b.clone(b.root,b.root->data);
                cout<<"The mirror of Binary tree is: "<<endl;
                b.mirror(newroot);
                b.inorderrecursive(newroot);
                break;
            }
            case 4:
            {
               cout<<"The Height of the tree: "<<endl;
               cout<<b.height(b.root)<<endl;
               break;
            }
            case 5:
            {
                node *newroot = b.clone(b.root,b.root->data);
                cout<<"The copy of the Binary tree is: "<<endl;
                b.inorderrecursive(newroot);
                break;
            }
            case 6:
            {
                cout<<"The no. of leaf nodes in tree are: "<<b.leaf()<<endl;
                cout<<"The no. of non-leaf nodes in tree are: "<<b.internal(b.root)<<endl;
                break;
            }
            case 7:
            {
                cout<<"Erasing all nodes of Binary tree: "<<endl;
                b.deletebt(b.root);
                break;
            }
            default:
            {
                cout<<"Invalid choice"<<endl;
                break;
            }
        }
        cout<<endl;
        cout<<"Do you want to continue?(y/n)"<<endl;
        cin>>ans;
    }
    return 0;
}
