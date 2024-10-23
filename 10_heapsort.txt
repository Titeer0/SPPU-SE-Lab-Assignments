#include <iostream>
using namespace std;
class heap
{
    int arr[10];
    int count;
    public:
    heap()
    {
        count = 0;
        for(int i=0;i<10;i++)
        {
            arr[i]=0;
        }
    }
    void insert();
    void heapify(int data);
    void display();
    void heapsort();
};
void heap::insert()
{
    int data;
    for(int i=0; i<10; i++){
        cout<<"Enter Element:"<<endl;
        cin>>data;
        heapify(data);
    }
    
}
void heap::heapify(int data){
    arr[count] = data;
    int i = count;
    while(i >= 0){
        int z = (i-1)/2;
        if(arr[z] > arr[i]){
            swap(arr[z],arr[i]);
            i = (i-1)/2;
        }
        else{
            break;
        }
        
    }
    count++;
}

void heap::display(){
    for(int i=0; i<10; i++){
        cout<<arr[i]<<" ";
    }
    cout<<endl;
}

void heap::heapsort()
{
   
    int count1=9;
    
    while(count1>=0)
    {
        count=0;
        swap(arr[0],arr[count1]);
        for(int i=0;i<count1;i++)
        {
            heapify(arr[i]);
        }
         count1--;
    }
    

}
int main()
{
	
    heap h;
    h.insert();
    h.display();
    h.heapsort();
    return 0;
}
