#include <iostream>
#include <stack>
#include <queue>
using namespace std;
#include <climits>

class graph{
    int n;
    int wt[10][10];
    


    bool visited[10];
    int vertex[10];
    int edge[10];


    public:
    graph(){
        cout<<"Enter vertices ",cin>>n;
        for (int i = 0; i < n; i++) {
        visited[i] = false;
        vertex[i] = i;
        edge[i] = INT_MAX; // Initialize edge to infinity
        for (int j = 0; j < n; j++) {
            wt[i][j] = 0; // Initialize weight matrix to 0
        }
    }
    }

    void insert(){
        int x;
        for(int i=0;i<n;i++){
            for(int j=i+1;j<n;j++){
                cout<<"Enter weight between "<<i<<" & "<<j<<" : ";
                cin>>x;
                wt[i][j] = wt[j][i] = x;
            }
        }
        for(int k=0;k<n;k++){
            wt[k][k] = 0;
        }
    }

    void display(){
    for(int i=0;i<n;i++){
        for(int j=0;j<n;j++){
            cout<<wt[i][j]<<" ";
        }
        cout<<endl;
    }
    }

    int primsHelper(){
        int min = 999;
        int min_index;
        for(int i=0;i<n;i++){
            if(visited[i]==false && edge[i]<min){
                min = edge[i];
                min_index = i;
            }
        }
        return min_index;
    }

    void prims(){
        //initialize vertices to vertex and mark all edges as infinity
        for(int i=0;i<n;i++){
            vertex[i] = i;
            edge[i] = 999;
        }
        //set 1st vetex as -1 since its root and then set edge 1 to 0
        vertex[0] = -1;
        edge[0] = 0;

        for(int k =0;k<n-1;k++){
        //find index of vertex having minimum edge and thats not visited
        int index = primsHelper();
        //mark that index as visited
        visited[index] = true;

        //we search all the adjacent vertices of min index, if they have not been visited and their edge is smaller than current edge stored, update the edge
        for(int j=0;j<n;j++){
            if((wt[index][j]!=0) && (visited[j]==false) && (edge[j]>wt[index][j]) ){
                edge[j] = wt[index][j];
                vertex[j] = index;
            }
        } 
        
        }

        minCost();
    }

    void minCost(){
        int cost=0;
        for(int i=0;i<n;i++){
            cost+=edge[i];
        }
        cout<<"Minimum cost = "<<cost;
    }

};


int main(){
    graph g;
    g.insert();
    g.display();
    g.prims();

}
