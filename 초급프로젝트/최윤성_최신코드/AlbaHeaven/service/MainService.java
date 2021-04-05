package service;

import java.util.Map;

import controller.Controller;
import util.ScanUtil;
import util.View;

public class MainService {
	public static Map<String, Object> login;

	private MainService(){}
	private static MainService instance;
	public static MainService getInstance(){
		if(instance == null){
			instance = new MainService();
		}
		return instance;
	}	
	public static void main(){
		new MainService().service();
	}
	
	private MyMenu mymenu = MyMenu.getInstance();
	private ServiceCenter sc = ServiceCenter.getInstance();
	private ResumeList rl = ResumeList.getInstance();
	private HireList hl = HireList.getInstance();
	private AlbaQna albaQna = AlbaQna.getInstance();
	private ComQna comQna = ComQna.getInstance();
	
	public int service() {
		int view = View.MAIN;
		
		while(true){
			switch(view){
			case View.MAIN: view = serviceList(); break;
			case View.MYMENU: view = mymenu.myMenu(); break;
			case View.RESUMELS: view = rl.resumeLs(); break;
			case View.HIRELS: view = hl.hireLs(); break;
			case View.QNAALBA: view = albaQna.qnaAlba(); break;
			case View.QNACOM: view = comQna.qnaCom(); break;
			case View.GUIDE: view = sc.guide(); break;
			case View.NOTICE: view = sc.notice(); break;
			case View.HOME: view = new Controller().start(); break;
			}
		}
	}
	

	public int serviceList(){
		System.out.println("===========================================");
		System.out.println(" 1. 마이메뉴\t2. 이력서게시판\t3. 채용게시판 ");
		System.out.println(" 4. 개인 Q&A\t5. 기업 Q&A\t6. 이용가이드 ");
		System.out.println(" 7. 공지사항\t8. 로그아웃\t0. 종료 ");
		System.out.println("===========================================");
		System.out.print(">");
		int input = ScanUtil.nextInt();
		
		switch(input){
		case 1:	return View.MYMENU;
		case 2: return View.RESUMELS;
		case 3: return View.HIRELS;
		case 4: return View.QNAALBA;
		case 5: return View.QNACOM;
		case 6: return View.GUIDE;
		case 7: return View.NOTICE;
		case 8: 
			login = null;
			return View.HOME;
		case 0: 
			System.out.println("종료합니다.");
			System.exit(0);
		default :
			System.out.println("잘못 입력하였습니다.");
			break;
		}
		return View.MAIN;
	}
	
}
