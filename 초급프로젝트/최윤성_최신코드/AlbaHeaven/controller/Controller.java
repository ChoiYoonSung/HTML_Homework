package controller;

import service.JoinService;
import service.LoginService;
import service.MainService;
import util.ScanUtil;
import util.View;

public class Controller {

	public static void main(String[] args) {
		new Controller().start();
	}
	
	private JoinService joinService = JoinService.getInstance();
	private LoginService loginService = LoginService.getInstance();
	private MainService mainService = MainService.getInstance();
	
	public int start() {
		int view =View.HOME;
		
		while(true){
			switch(view){
			case View.HOME: view = home(); break;
			case View.LOGIN:view = loginService.login(); break;
			case View.JOIN: view = joinService.join(); break;
			case View.MAIN: view = mainService.service(); break;
			}
		}
	}

	private int home() {
		System.out.println("알바천국에 오신것을 환영합니다.");
		System.out.println("1.로그인 \t 2.회원가입 \t 0.프로그램 종료");
		System.out.println("번호를 입력해주세요.");
		int input =ScanUtil.nextInt();
		
		switch(input){
		case 1: return View.LOGIN;
		case 2: return View.JOIN;
		case 0: 
			System.out.println("이용해주셔서 감사합니다.");
			System.exit(0);
		default:
			System.out.println("다시 입력해주세요");
			break;
		}
		return View.HOME;
	}

}
