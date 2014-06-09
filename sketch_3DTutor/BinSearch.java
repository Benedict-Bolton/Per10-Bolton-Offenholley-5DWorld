

/*==================================================
  class BinSearch
  ==================================================*/
  
public class BinSearch {


    /*==================================================
      int binSearch(float[][],float) -- searches an array of float for target float
      pre:  input array is sorted in ascending order
      post: returns indices of five elements closest to target
      ==================================================*/
    public static int[] binSearch ( float[][] a, float target ) {
	return binSearchIter( a, target, 0, a.length-1 );
    }


    /*==================================================
      int binSearchIter(float[],float) -- searches an array of ints for target int,
                                   Uses Iteration.
      pre:  input array is sorted in ascending order
      post: returns indices of five elements closest to target
      ==================================================*/
    public static int[] binSearchIter( float[][] a, float target, int lo, int hi ) {
	int mid = 0;
	float foo = 0;
        int[] ans = new int[5];
	while ( foo != target) {
	    mid = (lo + hi)/2;
	    foo = a[mid][0];
	    if ( foo == target) {
                ans[0] = mid - 2;
                ans[1] = mid - 1;
                ans[2] = mid;
                ans[3] = mid + 1;
                ans[4] = mid + 2;
		break;
	    }
	    if ( hi <= lo) {
                ans[0] = mid - 2;
                ans[1] = mid - 1;
                ans[2] = mid;
                ans[3] = mid + 1;
                ans[4] = mid + 2;
		break;
	    }
	    if (foo < target) {
		lo = mid + 1;
	    }
	    else {
		hi = mid - 1;
	    }
	}
	return ans;
    }





    /*==================================================
      int isSorted(int[]) -- checks if array is sorted in ascending order
      pre:  input is array of ints
      post: true if sorted in ascending order, false otherwise
      ==================================================*/
    private static boolean isSorted( int[] arr ) {
	int prev = (arr[0] - 1);
	for (int cur: arr) {
	    if (cur < prev) {
		return false;
	    }
	    prev = cur;
	}
	return true;
    }


    // utility/helper fxn to display contents of an array of Objects
    private static void printArray( int[] arr ) {
	String output = "[ "; 

	for( int i : arr )
	    output += i + ", ";

	output = output.substring( 0, output.length()-2 ) + " ]";

	System.out.println( output );
    }


   //main method for testing
   /* public static void main ( String[] args ) {



	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	System.out.println("\nNow testing binSearch on int array...");

	//Declare and initialize array of ints
	int[] iArr = { 2, 4, 6, 8, 6, 42 };
	printArray( iArr );
	System.out.println( "sorted? -- " + isSorted(iArr) );

	int[] iArr2 = { 2, 4, 6, 8, 13, 42 };
	printArray( iArr2 );
	System.out.println( "sorted? -- " + isSorted(iArr2) );

	int[] iArr3 = { 2, 4, 7, 42, 13, 1};
	printArray( iArr3 );
	System.out.println( "sorted? -- " + isSorted(iArr3) );

	//search for 6 in array 
	System.out.println( binSearch(iArr2,6) );

	//search for 43 in array 
	System.out.println( binSearch(iArr2,43) );
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    }*///end main()

}//end class BinSearch
