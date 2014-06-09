
public class Sorts {
    
    private static int partition (float[][] input, int left, int right) {
	int indPiv = (int) (left + (Math.random() * (right - left + 1)) );
	float[] hold;
	hold = input[right];
	input[right] = input[indPiv];
	input[indPiv] = hold;
	//indPiv = right;
	//right--;
	for (int i = left; i < right; i++) {
	    if (input[i][0] < input[right][0]) {
		hold = input[left];
		input[left] = input[i];
		input[i] = hold;
		left++;
	    }
	}
	hold = input[left];
	input[left] = input[right];
	input[right] = hold;
	int lefMar = (left + 1);
	for(int i = lefMar; i <= right; i++) {
	    if (input[i][0] == input[left][0]) {
		hold = input[lefMar];
		input[lefMar] = input[i];
		input[i] = hold;
		lefMar++;
	    }
	}
	return (left + lefMar)/2;
    }
    
    
    public static float[] quickSelect (float[][] A, int k, int left, int right) {
	int pindex = partition( A, left, right);
	if (pindex == k) {
	    return A[k];
	}
	else if (k < pindex) {
	    return quickSelect(A, k, left, pindex - 1);
	}
	else {
	    return quickSelect(A, k, pindex + 1, right);
	}
    }
    
    public static float[] quickSelect (float[][] A, int k) {
	if (k >= A.length || k < 0) {
	    return A[k];
	}
	return quickSelect(A, k, 0, A.length - 1);
    }
    
    public static void quicksort (float[][] L) {
      quickSort (L , 0, L.length - 1);
    }
    
    public static void quickSort (float[][] A, int left, int right) {
	int curSec = ( (right - left) + 1);
	if (curSec < 2) {
	    return;
	}
	/*for (int x: A) {
	    System.out.print( x + ", ");
	}
	System.out.println("\n");*/
	int pindex = partition( A, left, right);
	/*System.out.println(pindex);
	for (int x: A) {
	    System.out.print( x + ", ");
	}
	System.out.println("\n");*/
	quickSort ( A, left, pindex - 1);
	quickSort ( A, pindex + 1, right);
    }
    
    
    /*public static void main (String[] args) {
	int[] numTes = { 3, 5, 19, 1, 7, 4, 12, 0, 9};
	int[] numTest = { 4, 16, 2, 1, 2, 7, 15, 22, 10};
	//0, 1, 3, 4, 5, 7, 9, 12, 19
	int[] numTes2 = { 3, 6, 21, 1, 10, 4, 4};
	int[] numTes3 = { 333, 555, 1999, 111, 777, 444, 1222, 0, 909, 0, 0, 0};
	int[] numTes4 = { 3, 1, 1, 1, 1, 1, 1, 0, 1, 1, 4, 2};
	int[] numTes5 = { 3 };
	int[] numTes6 = {};
	//quicksort(numTes);
	quicksort(numTes2);
	System.out.println(partition(numTes4, 0, numTes4.length-1));
	System.out.println("\n");
	for (int x: numTes2) {
	    System.out.print(x + ", ");
	}
    }*/
	
}//end class
	
