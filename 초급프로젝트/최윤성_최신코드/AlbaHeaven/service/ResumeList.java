package service;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import util.ScanUtil;
import util.View;
import dao.MainDao;

public class ResumeList {
	private ResumeList(){}
	private static ResumeList instance;
	public static ResumeList getInstance(){
		if(instance == null){
			instance = new ResumeList();
		}
		return instance;
	}
	private MainDao mainDao = MainDao.getInstance();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
	
	public int resumeLs() {
		resumels();
		if (((BigDecimal) MainService.login.get("AUTH")).intValue() == 1) {
			System.out.println("==========================================");
			System.out.println("1.내 이력서 보기\t0.뒤로가기");
			System.out.print(">");
			int input = ScanUtil.nextInt();

			switch (input) {
			case 1:
				myresumels();
				break;
			case 2:
				inresumels();
				break;
			case 0:
				return View.MAIN;
			default:
				System.out.println("잘못 입력하였습니다.");
				break;
			}
		} else if (((BigDecimal) MainService.login.get("AUTH")).intValue() == 2) {
			System.out.println("==========================================");
			System.out.println("1.이력서 번호 선택\t0.뒤로가기");
			System.out.println(">");
			int input = ScanUtil.nextInt();

			switch (input) {
			case 1:
				comresumels();
				break;
			case 0:
				return View.MAIN;
			default:
				System.out.println("잘못 입력하였습니다.");
				break;
			}
		} else {
			System.out.println("==========================================");
			System.out.println("1.이력서 번호 선택\t0.뒤로가기");
			System.out.println(">");
			int input = ScanUtil.nextInt();

			switch (input) {
			case 1:
				manresumels();
				break;
			case 0:
				return View.MAIN;
			default:
				System.out.println("잘못입력하였습니다.");
				break;
			}
		}
		return resumeLs();
	}

	//이력서 게시판 전체 출력
	private void resumels() {
		List<Map<String, Object>> resumeBoardList = mainDao.resumeBoardList();
		
		System.out.println("===========================================");
		System.out.println("번호\t제목\t\t작성자\t작성일");
		System.out.println("-------------------------------------------");
		
		for(Map<String, Object> board : resumeBoardList){
			System.out.println(board.get("RL_NO") + "\t" 
							 + ((String) board.get("RL_TITLE")).substring(0,5) + "...\t"
							 + board.get("ALBA_NAME") + "\t"
							 + sdf.format(board.get("RL_DATE")));
		}
		System.out.println("===========================================");
	}
	
	
	//이력서 게시판 개인 내용 확인
	private void myresumels() {
		
			System.out.println("");
			System.out.println("===============내 이력서 게시판 보기===============");

			Map<String, Object> param = new HashMap<>();
			param.put("ALBA_ID", MainService.login.get("ALBA_ID"));
			
			List<Map<String, Object>> resumeList = mainDao.selectResumeLs(param);
			List<Map<String, Object>> careerList = mainDao.careerLs(param);
			List<Map<String, Object>> likeresumeList = mainDao.likeresumeList(param);
			for (int i = 0; i < resumeList.size(); i++) {
				
				System.out.println("이력서리스트\t: " + resumeList.get(0).get("RL_NO"));
				System.out.println("제목\t\t: " + resumeList.get(0).get("RL_TITLE"));
				System.out.println("작성일자\t\t: " + resumeList.get(0).get("RL_DATE"));
				
				System.out.println("이름\t\t: " + resumeList.get(0).get("ALBA_NAME"));
				System.out.println("생년월일\t\t: " + sdf.format(resumeList.get(0).get("ALBA_BIR")));
				System.out.println("성별\t\t: " + resumeList.get(0).get("ALBA_SEXDSTN"));
				System.out.println("전화번호\t\t: " + resumeList.get(0).get("ALBA_TEL"));
				System.out.println("이메일\t\t: " + resumeList.get(0).get("ALBA_MAIL"));
				System.out.println("주소\t\t: " + resumeList.get(0).get("ALBA_ADD"));
				
				System.out.println("학력사항\t\t: " + resumeList.get(0).get("RESUME_EDU1") +" "+ resumeList.get(0).get("RESUME_EDU2"));
				System.out.println("경력사항\t\t: " + resumeList.get(0).get("RESUME_CR1"));
				System.out.println("자기소개서\t\t: " + resumeList.get(0).get("RESUME_INTRCN"));
				System.out.println("희망근무지\t\t: " + resumeList.get(0).get("RESUME_ADD"));
				System.out.println("희망업종\t\t: " + resumeList.get(0).get("RESUME_SECTOR"));
				System.out.println("희망형태\t\t: " + resumeList.get(0).get("RESUME_TYPE"));
				System.out.println("희망근무기간\t: " + resumeList.get(0).get("RESUME_DATE"));
				System.out.println("희망근무시간\t: " + resumeList.get(0).get("RESUME_TIME"));
				System.out.println("이력서공개기간\t: " + resumeList.get(0).get("RESUME_OPENTERM"));
				System.out.println("희망근무요일\t: " + resumeList.get(0).get("RESUME_DAY"));
				
				System.out.println("===================경력리스트===================");
				for (int j = 0; j < careerList.size(); j++) {
					System.out.println("경력 " + (j+1));
					System.out.println("경력회사명\t\t: " + careerList.get(j).get("CR_COM_NAME"));
					System.out.println("경력근무기간\t: " + careerList.get(j).get("CR_COM_TERM"));
					System.out.println("경력담당업무\t: " + careerList.get(j).get("CR_COM_TASK"));
				}
			}
			System.out.println("===================면접제의===================");
			for (int i = 0; i < likeresumeList.size(); i++) {
				System.out.println(i+1 + "번 : " + likeresumeList.get(i).get("RH_LIKE"));
			}
			System.out.println("===========================================");
			System.out.println("1.수정\t2.삭제\t0.뒤로가기");
			System.out.print(">");
			int input = ScanUtil.nextInt();
			switch (input) {
			case 1:
				updateresumels();
				break;// 수정
			case 2:
				deleteresumels();
				break;// 삭제
			case 0:
				break;
			default:
				System.out.println("잘못된 입력입니다.");
				myresumels();
				break;
			}
		}

