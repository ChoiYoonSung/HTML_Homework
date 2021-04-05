package service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.CareerDao;
import util.JDBCUtil;
import util.ScanUtil;

public class Careerdata {
	private Careerdata(){}//생성자
	private static Careerdata instance;//변수생성
	public static Careerdata getInstance(){
		if(instance == null){
			instance = new Careerdata();
		}
		return instance;
}
	
	private CareerDao careerDao = CareerDao.getInstance();
	
	
	
	public void Career() {
		Map<String, Object> param = new HashMap<>();
		param.put("ALBA_ID", MainService.login.get("ALBA_ID"));
		String[] key = {"CR_NUM","CR_COM_NAME","CR_COM_TERM","CR_COM_TASK"};
		List<Map<String, Object>> list = careerDao.selectcareer(param);
		System.out.println("===========================================");
		System.out.println("번호\t\t회사명\t\t기간\t\t업무");
		System.out.println("===========================================");
		for (int i = 0; i < list.size(); i++) {
			for (int j = 0; j < key.length; j++) {
				System.out.print(list.get(i).get(key[j]) + "\t\t");
			}
			System.out.println();
		}
		System.out.println("===========================================");
		
	}



	//번호 회사명 근무기간 업무 이력서번호
	public void insertcareer() {
		System.out.println("===================경력 추가===================");
		System.out.println("회사명");
		System.out.print(">");
		String company = ScanUtil.nextLine();
		System.out.println("근무기간");
		System.out.print(">");
		String term = ScanUtil.nextLine();
		System.out.println("업무");
		System.out.print(">");
		String task = ScanUtil.nextLine();
		
		Map<String, Object> param = new HashMap<>();
		param.put("CR_COM_NAME", company);
		param.put("CR_COM_TERM", term);
		param.put("CR_COM_TASK", task);
		param.put("ALBA_ID", MainService.login.get("ALBA_ID"));
		
		int result = careerDao.insertCareer(param);
		if(0<result){
			System.out.println("채용공고가 업로드 되었습니다.");
		}else {
			System.out.println("채용공고 업로드를 실패하였습니다.");
		}
	}



	public void deletecareer() {
		System.out.println("===================경력 삭제===================");
		System.out.println("삭제하려는 번호를 입력하십시오.");
		System.out.print(">");
		int input = ScanUtil.nextInt();
		
		System.out.println(input + "번 경력을 삭제하시겠습니까? (Y/N)");
		System.out.println(">");
		String input2 = ScanUtil.nextLine();
		
		switch (input2) {
		case "Y":
		case "y":
			Map<String, Object> param = new HashMap<>();
			param.put("CR_NUM", input);
			
			int result = careerDao.deleteCareer(param);
			if(0<result)
				System.out.println("삭제를 완료하였습니다.");		
			else
				System.out.println("삭제를 실패하였습니다.");
			break;
		case "N":
		case "n":
			System.out.println("삭제를 취소하였습니다.");
			break;
		default:
			System.out.println("잘못된 입력입니다.");
			System.out.println("이전메뉴로 돌아갑니다.");
			break;
		}
	}
}
