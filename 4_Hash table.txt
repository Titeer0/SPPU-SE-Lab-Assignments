#include <iostream>
#include <string>
using namespace std;

class hashTable
{
    string name_arr[10];
    long int num_arr[10];

    public:
    hashTable(){
        for(int i=0;i<10;i++){
            num_arr[i] = -1;
            name_arr[i] = " ";
            }
    }

    int hashfunc(int x){
        return x%10;
    }

    void insert1(string name,long int num){
        int hashIndex = hashfunc(name[0]);
        if(num_arr[hashIndex] == -1){
            num_arr[hashIndex] = num;
            name_arr[hashIndex] = name;
            return;
        }else{
            while(num_arr[hashIndex] != -1){
                hashIndex = (hashIndex+1)%10;
            }
            num_arr[hashIndex] = num;
            name_arr[hashIndex] = name;
            return;
        }
    }

    void insert2(string name,long int num){
        int hashIndex = hashfunc(name[0]);
        if(num_arr[hashIndex] == -1){
            num_arr[hashIndex] = num;
            name_arr[hashIndex] = name;
            return;
        }else{
            string oldName = name_arr[hashIndex];
            int oldNum = num_arr[hashIndex];
            if(hashfunc(oldName[0]==hashIndex)){
                while(num_arr[hashIndex] != -1){
                hashIndex = (hashIndex+1)%10;
                    }
            num_arr[hashIndex] = num;
            name_arr[hashIndex] = name;
            }
            else{
                num_arr[hashIndex] = num;
                name_arr[hashIndex] = name;
                while(num_arr[hashIndex] != -1){
                hashIndex = (hashIndex+1)%10;
                    }
                num_arr[hashIndex] = oldNum;
                name_arr[hashIndex] = oldName;
                
            }
            return;
        }
    }

    void display(){
        for(int i=0;i<10;i++){
            cout<<i<<"\t"<<name_arr[i]<<"\t"<<num_arr[i]<<"\t"<<hashfunc(name_arr[i][0]) <<endl;
        }
    }
};


int main(){
    hashTable ht,ht1;
    string s;
    long int n;
    for(int i=0;i<10;i++){
            cout<<"name ",cin>>s;
            cout<<"num ",cin>>n;
            ht.insert2(s,n);
            ht1.insert1(s,n);
        }
    
    ht.display();
    cout<<"W/o replace: "<<endl;
    ht1.display();

}



/*
#include <iostream>
#include <string>
using namespace std;
class node
{
    public:
    string name;
    long int num;
    node *next;
    node()
    {
        name="";
        num=-1;
        next=NULL;
    }
};
class database:public node
{
    public:
    node *head;
    database()
    {
        head=NULL;
    }
    void insert(string s,long int a)
    {
        node *new1=new node;
        new1->name=s;
        new1->num=a;
        if(head==NULL)
        {
            head=new1;
            new1->next=NULL;
        }
        else
        {
            node *c=head;
            while(c->next!=NULL)
            {
                c=c->next;
            }
            c->next=new1;
            new1->next=NULL;
        }
    }
};
class hash1
{
    public:
    long int arr[5];
    string arr1[5];
    hash1()
    {
        for(int i=0;i<5;i++)
        {
            arr[i]=-1;
            arr1[i]="";
        }
    }
    int hashcode(long int key)
    {
        return (key%5);
    }
    void insert1(node *item)
    {
        int hashindex=hashcode(item->num);
        if(arr[hashindex]==-1)
        {
            arr[hashindex]=item->num;
            arr1[hashindex]=item->name;
        }
        else
        {
            while(arr[hashindex]!=-1)
            {
                hashindex=(hashindex+1)%5;
            }
            arr[hashindex]=item->num;
            arr1[hashindex]=item->name;
        }
    }
    void insert2(node *item)
    {
        int hashindex=hashcode(item->num);
        if(arr[hashindex]==-1)
        {
            arr[hashindex]=item->num;
            arr1[hashindex]=item->name;
        }
        else
        {
            int temp=arr[hashindex];
            string temp1=arr1[hashindex];
            if(hashcode(temp)==hashindex)
            {
                while(arr[hashindex]!=-1)
                {
                    hashindex=(hashindex+1)%5;
                }
                arr[hashindex]=item->num;
                arr1[hashindex]=item->name;
            }
            else
            {
                arr[hashindex]=item->num;
                arr1[hashindex]=item->name;
                while(arr[hashindex]!=-1)
                {
                    hashindex=(hashindex+1)%5;
                }
                arr[hashindex]=temp;
                arr1[hashindex]=temp1;
            }
        }
    }
    void display()
    {
        for(int i=0;i<5;i++)
        {
            cout<<"Name is:"<<arr1[i]<<"                                                                   "<<"Telephone no is:"<<arr[i]<<endl;
        }
    }
    int search(long int key,int *c)
    {
       int flag=0;
        int hashindex=hashcode(key);
        while(arr[hashindex]!=-1)
        {
            if(arr[hashindex]==key)
            {
                int flag=1;
                return hashindex;
            }
            hashindex=(hashindex+1)%5;
            *c=*c+1;
            if(hashindex==hashcode(key))
            {
                break;
            }
        }
        if(flag==0)
        {
            return -1;
        }
    }
};
int main()
{
    database d;
    hash1 h1,h2;
    bool flag=true;
    while(flag)
    {
        cout<<"********************************MENU*********************************"<<endl;
        cout<<"Press 1 To insert database"<<endl;
        cout<<"Press 2 To insert database in hashtable without replacement"<<endl;
        cout<<"Press 3 To insert database in hashtable with replacement"<<endl;
        cout<<"Press 4 To search a element in hashtable without replacement"<<endl;
        cout<<"Press 5 To search a element in hashtable with replacement"<<endl;
        int choice;
        cout<<"Enter your choice:";
        cin>>choice;
        cout<<"*********************************************************************"<<endl;
        if(choice==1)
        {
            string name1;
            long int x;
            for(int i=0;i<5;i++){
                cout<<"Enter the name:";
                cin>>name1;
                cout<<"Enter telphone no:";
                cin>>x;
                d.insert(name1,x);
            }
        }
        else if(choice==2)
        {
            node *c1=d.head;
            while(c1!=NULL)
            {
                h1.insert1(c1);
                c1=c1->next;
            }
            h1.display();
        }
        else if(choice==3)
        {
            node *c2=d.head;
            while(c2!=NULL)
            {
                h2.insert2(c2);
                c2=c2->next;
            }
            h2.display();
        }
        else if(choice==4)
        {
            int count = 1;
        	cout<<"Enter the key to found:";
        	long int f;
        	cin>>f;
        	int f1 = h1.search(f, &count);
            if(f1!=-1)
            {
                cout<<"The key is present at index:"<<f1<<" Name is:"<<h1.arr1[f1]<<endl;
        	    cout<<"Number of comparison:"<<count<<endl;
            }
            else
            {
                cout<<"Element not found"<<endl;
            }
        }
        else if(choice==5)
        {
        	int count = 1;
        	cout<<"Enter the key to found:";
        	long int f;
        	cin>>f;
        	int f1 = h2.search(f, &count);
            if(f1!=-1)
            {
                cout<<"The key is present at index:"<<f1<<" Name is:"<<h2.arr1[f1]<<endl;
        	    cout<<"Number of comparison:"<<count<<endl;
            }
            else
            {
                cout<<"Element not found"<<endl;
            }
        	
        }
    }
    return 0;
}
*/