	//이력서 게시판 수정
	private void updateresumels() {
		System.out.println("================이력서 게시판 수정================");
		System.out.println("수정할 제목");
		System.out.println(">");
		String title = ScanUtil.nextLine();
		
		Map<String, Object> param = new HashMap<>();
		param.put("ALBA_ID", MainService.login.get("ALBA_ID"));
		param.put("RL_TITLE", title);
		
		int result = mainDao.updateResumeLs(param);
		if(0<result){
			System.out.println("이력서게시판에 수정 되었습니다.");
		}else {
			System.out.println("이력서게시판에 수정을 실패하였습니다.");
		}
	}
	
	//이력서 게시판 삭제
	private void deleteresumels() {
		System.out.println("=============== 이력서 게시판 삭제================");
		System.out.println("이력서를 게시판에서 삭제하시겠습니까? (Y/N)");
		System.out.println(">");
		String input = ScanUtil.nextLine();
		
		switch(input){
		case "Y":
		case "y":
			Map<String, Object> param = new HashMap<>();
			param.put("ALBA_ID",MainService.login.get("ALBA_ID"));
			
			int result1 = mainDao.deleteResumeHireLs(param);
			int result2 = mainDao.deleteResumeLs(param);
			if(0<result1 || 0<result2){
				System.out.println("삭제를 완료하였습니다.");				
			}else System.out.println("삭제를 실패하였습니다.");
			break;
		case "N":
		case "n":
			System.out.println("삭제를 취소하였습니다.");
			break;
		default:
			System.out.println("잘못된 입력입니다.");
			System.out.println("이전메뉴로 돌아갑니다.");
			myresumels();
			break;
		}
	}
	
	//이력서 게시판에 올리기
	private void inresumels() {
		System.out.println("===============이력서 게시판 올리기===============");
		System.out.println("이력서 제목");
		System.out.println("주의) 5글자 이상 입력하여야 합니다.");
		System.out.println(">");
		String title = ScanUtil.nextLine();
		
		
		Map<String, Object> param = new HashMap<>();
		param.put("ALBA_ID", MainService.login.get("ALBA_ID"));
		param.put("RL_TITLE", title);
		
		int result = mainDao.insertResumeLs(param);
		
		if(0<result){
			System.out.println("이력서게시판에 업로드 되었습니다.");
		}else {
			System.out.println("이력서게시판에 업로드를 실패하였습니다.");
		}
	}

