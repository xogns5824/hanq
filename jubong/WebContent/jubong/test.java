package jubong;

import java.util.ArrayList;

public class test {

	public static void main(String[] args) {

		ArrayList<String[]> test1 = new ArrayList<String[]>();
		String[] test2 = {"0","1"};
		test1.add(0, test2);
		
		System.out.println(test1.get(0)[0]);
		
	}

}
