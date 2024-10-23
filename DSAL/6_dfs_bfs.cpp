// #include <iostream>
// using namespace std;

// template <class t>
// class stack
// {
//     int top;
//     t arr1[10];
//     public:
//     stack()
//     {
//         top=-1;
//     }
//     t get_top();
//     void push(t x);
//     t pop();
//     bool is_empty();
// };

// template <class t>
// t stack<t>::get_top()
// {
//     return arr1[top];
// }

// template <class t>
// void stack<t>::push(t x)
// {
//     if(top>=9)
//     {
//         cout<<"Stack Overflow"<<endl;
//     }
//     else
//     {
//         top++;
//         arr1[top]=x;
//     }
// }

// template <class t>
// t stack<t>::pop()
// {
//     t x=0;
//     if(top==-1)
//     {
//         cout<<"Stack Underflow"<<endl;
//     }
//     else
//     {
//         x=arr1[top];
//         top--;
//     }
//     return x;
// }

// template <class t>
// bool stack<t>::is_empty()
// {
//     if(top==-1)
//     {
//         return true;
//     }
//     else 
//     {
//         return false;
//     }
// }

// template <class t>
// class queue
// {
//     t arr2[10];
//     int front;
//     int rear;
//     public:
//     queue()
//     {
//         front=-1;
//         rear=-1;
//     }
//     t get_front();
//     void enqueue(t x);
//     void dequeue();
//     bool isempty();
// };

// template <class t>
// t queue<t>::get_front()
// {
//     return arr2[front];
// }

// template <class t>
// void queue<t>::enqueue(t x)
// {
//     if(rear>9)
//     {
//         cout<<"Queue Overflow"<<endl;
//     }
//     else
//     {
//         if(front==-1 && rear==-1)
//         {
//             front++;
//             rear++;
//             arr2[rear]=x;
//         }
//         else
//         {
//             rear++;
//             arr2[rear]=x;
//         }
//     }
// }

// template <class t>
// void queue<t>::dequeue()
// {
//     if(front==-1)
//     {
//         cout<<"Queue Underflow"<<endl;
//     }
//     else
//     {
//         if(front==rear)
//         {
//             front=-1;
//             rear=-1;
//         }
//         else
//         {
//             front++;
//         }
//     }
// }

// template <class t>
// bool queue<t>::isempty()
// {
//     if(front==-1)
//     {
//         return true;
//     }
//     else
//     {
//         return false;
//     }
// }

#include <iostream>
#include <stack>
#include <queue>
using namespace std;

//dfs = stack
//bfs = queue

class node{
    public:
    int data;
    node* next;

    node(){
        data = -1;
        next = NULL;
    }
    node(int x){
        this->data = x;
        this->next = NULL;
    }
    friend class graph;
};

class graph{
    
    node* listArray[5]; 
    public:
    graph(){
        for(int i=0;i<5;i++){
            listArray[i] = new node(i+1);
        }
    }

    void insert(){
        for(int i=0;i<5;i++){
            for(int j=i+1;j<5;j++){
                bool edge;
                cout<<"Is there edge between "<<i+1<<" & "<<j+1<<"(0/1) ";
                cin>>edge;
                if(edge){
                    node* newnode = new node(j+1);
                    node* curr = listArray[i];
                    while(curr->next != NULL){
                        curr = curr->next;
                    }
                    curr->next = newnode;
                    //for j vertex
                    node* newnode1 = new node(i+1);
                    curr = listArray[j];
                    while(curr->next != NULL){
                        curr = curr->next;
                    }
                    curr->next = newnode1;
                }
            }
        }
    }

    void display(){
        for(int i =0;i<5;i++){
            node* current = listArray[i];
            while(current != NULL){
                cout<<current->data<<" ";
                current = current->next;
            }
            cout<<endl;
        }
    }

    void dfs(){
        stack<node*> s;
        int visited[5] = {0,0,0,0,0};
        s.push(listArray[0]);
        while(!s.empty()){
            node* current = s.top();
            node* neighbour_v = listArray[(current->data) -1 ];
            cout<<current->data<<" ";
            visited[(current->data) -1] = 1;
            s.pop();
            while(neighbour_v != NULL){
                if(visited[(neighbour_v->data)-1] == 0) {
                    s.push(neighbour_v);
                    visited[(neighbour_v->data) -1] = 1;
                }
                neighbour_v = neighbour_v->next;
            }
        }
    }

    void bfs(){
        queue <node* > q;
        int visited[5] = {0,0,0,0,0};
        q.push(listArray[0]);
        while(!q.empty()){
            node* current = q.front();
            node* nv = listArray[(current->data)-1];
            cout<<current->data<<" ";
            visited[(current->data)-1] = 1;
            q.pop();
            while(nv != NULL){
                if(visited[(nv->data)-1] == 0){
                    q.push(nv);
                    visited[(nv->data)-1] = 1;
                }
                nv = nv->next;
            }
        }
    }



};

int main(){
    graph g;
    //cout<<"hello";
    g.insert();
    cout<<"\n\n";
    g.display();
    cout<<"\ndfs:\n";
    g.dfs();
    cout<<"\nbfs:\n";
    g.bfs();
    return 0;
}