	//기업회원 - 어필하기
	private void comresumels() {
		System.out.println("==================이력서 조회==================");
		System.out.println("조회 하고 싶은 이력서 번호를 입력하십시오.");
		System.out.print(">");
		int input = ScanUtil.nextInt();
		
		Map<String, Object> param = new HashMap<>();
		param.put("RL_NO", input);
		
		List<Map<String, Object>> resumeList = mainDao.resumeHirels(param);
		List<Map<String, Object>> careerList = mainDao.careerHirels(param);
		
		System.out.println("====================이력서===================");
		for (int i = 0; i < resumeList.size(); i++) {
			System.out.println("이력서리스트\t: " + resumeList.get(i).get("RL_NO"));
			System.out.println("제목\t\t: " + resumeList.get(i).get("RL_TITLE"));
			System.out.println("작성일자\t\t: " + resumeList.get(i).get("RL_DATE"));
			
			System.out.println("이름\t\t: " + resumeList.get(i).get("ALBA_NAME"));
			System.out.println("생년월일\t\t: " + sdf.format(resumeList.get(i).get("ALBA_BIR")));
			System.out.println("성별\t\t: " + resumeList.get(i).get("ALBA_SEXDSTN"));
			System.out.println("전화번호\t\t: " + resumeList.get(i).get("ALBA_TEL"));
			System.out.println("이메일\t\t: " + resumeList.get(i).get("ALBA_MAIL"));
			System.out.println("주소\t\t: " + resumeList.get(i).get("ALBA_ADD"));
			
			System.out.println("학력사항\t\t: " + resumeList.get(i).get("RESUME_EDU1") +" "+ resumeList.get(i).get("RESUME_EDU2"));
			System.out.println("경력사항\t\t: " + resumeList.get(i).get("RESUME_CR1"));
			System.out.println("자기소개서\t\t: " + resumeList.get(i).get("RESUME_INTRCN"));
			System.out.println("희망근무지\t\t: " + resumeList.get(i).get("RESUME_ADD"));
			System.out.println("희망업종\t\t: " + resumeList.get(i).get("RESUME_SECTOR"));
			System.out.println("희망형태\t\t: " + resumeList.get(i).get("RESUME_TYPE"));
			System.out.println("희망근무기간\t: " + resumeList.get(i).get("RESUME_DATE"));
			System.out.println("이력서공개기간\t: " + resumeList.get(i).get("RESUME_OPENTERM"));
			System.out.println("희망근무요일\t: " + resumeList.get(i).get("RESUME_DAY"));
			
			System.out.println("===================경력리스트===================");
			for (int j = 0; j < careerList.size(); j++) {
				System.out.println("경력 " + (j+1));
				System.out.println("경력회사명\t\t: " + careerList.get(j).get("CR_COM_NAME"));
				System.out.println("경력근무기간\t: " + careerList.get(j).get("CR_COM_TERM"));
				System.out.println("경력담당업무\t: " + careerList.get(j).get("CR_COM_TASK"));
			}
		}
		
		System.out.println("======================================");
		System.out.println("1.면접 제의하기\t0.뒤로가기");
		System.out.println(">");
		int input2 = ScanUtil.nextInt();
		
		switch(input2){
		case 1: offer(input); break;
		case 0: break;
			default:
				System.out.println("잘못된 입력입니다.");
				comresumels();
				break;
		}
	}
	
	//기업회원 - 이력서 면접 제의
	private void offer(Integer input) {
		Map<String, Object> param = new HashMap<>();
		param.put("COM_ID", MainService.login.get("COM_ID"));
		param.put("RL_NO", input);
		param.put("RH_LIKE", MainService.login.get("COM_NAME") + "에서 회원님께 면접제의를 보냈습니다.");
		
		mainDao.offerResume(param);
		System.out.println("신청이 완료되었습니다.");
	}
	
