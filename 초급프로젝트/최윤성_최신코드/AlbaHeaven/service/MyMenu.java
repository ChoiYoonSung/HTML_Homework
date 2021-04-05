package service;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.AlbaMenuDao;
import dao.ComMenuDao;
import dao.CommonDao;
import util.JDBCUtil;
import util.ScanUtil;
import util.View;

public class MyMenu {
	private static MyMenu instance;
	public static MyMenu getInstance(){
		if(instance == null){
			instance = new MyMenu();
		}
		return instance;
	}	
	private GetHire getHire = GetHire.getInstance();
	private Albadata albaData = Albadata.getInstance();
	private Comdata comData = Comdata.getInstance();
	private AlbaMenuDao albaMenuDao = AlbaMenuDao.getInstance();
	private ComMenuDao comMenuDao = ComMenuDao.getInstance();
	private CommonDao commonDao = CommonDao.getInstance();
	private Careerdata careerdata = Careerdata.getInstance();
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
	
	public int myMenu() {//권한별 메뉴이동
	try{
		if(((BigDecimal) MainService.login.get("AUTH")).intValue()==1){
			albaMenu();
		}
		else if(((BigDecimal) MainService.login.get("AUTH")).intValue()==2){
			comMenu();
		}
		else if(((BigDecimal) MainService.login.get("AUTH")).intValue()==3){
			System.out.println("관리자는 확인할 수 없습니다.");
		}
	}catch (NullPointerException a) {
		
		}
	
	return View.MAIN;
	}

	

	public void albaMenu() {// 알바메뉴
		System.out.println("===========================================");
		System.out.println("1.내 정보 보기\t 2.내가 쓴 이력서 보기\t 3.마이메뉴");
		int input = ScanUtil.nextInt();
		switch (input) {
		case 1:
			albadata();
			break;
		case 2:
			albaresume();
			break;
		case 3:
			break;
		default:
			System.out.println("다시 입력해주세요");
			break;
		}

	}
	
	
	public void albaresume() {
		Map<String, Object> param = new HashMap<>();
		param.put("ALBA_ID", MainService.login.get("ALBA_ID"));
		Map<String, Object> resume = albaMenuDao.selectResume(param);
		if (resume == null) {
			insertresume();
		}

		String[] resumeKey = {"RESUME_NO","ALBA_ID","ALBA_NAME","ALBA_SEXDSTN",
						      "ALBA_BIR","ALBA_MAIL","ALBA_ADD","ALBA_TEL",
						      "RESUME_EDU1","RESUME_EDU2","RESUME_CR1", 
						      "RESUME_INTRCN","RESUME_ADD","RESUME_SECTOR","RESUME_TYPE", 
						      "RESUME_DATE","RESUME_TIME","RESUME_OPENTERM","RESUME_DAY"};
		String[] resumeKeyname = {"이력서번호","ID","이름","성별",
			      "생년월일","메일","주소","연락처",
			      "학력사항1","학력사항2","경력사항", 
			      "자기소개서","희망근무지","희망업종","희망형태", 
			      "희망근무기간","희망근무시간","이력서공개기간","희망근무요일"};
		System.out.println("=====================이력서===================");
		for (int i = 0; i < 3; i++) {
			System.out.println(resumeKeyname[i] + " : \t"
					+ resume.get(resumeKey[i]));
		}
		System.out.println(resumeKeyname[4] + " : \t"
				+ sdf.format(resume.get(resumeKey[4])));
		for (int i = 5; i < resumeKey.length; i++) {
			System.out.println(resumeKeyname[i] + " : \t"
					+ resume.get(resumeKey[i]));
		}
		System.out.println("===========================================");
		careerdata.Career();
		albaData.resumeModify();
	}
	private JDBCUtil jdbc = JDBCUtil.getInstance();
	
	


