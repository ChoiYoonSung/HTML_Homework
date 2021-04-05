package service;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.MainDao;
import util.ScanUtil;
import util.View;

public class HireList {
	private HireList(){}
	private static HireList instance;
	public static HireList getInstance(){
		if(instance == null){
			instance = new HireList();
		}
		return instance;
	}
	private MainDao mainDao = MainDao.getInstance();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
	
	public int hireLs() {
		hirels();
		System.out.println("===========================================");
		if (((BigDecimal) MainService.login.get("AUTH")).intValue()==2){
		System.out.println("1.채용공고 올리기\t0.뒤로가기");
		System.out.print(">");
		int input = ScanUtil.nextInt();
		
		switch(input){
		case 1: inhirels(); break;
		case 0: return View.MAIN;
		default:
			System.out.println("잘못 입력하였습니다.");
			break;
		}
		}else if (((BigDecimal) MainService.login.get("AUTH")).intValue()==1){
			System.out.println("==========================================");
			System.out.println("1.채용공고 번호 선택\t0.뒤로가기");
			System.out.println(">");
			int input = ScanUtil.nextInt();
			
			switch(input){
			case 1: alhirels(); break;
//			case 2: alkeywordhire(); break;
			case 0: return View.MAIN;
			default:
				System.out.println("잘못 입력하였습니다.");
				break;
			}
			return hireLs();
		}else{
			System.out.println("==========================================");
			System.out.println("1.채용공고 번호 선택\t0.뒤로가기");
			System.out.println(">");
			int input = ScanUtil.nextInt();
			
			switch(input){
			case 1: manhirels(); break;
			case 0: return View.MAIN;
			default:
				System.out.println("잘못입력하였습니다.");
				break;
			}
			return hireLs();
		}
		return hireLs();
	}
	
	
	//채용공고 전체 게시판 출력(완)
	private void hirels() {
		List<Map<String, Object>> hireBoardList = mainDao.hireBoardList();
		
		System.out.println("=================채용공고 게시판=================");
		System.out.println("번호\t제목\t\t작성자\t공고종료일");
		System.out.println("--------------------------------------------");
		for(Map<String, Object> board : hireBoardList){
			System.out.println(board.get("HIRE_NO") + "\t" 
							 + ((String) board.get("HIRE_TITLE")).substring(0,6) + "...\t"
							 + board.get("COM_NAME") + "\t"
							 + sdf.format(board.get("HIRE_DATE")));
		}
		System.out.println("============================================");
	}