	//관리자
	private void manresumels() {
		System.out.println("==================이력서 조회==================");
		System.out.println("보고 싶은 이력서 번호를 입력하십시오.");
		System.out.print(">");
		int input = ScanUtil.nextInt();
		
		Map<String, Object> param = new HashMap<>();
		param.put("RL_NO", input);
		
		List<Map<String, Object>> resumeList = mainDao.resumeHirels(param);
		List<Map<String, Object>> careerList = mainDao.careerHirels(param);
		
		System.out.println("====================이력서===================");
		for (int i = 0; i < resumeList.size(); i++) {
			
			System.out.println("이력서리스트\t: " + resumeList.get(i).get("RL_NO"));
			System.out.println("제목\t\t: " + resumeList.get(i).get("RL_TITLE"));
			System.out.println("작성일자\t\t: " + resumeList.get(i).get("RL_DATE"));
			
			System.out.println("이름\t\t: " + resumeList.get(i).get("ALBA_NAME"));
			System.out.println("생년월일\t\t: " + sdf.format(resumeList.get(i).get("ALBA_BIR")));
			System.out.println("성별\t\t: " + resumeList.get(i).get("ALBA_SEXDSTN"));
			System.out.println("전화번호\t\t: " + resumeList.get(i).get("ALBA_TEL"));
			System.out.println("이메일\t\t: " + resumeList.get(i).get("ALBA_MAIL"));
			System.out.println("주소\t\t: " + resumeList.get(i).get("ALBA_ADD"));
			
			System.out.println("학력사항\t\t: " + resumeList.get(i).get("RESUME_EDU1") +" "+ resumeList.get(i).get("RESUME_EDU2"));
			System.out.println("경력사항\t\t: " + resumeList.get(i).get("RESUME_CR1"));
			System.out.println("자기소개서\t\t: " + resumeList.get(i).get("RESUME_INTRCN"));
			System.out.println("희망근무지\t\t: " + resumeList.get(i).get("RESUME_ADD"));
			System.out.println("희망업종\t\t: " + resumeList.get(i).get("RESUME_SECTOR"));
			System.out.println("희망형태\t\t: " + resumeList.get(i).get("RESUME_TYPE"));
			System.out.println("희망근무기간\t: " + resumeList.get(i).get("RESUME_DATE"));
			System.out.println("이력서공개기간\t: " + resumeList.get(i).get("RESUME_OPENTERM"));
			System.out.println("희망근무요일\t: " + resumeList.get(i).get("RESUME_DAY"));
			
			System.out.println("===================경력리스트===================");
			for (int j = 0; j < careerList.size(); j++) {
				System.out.println("경력 " + (j+1));
				System.out.println("경력회사명\t\t: " + careerList.get(j).get("CR_COM_NAME"));
				System.out.println("경력근무기간\t: " + careerList.get(j).get("CR_COM_TERM"));
				System.out.println("경력담당업무\t: " + careerList.get(j).get("CR_COM_TASK"));
			}
		}
		
		System.out.println("======================================");
		System.out.println("1.삭제\t0.뒤로가기");
		System.out.println(">");
		int input2 = ScanUtil.nextInt();
		
		switch(input2){
		case 1:  manresumedelete(input); break;
		case 0: break;
			default:
				System.out.println("잘못된 입력입니다.");
				manresumels();
				break;
		}
	}

	//관리자 이력서 삭제
	private void manresumedelete(Integer input) {
		System.out.println("==================이력서 삭제==================");
		System.out.println("이력서를 게시판에서 삭제하시겠습니까? (Y/N)");
		System.out.println(">");
		String input2 = ScanUtil.nextLine();
		
		switch(input2){
		case "Y":
		case "y":
			Map<String, Object> param = new HashMap<>();
			param.put("RL_NO",input);
			
			List<Map<String, Object>> checkResumeHire = mainDao.checkResumeHire(param);
			if(checkResumeHire.size()>0){				
				int result1 = mainDao.manDeleteResumeHire(param);
				int result2 = mainDao.manDeleteResumeList(param);
				if(0<result1 || 0<result2){
					System.out.println("삭제를 완료하였습니다.");				
				}else System.out.println("삭제를 실패하였습니다.");
			}else{
				int result2 = mainDao.manDeleteResumeList(param);
				if(0<result2){
					System.out.println("삭제를 완료하였습니다.");				
				}else System.out.println("삭제를 실패하였습니다.");
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
