package service;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.ComMenuDao;
import util.ScanUtil;

public class GetHire {
	private GetHire(){}//생성자
	private static GetHire instance;//변수생성
	public static GetHire getInstance(){
		if(instance == null){
			instance = new GetHire();
		}
		return instance;
	}
	private ComMenuDao comMenuDao = ComMenuDao.getInstance();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");

	public void getHire() {
		System.out.println("번호선택>");
		int input = ScanUtil.nextInt();
		Map<String, Object> param = new HashMap<>();
		Map<String, Object> param1 = new HashMap<>();

		param.put("COM_ID", MainService.login.get("COM_ID"));
		List<Map<String, Object>> list = comMenuDao.selectResume(param);
		
		String[] hireKey = {"HIRE_NO","HIRE_TITLE","COM_NAME","COM_REGNO","COM_MAIL","COM_ADD","COM_TEL","COM_CEO", 
			      "HIRE_AGE","HIRE_ADD","HIRE_SECTOR","HIRE_DAY","HIRE_TIME", 
			      "HIRE_EMP","HIRE_AL_DATE","HIRE_COST","HIRE_COST_TYPE","HIRE_SEXDTN","HIRE_NUM","HIRE_EDU1", 
			      "HIRE_EDU2","HIRE_DATE"};
		String[] hireKeyname = {"채용공고번호","제목","기업명","사업자등록번호","기업메일","기업주소","기업연락처","대표자명", 
					"채용연령","근무지역","업종","근무요일","근무시간", 
					"고용형태","근무기간","급여","급여형태","우대성별","고용인원","우대학력사항1", 
					"우대학력사항2","구인날짜"};

		System.out.println("====================채용공고===================");
		if (0 < input && input <= list.size()) {
			for (int i = 0; i < hireKey.length - 1; i++) {
				System.out.println(hireKeyname[i] + " : \t\t"
						+ list.get(input - 1).get(hireKey[i]));
			}
			System.out.println(hireKeyname[hireKey.length - 1]
					+ " : \t\t"
					+ sdf.format(list.get(input - 1).get(
							hireKey[hireKey.length - 1])));
			param1.put("HIRE_NO", list.get(input - 1).get("HIRE_NO"));
			List<Map<String, Object>> list2 = comMenuDao.selectHR(param1);
			System.out.println("===========================================");
			System.out.println("번호 \t\t[내용]");
			System.out.println("=================면접을 신청한 회원===============");
			for (int i = 0; i < list2.size(); i++) {
				System.out.println(i + 1 + " \t" + list2.get(i).get("HR_LIKE"));
			}
			System.out.println("===========================================");
		} else {
			System.out.println("해당하는 번호가 없습니다");
			getHire();
		}

		System.out.println("1.채용공고수정\t 2.삭제 \t 3.뒤로가기");
		input = ScanUtil.nextInt();
		switch (input) {
		 case 1: break;
		 case 2: break;
		 case 3: break;
		 default:
			System.out.println("다시 입력해주세요");
			break;
		}

	}

}
