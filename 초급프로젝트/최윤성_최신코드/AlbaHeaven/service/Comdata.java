package service;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.AlbaMenuDao;
import dao.ComMenuDao;
import util.ScanUtil;
import util.View;

public class Comdata {
	private Comdata(){}//생성자
	private static Comdata instance;//변수생성
	public static Comdata getInstance(){
		if(instance == null){
			instance = new Comdata();
		}
		return instance;
}
	private ComMenuDao comMenuDao = ComMenuDao.getInstance();
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
	
	public void Modify() {
		System.out.println("===========================================");
		System.out.println("1.수정\t2.탈퇴\t3.뒤로가기\t0.로그아웃");
		System.out.print("입력>");
		int input = ScanUtil.nextInt();
		switch (input) {
		case 1: update();Modify();break;
		case 2: delete();break;
		case 3:break;
		case 0:break;
		default:
			System.out.println("다시 입력해주세요");
			break;
	}
		
	}

	private int delete() {
		System.out.println("=====================탈퇴====================");
		Map<String, Object> comdata = new HashMap<>();
		System.out.println("정말로 탈퇴하시겠습니까");
		System.out.print("1.YES\t2.NO");
		int input = ScanUtil.nextInt();
		switch (input) {
		case 1: 
			int result = comMenuDao.delete();
			if(0<result){
				System.out.println("삭제 성공");
				System.out.println("처음 화면으로 돌아갑니다.");
				MainService.login =null;
				
				return View.HOME;
			}else {
				System.out.println("삭제 실패");
			}
			break;
		case 2: Modify();break;
	
		default:
			System.out.println("다시 입력해주세요");
			break;
	}
		return View.MAIN;
		
	}

	private void update() {
		System.out.println("===================정보 수정===================");
		Map<String, Object> comdata = new HashMap<>();
		String[] keyname = {"ID","PASSWORD","사업자등록번호","회사명","이메일","주소","연락처","대표자명","권한"};
		String[] key = {"COM_ID","COM_PASSWORD","COM_REGNO","COM_NAME","COM_MAIL","COM_ADD","COM_TEL","COM_CEO","AUTH"};
				comdata.put(key[0],MainService.login.get(key[0]));
			for (int i = 1; i < keyname.length-1; i++) {
			System.out.println("1."+keyname[i]+"을 변경하시겠습니까?\t 2.다음");
			int input = ScanUtil.nextInt();
			switch (input) {
			case 1: 
				System.out.println(MainService.login.get(key[i])+"\t<-를 대신할 값을 입력하세요>");
				String input2 = ScanUtil.nextLine();
				comdata.put(key[i],input2);
				break;
			case 2:
				comdata.put(key[i], MainService.login.get(key[i]));
				break;
			default:
				System.out.println("다시 입력해주세요");
			break;
		}
	}
			comdata.put(key[8],MainService.login.get(key[8]));
			int result = comMenuDao.update(comdata);
			if(0<result){//[16.회원가입 여부 확인하고 HOME으로 리턴]
				System.out.println("수정 성공");
			}else {
				System.out.println("수정 실패");
			}
		}

	
	}

