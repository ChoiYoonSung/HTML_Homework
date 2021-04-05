package e_oop.score;

public class Score {

	public static void main(String[] args) {
		Student[] students = new Student[10];
		
		for(int i = 0; i < students.length; i++){
			Student student = new Student();
			
			student.name = "학생" + (i + 1);
			student.rank = 1;
			student.kor = (int)(Math.random() * 101);
			student.eng = (int)(Math.random() * 101);
			student.math = (int)(Math.random() * 101);
			
			student.sum = student.kor + student.eng + student.math;
			student.avg = Math.round(student.sum / 3.0 * 100) / 100.0;
			
			students[i] = student;
		}
		
		//성적관리 프로그램을 완성해주세요.
		for(int i = 0; i < students.length; i++){
			for(int j = 0; j < students.length; j++){
				if(students[i].sum < students[j].sum){
					students[i].rank++;
				}
			}
		}
		
		for(int i = 0; i < students.length - 1; i++){
			int min = i;
			for(int j = i + 1; j < students.length; j++){
				if(students[j].sum > students[min].sum){
					min = j;
				}
			}
			Student temp = students[i];
			students[i] = students[min];
			students[min] = temp;
		}
		
		System.out.println("\t국어\t영어\t수학\t합계\t평균\t석차");
		for(int i = 0; i < students.length; i++){
			System.out.print(students[i].name + "\t");
			System.out.print(students[i].kor + "\t");
			System.out.print(students[i].eng + "\t");
			System.out.print(students[i].math + "\t");
			System.out.print(students[i].sum + "\t");
			System.out.print(students[i].avg + "\t");
			System.out.print(students[i].rank + "\t");
			System.out.println();
		}
		
		int[] subSum = new int[3];
		double[] subAvg = new double[3];
		for(int i = 0; i < students.length; i++){
			subSum[0] += students[i].kor;
			subSum[1] += students[i].eng;
			subSum[2] += students[i].math;
		}
		subAvg[0] = subSum[0] / students.length;
		subAvg[1] = subSum[1] / students.length;
		subAvg[2] = subSum[2] / students.length;
		System.out.print("과목합계\t");
		for(int i = 0; i < subSum.length; i++){
			System.out.print(subSum[i] + "\t");
		}
		System.out.println();
		System.out.print("과목평균\t");
		for(int i = 0; i < subAvg.length; i++){
			System.out.print(subAvg[i] + "\t");
		}
	}

}