	//채용공고 게시판 올리기
	private void inhirels() {
		
		System.out.println("=====================채용공고 올리기=====================");
		System.out.println("구인제목");
		System.out.println("주의) 6글자 이상 입력하여야 합니다.");
		System.out.print(">");
		String title = ScanUtil.nextLine();
		System.out.println("채용연령");
		System.out.println("ex)20세 미만/20세~30세/30세~40세/40세 이상");
		System.out.print(">");
		String age = ScanUtil.nextLine();
		System.out.println("근무지역");
		System.out.println("ex)서울/경기/대전/대구/부산");
		System.out.print(">");
		String add = ScanUtil.nextLine();
		System.out.println("업종");
		System.out.println("ex)매장관리/서빙주방/서비스미디어/생산기능운전배달/사무회계/IT디자인/고객상담/교육");
		System.out.print(">");
		String sector = ScanUtil.nextLine();
		System.out.println("고용형태");
		System.out.println("ex)파트타임/인턴/계약직/정규직");
		System.out.print(">");
		String emp = ScanUtil.nextLine();
		System.out.println("근무기간");
		System.out.println("ex)1개월이하/1~6개월/6개월~1년/1년이상");
		System.out.print(">");
		String al_date = ScanUtil.nextLine();
		System.out.println("근무요일");
		System.out.println("ex)주2일이하/주2~4일/주5~6일/무관");
		System.out.print(">");
		String day = ScanUtil.nextLine();
		System.out.println("근무시간");
		System.out.println("ex)오전/오후/야간/무관");
		System.out.print(">");
		String time = ScanUtil.nextLine();
		System.out.println("급여");
		System.out.println("(숫자만 입력하십시오)");
		System.out.print(">");
		int cost = ScanUtil.nextInt();
		System.out.println("급여형태");
		System.out.println("ex)시급/일급/주급/월급/연봉");
		System.out.print(">");
		String cost_type = ScanUtil.nextLine();
		System.out.println("성별");
		System.out.println("ex)남/여/무관");
		System.out.print(">");
		String sexdtn = ScanUtil.nextLine();
		System.out.println("인원");
		System.out.println("(숫자만 입력하십시오)");
		System.out.print(">");
		int num = ScanUtil.nextInt();
		System.out.println("학력사항1");
		System.out.println("ex)초등학교/중학교/고등학교/대학교2,3년제/대학교4년제/대학원");
		System.out.print(">");
		String edu1 = ScanUtil.nextLine();
		System.out.println("학력사항2");
		System.out.println("ex)재학/졸업/중퇴");
		System.out.print(">");
		String edu2 = ScanUtil.nextLine();
		System.out.println("구인날짜 ");
		System.out.println("(현재 날짜 + 30/60/90일)(숫자로 입력하십시오.)");
		System.out.print(">");
		int date = ScanUtil.nextInt();
		
		Map<String, Object> param = new HashMap<>();
		param.put("COM_ID", MainService.login.get("COM_ID"));
		param.put("HIRE_AGE", age);
		param.put("HIRE_ADD", add);
		param.put("HIRE_SECTOR", sector);
		param.put("HIRE_DAY", day);
		param.put("HIRE_TIME", time);
		param.put("HIRE_EMP", emp);
		param.put("HIRE_AL_DATE", al_date);
		param.put("HIRE_COST", cost);
		param.put("HIRE_SEXDTN", sexdtn);
		param.put("HIRE_NUM", num);
		param.put("HIRE_EDU1", edu1);
		param.put("HIRE_EDU2", edu2);
		param.put("HIRE_COST_TYPE", cost_type);
		param.put("HIRE_DATE", date);
		param.put("HIRE_TITLE", title);
		
		int result = mainDao.insertHireLs(param);
		
		if(0<result){
			System.out.println("채용공고가 업로드 되었습니다.");
		}else {
			System.out.println("채용공고 업로드를 실패하였습니다.");
		}
	}
	/*
	//개인회원 키워드 검색
	private void alkeywordhire() {
		System.out.println("검색하고 싶은 대분류를 선택하십시오.");
		List<Map<String, Object>> keywordHire = mainDao.keyword();
		
		for (int i = 0; i < keywordHire.size(); i++) {
			System.out.print(i+1 + ". " + keywordHire.get(i).get("COMMON_TYPE") + " | ");
		}
		System.out.println();
		
		System.out.print(">");
		int input = ScanUtil.nextInt();
		String keywordnum = "T0" + input;
		
		
		Map<String, Object> param = new HashMap<>();
		param.put("COMMON_TYPE_COD", keywordnum);
		
		List<Map<String,Object>> keywordSearch = mainDao.keywordSearch(param);
		
		for (int i = 0; i < keywordSearch.size(); i++) {
			System.out.print(i+1 + ". " + keywordSearch.get(i).get("COMMON_COD_NAME") + " | ");
		}		
		System.out.println();
//		System.out.println("검색하고 싶은 키워드를 입력하십시오.(오타x)");
//		String input2 = ScanUtil.nextLine();
		System.out.println(">");
		int input2 = ScanUtil.nextInt();
	}*/
	


	//개인회원 채용공고 리스트
	private void alhirels() {
		System.out.println("===================채용공고====================");
		System.out.println("조회 하고 싶은 채용공고 번호를 입력하십시오.");
		System.out.print(">");
		int input = ScanUtil.nextInt();
		
		Map<String, Object> param = new HashMap<>();
		param.put("HIRE_NO", input);
		
		List<Map<String, Object>> hireList = mainDao.hireResumels(param);
		
		System.out.println("====================채용공고====================");
		for (int i = 0; i < hireList.size(); i++) {	
			
			System.out.println("구인제목\t:" + hireList.get(i).get("HIRE_TITLE"));
			System.out.println("연령\t:" + hireList.get(i).get("HIRE_AGE"));
			System.out.println("지역\t:" + hireList.get(i).get("HIRE_ADD"));
			System.out.println("업종\t:" + hireList.get(i).get("HIRE_SECTOR"));
			System.out.println("고용형태\t:" + hireList.get(i).get("HIRE_EMP"));
			System.out.println("근무기간\t:" + hireList.get(i).get("HIRE_AL_DATE"));
			System.out.println("근무요일\t:" + hireList.get(i).get("HIRE_DAY"));
			System.out.println("근무시간\t:" + hireList.get(i).get("HIRE_TIME"));
			System.out.println("급여\t:" + hireList.get(i).get("HIRE_COST_TYPE") + hireList.get(i).get("HIRE_COST"));
			System.out.println("성별\t:" + hireList.get(i).get("HIRE_SEXDTN"));
			System.out.println("인원\t:" + hireList.get(i).get("HIRE_NUM"));
			System.out.println("학력사항\t: " + hireList.get(i).get("HIRE_EDU1") + hireList.get(i).get("HIRE_EDU2"));
			System.out.println("구인날짜\t:" + hireList.get(i).get("HIRE_DATE"));
		}
		
		System.out.println("==========================================");
		System.out.println("1.신청하기\t0.뒤로가기");
		System.out.println(">");
		int input2 = ScanUtil.nextInt();
		
		switch(input2){
		case 1: offer(input); break;
		case 0: break;
		default:
			System.out.println("잘못된 입력입니다.");
			alhirels();
			break;
		}
	}
	
