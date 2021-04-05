package service;

import java.util.Map;

import dao.UserDao;
import util.ScanUtil;
import util.View;

public class LoginService {
	private LoginService(){}
	private static LoginService instance;
	public static LoginService getInstance(){
		if(instance == null){
			instance = new LoginService();
		}
		return instance;
}
	private UserDao userDao = UserDao.getInstance();
	
	public int login() {
		System.out.println("====================로그인====================");
		System.out.println("1.개인회원 \t 2.기업회원 \t 3.관리자 \t 0.뒤로가기");
		System.out.println("번호를 입력해주세요>");
		int input =ScanUtil.nextInt();
		
		switch(input){
		case 1: loginalba(); 
			return View.MAIN;
		case 2: logincompany();
			return View.MAIN;
		case 3: loginmanager();
			return View.MAIN;
		case 0: break;
		default:
			System.out.println("다시 입력해주세요");
			login();
			break;
		}
		return View.HOME;
	}
	
	public int loginalba() {
		System.out.print("아이디>");
		String albaId = ScanUtil.nextLine();
		System.out.print("비밀번호>");
		String password = ScanUtil.nextLine();
		
		Map<String, Object> user = userDao.selectUser(albaId, password);
		
		if(user == null){
			System.out.println("아이디 혹은 비밀번호를 잘못 입력하셨습니다.");
		}else{
			System.out.println("로그인 성공");
			MainService.login = user;
			System.out.println(MainService.login.get("ALBA_NAME")+"님(개인) 어서오세요");
			return View.MAIN;
			}		
		return login();
	}

	public int logincompany () {
		System.out.print("아이디>");
		String comId = ScanUtil.nextLine();
		System.out.print("비밀번호>");
		String password = ScanUtil.nextLine();
		
		Map<String, Object> user = userDao.selectCom(comId, password);
		
		if(user == null){
			System.out.println("아이디 혹은 비밀번호를 잘못 입력하셨습니다.");
		}else{
			System.out.println("로그인 성공");
			MainService.login = user;
			System.out.println(MainService.login.get("COM_NAME")+"님(기업) 어서오세요");
			return View.MAIN;
		
		}
		return login();
	}
	
	public int loginmanager() {
		System.out.print("아이디>");
		String manId = ScanUtil.nextLine();
		System.out.print("비밀번호>");
		String password = ScanUtil.nextLine();

		Map<String, Object> user = userDao.selectMan(manId, password);

		if (user == null) {
			System.out.println("아이디 혹은 비밀번호를 잘못 입력하셨습니다.");
		} else {
			System.out.println("로그인 성공");
			MainService.login = user;
			System.out.println(MainService.login.get("MAN_NAME")+"님 어서오세요");
			return View.MAIN;
		}
		return login();
	}
	
}