	private void insertresume() {
		System.out.println("등록된 이력서가 없습니다.");
		System.out.println("1.이력서작성\t 2.뒤로가기");
		int input = ScanUtil.nextInt();
		switch (input) {
		case 1:
			System.out.println("===================이력서 작성==================");
			Map<String, Object> param = new HashMap<>();
			param.put("ALBA_ID", MainService.login.get("ALBA_ID"));
			Map<String, Object> par = new HashMap<>();
			System.out.println("학력사항1을 선택해주세요.");
			par.put("COMMON_TYPE_COD", "T07");
			List<Map<String, Object>> comcod = commonDao.Commoncod(par);
			for (int i = 0; i < comcod.size(); i++) {
				System.out.print(i + 1 + "."
						+ comcod.get(i).get("COMMON_COD_NAME") + "\t");
			}
			System.out.print(">");
			int input1 = ScanUtil.nextInt();
			param.put("RESUME_EDU1",
					comcod.get(input1 - 1).get("COMMON_COD_NAME"));
			//
			System.out.println("학력사항2을 선택해주세요.");
			par.put("COMMON_TYPE_COD", "T08");
			comcod = commonDao.Commoncod(par);
			for (int i = 0; i < comcod.size(); i++) {
				System.out.print(i + 1 + "."
						+ comcod.get(i).get("COMMON_COD_NAME") + "\t");
			}
			System.out.print(">");
			input1 = ScanUtil.nextInt();
			param.put("RESUME_EDU2",
					comcod.get(input1 - 1).get("COMMON_COD_NAME"));
			//
			System.out.println("경력사항을 선택해주세요.");
			System.out.println("1. 경력 \t2. 신입");
			System.out.print(">");
			input1 = ScanUtil.nextInt();
			String input2 = "";
			if (input1 == 1)
				input2 = "경력";
			else
				input2 = "신입";
			param.put("RESUME_CR1", input2);
			//
			System.out.println("자기소개서를 작성해주세요.");
			System.out.print(">");
			input2 = ScanUtil.nextLine();
			param.put("RESUME_INTRCN", input2);
			//
			System.out.println("희망근무지를 선택해주세요.");
			par.put("COMMON_TYPE_COD", "T01");
			comcod = commonDao.Commoncod(par);
			for (int i = 0; i < comcod.size(); i++) {
				System.out.print(i + 1 + "."
						+ comcod.get(i).get("COMMON_COD_NAME") + "\t");
			}
			System.out.print(">");
			input1 = ScanUtil.nextInt();
			param.put("RESUME_ADD",
					comcod.get(input1 - 1).get("COMMON_COD_NAME"));
			//
			//
			System.out.println("희망업종 선택해주세요.");
			par.put("COMMON_TYPE_COD", "T06");
			comcod = commonDao.Commoncod(par);
			for (int i = 0; i < comcod.size(); i++) {
				System.out.print(i + 1 + "."
						+ comcod.get(i).get("COMMON_COD_NAME") + "\t");
			}
			System.out.print(">");
			input1 = ScanUtil.nextInt();
			param.put("RESUME_SECTOR",
					comcod.get(input1 - 1).get("COMMON_COD_NAME"));
			// //
			System.out.println("희망근무형태를 선택해주세요.");
			par.put("COMMON_TYPE_COD", "T05");
			comcod = commonDao.Commoncod(par);
			for (int i = 0; i < comcod.size(); i++) {
				System.out.print(i + 1 + "."
						+ comcod.get(i).get("COMMON_COD_NAME") + "\t");
			}
			System.out.print(">");
			input1 = ScanUtil.nextInt();
			param.put("RESUME_TYPE",
					comcod.get(input1 - 1).get("COMMON_COD_NAME"));
			//
			System.out.println("희망근무기간를 선택해주세요.");
			par.put("COMMON_TYPE_COD", "T04");
			comcod = commonDao.Commoncod(par);
			for (int i = 0; i < comcod.size(); i++) {
				System.out.print(i + 1 + "."
						+ comcod.get(i).get("COMMON_COD_NAME") + "\t");
			}
			System.out.print(">");
			input1 = ScanUtil.nextInt();
			param.put("RESUME_DATE",
					comcod.get(input1 - 1).get("COMMON_COD_NAME"));
			//
			System.out.println("희망근무시간을 선택해주세요.");
			par.put("COMMON_TYPE_COD", "T03");
			comcod = commonDao.Commoncod(par);
			for (int i = 0; i < comcod.size(); i++) {
				System.out.print(i + 1 + "."
						+ comcod.get(i).get("COMMON_COD_NAME") + "\t");
			}
			System.out.print(">");
			input1 = ScanUtil.nextInt();
			param.put("RESUME_TIME",
					comcod.get(input1 - 1).get("COMMON_COD_NAME"));
			//
			System.out.println("이력서공개기간을 입력해주세요.(30/60/90)");
			System.out.print(">");
			input1 = ScanUtil.nextInt();
			param.put("RESUME_OPENTERM", input1);
			//
			System.out.println("희망근무요일을 선택해주세요.");
			par.put("COMMON_TYPE_COD", "T02");
			comcod = commonDao.Commoncod(par);
			for (int i = 0; i < comcod.size(); i++) {
				System.out.print(i + 1 + "."
						+ comcod.get(i).get("COMMON_COD_NAME") + "\t");
			}
			System.out.print(">");
			input1 = ScanUtil.nextInt();
			param.put("RESUME_DAY",
					comcod.get(input1 - 1).get("COMMON_COD_NAME"));

			if (param.get("RESUME_CR1") == "경력") {
				careerdata.Career();
			}

			int result = albaMenuDao.insertResume(param);
			if (0 < result) {
				System.out.println("이력서작성 성공");
			} else {
				System.out.println("이력서작성 실패");
			}
			albaresume();

			break;
		case 2:
			albaMenu();
			break;
		default:
			System.out.println("다시 입력해주세요");
			break;
		}

	}



