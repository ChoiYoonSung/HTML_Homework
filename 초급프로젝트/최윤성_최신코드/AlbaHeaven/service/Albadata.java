package service;

import java.util.HashMap;
import java.util.Map;







import controller.Controller;
import dao.AlbaMenuDao;
import dao.ResumeDao;
import util.ScanUtil;
import util.View;

public class Albadata {
	private Albadata(){}//생성자
	private static Albadata instance;//변수생성
	public static Albadata getInstance(){
		if(instance == null){
			instance = new Albadata();
		}
		return instance;
}
	private AlbaMenuDao albaMenuDao = AlbaMenuDao.getInstance();
	private ResumeDao resumeDao = ResumeDao.getInstance();
	private Careerdata cd = Careerdata.getInstance();
	
	public int Modify() {
		System.out.println("==========================================");
		System.out.println("1.수정\t2.탈퇴\t3.마이메뉴\t0.로그아웃");
		System.out.print("입력>");
		int input = ScanUtil.nextInt();
		switch (input) {
		case 1:
			update();
			Modify();
			break;
		case 2:
			delete();
			break;
		case 3:
			return View.MYMENU;
		case 0:
			break;
		default:
			System.out.println("다시 입력해주세요");
			break;
		}
		return 0;

	}

	private int delete() {
		System.out.println("====================탈퇴====================");
		Map<String, Object> albadata = new HashMap<>();
		System.out.println("정말로 탈퇴 하시겠습니까");
		System.out.print("1.YES\t2.NO");
		int input = ScanUtil.nextInt();
		switch (input) {
		case 1:
			int result = albaMenuDao.delete();
			if (0 < result) {
				System.out.println("삭제 성공");
				System.out.println("처음 화면으로 돌아갑니다.");
				return View.HOME;
			} else {
				System.out.println("삭제 실패");
			}
			break;
		case 2:
			Modify();
			break;

		default:
			System.out.println("다시 입력해주세요");
			break;
		}
		return View.MAIN;
	}

	
	private void update() {
		System.out.println("====================수정====================");
		Map<String, Object> albadata = new HashMap<>();
		String[] keyname = {"ID","PASSWORD","이름","생일","성별","메일","연락처","주소","권한"};
		String[] key = {"ALBA_ID","ALBA_PASSWORD","ALBA_NAME","ALBA_BIR","ALBA_SEXDSTN","ALBA_MAIL","ALBA_TEL","ALBA_ADD","AUTH"};
				albadata.put(key[0],MainService.login.get(key[0]));
		for (int i = 1; i < keyname.length - 1; i++) {
			System.out.println("1." + keyname[i] + "을 변경하시겠습니까?\t 2.다음");
			int input = ScanUtil.nextInt();
			switch (input) {
			case 1:
				System.out.println(MainService.login.get(key[i])
						+ "\t<-를 대신할 값을 입력하세요>");
				String input2 = ScanUtil.nextLine();
				albadata.put(key[i], input2);
				break;
			case 2:
				albadata.put(key[i], MainService.login.get(key[i]));
				break;
			default:
				System.out.println("다시 입력해주세요");
				break;
			}
		}
		albadata.put(key[8], MainService.login.get(key[8]));
		int result = albaMenuDao.update(albadata);
		
		
		
		if (0 < result) {
			System.out.println("수정 성공");
		} else {
			System.out.println("수정 실패");
		}
	}

	public int resumeModify() {
		System.out.println("==========================================");
		System.out.println("1.이력서수정\t2.경력 추가 \t3. 경력 삭제 \t4. 메인메뉴");
		System.out.print("입력>");
		int input = ScanUtil.nextInt();
		switch (input) {
		case 1:
			updateResume();
			resumeModify();
			break;
		case 2: 
			cd.insertcareer(); 
			resumeModify(); 
			break;
		case 3: 
			cd.deletecareer(); 
			resumeModify(); 
			break;
		case 4:
			return View.MYMENU;
		default:
			System.out.println("다시 입력해주세요");
			break;
		}
		return 0;

	}

	private int updateResume() {
		System.out.println("==================이력서 수정===================");
		Map<String, Object> param = new HashMap<>();
		param.put("ALBA_ID", MainService.login.get("ALBA_ID"));
		Map<String, Object> resume = albaMenuDao.selectResume(param);
		Map<String, Object> resumedata = new HashMap<>();
		String[] resumeKey = {"RESUME_NO","RESUME_INTRCN",
			      "RESUME_EDU1","RESUME_EDU2","RESUME_CR1", 
			      "RESUME_ADD","RESUME_SECTOR","RESUME_TYPE", 
			      "RESUME_DATE","RESUME_TIME","RESUME_OPENTERM","RESUME_DAY"};
		String[] resumeKeyname = {"이력서번호","자기소개서",
						"학력사항1","학력사항2","경력사항", 
						"희망근무지","희망업종","희망형태", 
						"희망근무기간","희망근무시간","이력서공개기간","희망근무요일"};
		resumedata.put(resumeKey[0], resume.get(resumeKey[0]));
		resumedata.put("ALBA_ID", MainService.login.get("ALBA_ID"));
		for (int i = 1; i < resumeKeyname.length; i++) {
			System.out.println("1." + resumeKeyname[i] + "을 변경하시겠습니까?\t 2.다음");
			int input = ScanUtil.nextInt();
			switch (input) {
			case 1:
				System.out.println(resume.get(resumeKey[i])
						+ "\t<-를 대신할 값을 입력하세요>");
				String input2 = ScanUtil.nextLine();
				resumedata.put(resumeKey[i], input2);
				break;
			case 2:
				resumedata.put(resumeKey[i], resume.get(resumeKey[i]));
				break;
			default:
				System.out.println("다시 입력해주세요");
				break;
			}
		}
		int result = resumeDao.update(resumedata);
		
		if (0 < result) {
			System.out.println("수정 성공");
		} else {
			System.out.println("수정 실패");
		}

		return 0;

	}
}

