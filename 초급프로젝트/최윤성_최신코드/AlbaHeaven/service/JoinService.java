package service;

import java.util.HashMap;
import java.util.Map;

import util.ScanUtil;
import util.View;
import dao.UserDao;

public class JoinService {
	private JoinService(){}//생성자
	private static JoinService instance;//변수생성
	public static JoinService getInstance(){
		if(instance == null){
			instance = new JoinService();
		}
		return instance;
	}
	
	private UserDao userDao = UserDao.getInstance();
	
	
	public int join() {
		System.out.println("====================회원가입===================");
		System.out.println("회원가입을 환영합니다");
		System.out.println("1.개인회원가입\t 2.기업회원가입");
		System.out.println("번호를 입력해주세요>");
		int input =ScanUtil.nextInt();
		
		switch(input){
		case 1: joinalba(); 
			break;
		case 2: joincompany();
			break;
		default:
			System.out.println("다시 입력해주세요");
			break;
		}
		return View.HOME; 
	}
	
	private void joinalba() {
		System.out.println("개인회원 가입을 선택하셨습니다.");
		System.out.println("상세정보 입력해주세요.");
		System.out.print("아이디>");
		String albaId = ScanUtil.nextLine();
		System.out.print("비밀번호>");
		String albaPassword = ScanUtil.nextLine();
		System.out.print("생년월일>...ex)2021-02-20");
		String albaBir = ScanUtil.nextLine();
		System.out.print("이름>");
		String albaName = ScanUtil.nextLine();
		String albSex ="";
		System.out.print("성별> 남자 : 0 , 여자 : 1");
		int albSexdstn = ScanUtil.nextInt();
		if(albSexdstn==0){
			 albSex ="남";
		}
		else{albSex ="여";}
		System.out.print("이메일>");
		String albaMail = ScanUtil.nextLine();
		System.out.print("연락처>");
		String albaTel = ScanUtil.nextLine();
		System.out.print("주소>");
		String albaAdd = ScanUtil.nextLine();
		
		Map<String, Object> param = new HashMap<>();//[11.HashMap에 저장]
		param.put("ALBA_ID", albaId);
		param.put("ALBA_PASSWORD", albaPassword);
		param.put("ALBA_BIR", albaBir);
		param.put("ALBA_NAME", albaName);
		param.put("ALBA_SEXDSTN", albSex);
		param.put("ALBA_MAIL", albaMail);
		param.put("ALBA_TEL", albaTel);
		param.put("ALBA_ADD", albaAdd);
		param.put("AUTH", 1);
		
		int result = userDao.insertUser(param);
		
		if(0<result){
			System.out.println("회원가입 성공");
		}else {
			System.out.println("회원가입 실패");
		}
	}
	private void joincompany() {
		System.out.println("기업 가입을 선택하셨습니다.");
		System.out.println("상세정보 입력해주세요.");
		System.out.print("아이디>");
		String comId = ScanUtil.nextLine();
		System.out.print("비밀번호>");
		String comPassword = ScanUtil.nextLine();
		System.out.print("사업자등록번호>...ex)1234567891(10자리)");
		int comRegNo = ScanUtil.nextInt();
		System.out.print("회사명>");
		String comName = ScanUtil.nextLine();
		System.out.print("이메일>");
		String comMail = ScanUtil.nextLine();
		System.out.print("주소>");
		String comAdd = ScanUtil.nextLine();
		System.out.print("<전화번호>");
		String comTel = ScanUtil.nextLine();
		System.out.print("<대표자명>");
		String comCeo = ScanUtil.nextLine();
				
		Map<String, Object> param = new HashMap<>();//[11.HashMap에 저장]
		param.put("COM_ID", comId);
		param.put("COM_PASSWORD", comPassword);
		param.put("COM_REGNO", comRegNo);
		param.put("COM_NAME", comName);
		param.put("COM_MAIL", comMail);
		param.put("COM_ADD", comAdd);
		param.put("COM_TEL", comTel);
		param.put("COM_CEO", comCeo);
		param.put("AUTH", 2); //권한 2번 : 기업
				
		int result = userDao.insertCom(param);
		
		if(0<result){
			System.out.println("회원가입 성공");
		}else {
			System.out.println("회원가입 실패");
		}
		
	}
}