	public int albadata() {
		String[] keyname = {"ID","PASSWORD","이름","생일","성별","메일","연락처","주소","권한"};
		String[] key = {"ALBA_ID","ALBA_PASSWORD","ALBA_NAME","ALBA_BIR","ALBA_SEXDSTN","ALBA_MAIL","ALBA_TEL","ALBA_ADD","AUTH"};
		System.out.println("====================개인정보===================");
		for (int i = 0; i < 3; i++) {
			System.out.println(keyname[i] + " : "
					+ MainService.login.get(key[i]));
		}
		System.out.println(keyname[3] + " : "
				+ sdf.format(MainService.login.get(key[3])));
		for (int i = 3; i < keyname.length; i++) {
			System.out.println(keyname[i] + " : "
					+ MainService.login.get(key[i]));
		}
		System.out.println("===========================================");
		albaData.Modify();
		return 0;
	}
	
	
	
	
	
	
	public void comMenu() {
		System.out.println("1.내 기업 정보 보기\t 2.내가 쓴 공고 보기\t 3.마이메뉴");

		int input = ScanUtil.nextInt();

		switch (input) {

		case 1:
			comdata();
			break;
		case 2:
			comresume();
			break;
		case 3:
			break;
		default:
			System.out.println("다시 입력해주세요");
			break;
		}

	}



	public int comresume() {
		Map<String, Object> param = new HashMap<>();
		param.put("COM_ID", MainService.login.get("COM_ID"));
		List<Map<String, Object>> list = comMenuDao.selectResume(param);

		String[] hireKey = { "HIRE_TITLE", "COM_NAME", "HIRE_DATE" };

		System.out.println("====================채용공고===================");
		System.out.println("번호\t제목\t\t\t\t작성자\t작성일");
		System.out.println("===========================================");
		for (int i = 0; i < list.size(); i++) {
			System.out.print(1 + i + "\t");
			for (int j = 0; j < hireKey.length - 1; j++) {

				System.out.print(list.get(i).get(hireKey[j]) + "\t");
			}
			System.out.print(sdf.format(list.get(i).get(
					hireKey[hireKey.length - 1]))
					+ "\t");
			System.out.println();
		}
		System.out.println("===========================================");
		System.out.println("1.번호 선택\t 2.뒤로가기");
		int input = ScanUtil.nextInt();

		switch (input) {

		case 1:
			getHire.getHire();
			break;
		case 2:
			comMenu();
			break;
		default:
			System.out.println("다시 입력해주세요");
			break;
		}
		return 0;
	}


	private int comdata() {
		String[] keyname = { "ID", "PASSWORD", "사업자등록번호", "회사명", "이메일", "주소",
				"연락처", "대표자명", "권한" };
		String[] key = { "COM_ID", "COM_PASSWORD", "COM_REGNO", "COM_NAME",
				"COM_MAIL", "COM_ADD", "COM_TEL", "COM_CEO", "AUTH" };
		System.out.println("====================기업정보===================");
		for (int i = 0; i < keyname.length; i++) {
			System.out.println(keyname[i] + " : "
					+ MainService.login.get(key[i]));
		}
		System.out.println("===========================================");
		comData.Modify();
		return 0;

	}
}