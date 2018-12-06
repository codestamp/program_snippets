#include <iostream>
#include <limits.h>
using namespace std;

int main() {
	const int V=5;
	int key[V];
	bool mstSet[V];

	for(int i=0;i<V;i++)
		key[i]=INT_MAX, mstSet[i]=false; 
	//we can see that in above for loop multiple statements are considered as a single line separated by a comma, so 
	//explicit brackets are required


	for(int i=0;i<V;i++)
		cout << key[i] << "," << mstSet[i] << endl;

	return 0;
}