	//개인회원 - 채용공고 지원
	private void offer(Integer input) {
		Map<String, Object> param = new HashMap<>();
		param.put("ALBA_ID", MainService.login.get("ALBA_ID"));
		param.put("HIRE_NO", input);
		param.put("HR_LIKE", MainService.login.get("ALBA_NAME") + "님이 면접을 신청하였습니다.");
		
		mainDao.offerhireList(param);
		System.out.println("신청이 완료되었습니다.");
	}

	//관리자 채용공고 리스트
	private void manhirels() {
		System.out.println("===================채용공고===================");
		System.out.println("조회 하고 싶은 채용공고 번호를 입력하십시오.");
		System.out.print(">");
		int input = ScanUtil.nextInt();
		
		Map<String, Object> param = new HashMap<>();
		param.put("HIRE_NO", input);
		
		List<Map<String, Object>> hireList = mainDao.hireResumels(param);
		
		System.out.println("===================채용공고===================");
		for (int i = 0; i < hireList.size(); i++) {			
			System.out.println("구인제목\t:" + hireList.get(i).get("HIRE_TITLE"));
			System.out.println("연령\t:" + hireList.get(i).get("HIRE_AGE"));
			System.out.println("지역\t:" + hireList.get(i).get("HIRE_ADD"));
			System.out.println("업종\t:" + hireList.get(i).get("HIRE_SECTOR"));
			System.out.println("고용형태\t:" + hireList.get(i).get("HIRE_EMP"));
			System.out.println("근무기간\t:" + hireList.get(i).get("HIRE_AL_DATE"));
			System.out.println("근무요일\t:" + hireList.get(i).get("HIRE_DAY"));
			System.out.println("근무시간\t:" + hireList.get(i).get("HIRE_TIME"));
			System.out.println("급여\t:" + hireList.get(i).get("HIRE_COST_TYPE") + hireList.get(i).get("HIRE_COST"));
			System.out.println("성별\t:" + hireList.get(i).get("HIRE_SEXDTN"));
			System.out.println("인원\t:" + hireList.get(i).get("HIRE_NUM"));
			System.out.println("학력사항\t: " + hireList.get(i).get("HIRE_EDU1") + hireList.get(i).get("HIRE_EDU2"));
			System.out.println("구인날짜\t:" + hireList.get(i).get("HIRE_DATE"));
		}
		
		System.out.println("==========================================");
		System.out.println("1.삭제\t0.뒤로가기");
		System.out.println(">");
		int input2 = ScanUtil.nextInt();
		
		switch(input2){
		case 1: manhiredelete(input); break;
		case 0: break;
		default:
			System.out.println("잘못된 입력입니다.");
			alhirels();
			break;
		}
	}

	private void manhiredelete(int input) {
		System.out.println("채용공고를 게시판에서 삭제하시겠습니까? (Y/N)");
		System.out.println(">");
		String input2 = ScanUtil.nextLine();
		
		switch(input2){
		case "Y":
		case "y":
			Map<String, Object> param = new HashMap<>();
			param.put("HIRE_NO",input);
			
			List<Map<String, Object>> checkHireResume = mainDao.checkHireResume(param);
			if(checkHireResume.size() > 0){
				int result1 = mainDao.manDeleteHireResume(param);
				int result2 = mainDao.manDeleteHire(param);
				
				if(0<result1 || 0<result2)
					System.out.println("삭제를 완료하였습니다.");		
				else
					System.out.println("삭제를 실패하였습니다.");
			}else{
				int result2 = mainDao.manDeleteHire(param);
				if(0<result2)
					System.out.println("삭제를 완료하였습니다.");		
				else
					System.out.println("삭제를 실패하였습니다.");
			}
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
