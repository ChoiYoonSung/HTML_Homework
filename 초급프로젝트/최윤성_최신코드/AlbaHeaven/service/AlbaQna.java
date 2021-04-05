package service;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import util.ScanUtil;
import util.View;
import dao.OtherDao;

public class AlbaQna {
	private AlbaQna() {
	}// 생성자

	private static AlbaQna instance;// 변수생성

	public static AlbaQna getInstance() {
		if (instance == null) {
			instance = new AlbaQna();
		}
		return instance;
	}
	
	private OtherDao otherDao = OtherDao.getInstance();

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	Date now = new Date();

	// 알바Q&A 게시글 목록 - 완
	public int qnaAlbaList() {
		List<Map<String, Object>> qnaAlbaList = OtherDao.qnaAlbaList();

		System.out.println("=================개인회원 Q&A=================");
		System.out.println("번호\t제목\t\t작성자\t\t작성일");
		System.out.println("-------------------------------------------");
		for (Map<String, Object> QAALBABOARD : qnaAlbaList) {
			System.out.println(QAALBABOARD.get("QA_AL_NUM") + "\t"
					+ QAALBABOARD.get("QA_AL_TITLE") + "  "
					+ QAALBABOARD.get("AL_COMMNET") + "\t"
					+ QAALBABOARD.get("ALBA_ID") + "\t"
					+ sdf.format(QAALBABOARD.get("QA_AL_DATE")));
		}
		System.out.println("==========================================");
		System.out.println("1.조회\t2.등록\t0.돌아가기");
		System.out.print("입력>");

		int input = ScanUtil.nextInt();
		switch (input) {
		case 1:
			selectAlbaQna();
			break;
		case 2:
			insertAlbaQnaAuth();
			break;
		case 0:
			break;
		default:
			System.out.println("번호를 잘못 입력하셨습니다.");
			break;
		}
		return View.MAIN;
	}

	// 알바Q&A 게시판 권한 - 완
	public int qnaAlba() {
		if (((BigDecimal) MainService.login.get("AUTH")).intValue() == 1) {
			qnaAlbaList();
		} else if (((BigDecimal) MainService.login.get("AUTH")).intValue() == 3) {
			qnaAlbaList();
		} else {
			System.out.println("권한이 없습니다.");
		}
		return View.MAIN;
	}

	// 알바Q&A 게시판 조회 - 완
	private void selectAlbaQna() {
		System.out.println("조회할 게시글의 번호를 입력해주세요>");
		int qnaAlbaNo = ScanUtil.nextInt();
		Map<String, Object> param = new HashMap<>();
		param.put("QA_AL_NUM", qnaAlbaNo);

		List<Map<String, Object>> selectQnaAlba = OtherDao.selectQnaAlba(param);

		System.out.println("=================개인회원 Q&A=================");
		System.out.println("글번호 : " + selectQnaAlba.get(0).get("QA_AL_NUM"));
		System.out.println("작성일 : "
				+ sdf.format(selectQnaAlba.get(0).get("QA_AL_DATE")));
		System.out.println("아이디 : " + selectQnaAlba.get(0).get("ALBA_ID"));
		System.out.println("제목 : " + selectQnaAlba.get(0).get("QA_AL_TITLE"));
		System.out.println("내용 : " + selectQnaAlba.get(0).get("QA_AL_CONTENT"));
		System.out
				.println("---------------------답변---------------------");
		System.out.println("작성일 : " + selectQnaAlba.get(0).get("AL_DATE"));
		System.out.println("작성자 : " + selectQnaAlba.get(0).get("AL_MAN_ID"));
		System.out.println("내   용 : " + selectQnaAlba.get(0).get("AL_CONTENT"));
		System.out.println("============================================");
		System.out.println("1.게시글 수정\t2.게시글 삭제\t0.돌아가기");
		System.out.println("3.댓글 등록\t4.댓글 수정\t5.댓글 삭제");
		System.out.print("입력>");
		int input = ScanUtil.nextInt();
		switch (input) {
		case 1:
			updateAlbaQnaAtuh(qnaAlbaNo);
			break;
		case 2:
			deleteAlbaQnaatuh(qnaAlbaNo);
			break;
		case 3:
			insertAlbaQnaCommatuh(qnaAlbaNo);
			break;
		case 4:
			UpdateAlbaQnaCommatuh(qnaAlbaNo);
			break;
		case 5:
			deleteAlbaQnaCommatuh(qnaAlbaNo);
			break;
		case 0:
			break;
		default:
			System.out.println("잘못된 입력입니다.");
			selectAlbaQna();
			break;
		}
	}

	// 알바Q&A 게시판 수정권한 - 완
	public int updateAlbaQnaAtuh(int qnaAlbaNo) {
		Map<String, Object> param = new HashMap<>();

		param.put("QA_AL_NUM", qnaAlbaNo);
		List<Map<String, Object>> selectQnaAlba = OtherDao.selectQnaAlba(param);

		if (((BigDecimal) MainService.login.get("AUTH")).intValue() == 1) {
			if ((MainService.login.get("ALBA_ID")).equals(selectQnaAlba.get(0)
					.get("ALBA_ID"))) {
				System.out.println("권한이 있습니다.");
				updateAlbaQna(qnaAlbaNo);
			} else {
				System.out.println("권한이 없습니다.");
				qnaAlbaList();
			}
		}
		if (((BigDecimal) MainService.login.get("AUTH")).intValue() == 3) {
			System.out.println("권한이 없습니다.");
			qnaAlbaList();
		}
		return View.MAIN;
	}

	// 알바Q&A 게시판 수정 - 완
	private void updateAlbaQna(int qnaAlbaNo) {
		System.out.println("수정할 제목>");
		String title = ScanUtil.nextLine();
		System.out.println("수정할 내용>");
		String content = ScanUtil.nextLine();

		Map<String, Object> param = new HashMap<>();
		param.put("QA_AL_NUM", qnaAlbaNo);
		param.put("QA_AL_TITLE", title);
		param.put("QA_AL_CONTENT", content);

		int result = OtherDao.updateQnaAlba(param);

		if (0 < result) {
			System.out.println("Q&A게시글이 수정 되었습니다.");
		} else {
			System.out.println("Q&A게시글이 수정을 실패하였습니다.");
		}
	}

	// 알바Q&A 게시판 삭제권한 - 완
	public int deleteAlbaQnaatuh(int qnaAlbaNo) {
		Map<String, Object> param = new HashMap<>();

		param.put("QA_AL_NUM", qnaAlbaNo);
		List<Map<String, Object>> selectQnaAlba = OtherDao.selectQnaAlba(param);

		if (((BigDecimal) MainService.login.get("AUTH")).intValue() == 1) {
			if ((MainService.login.get("ALBA_ID")).equals(selectQnaAlba.get(0)
					.get("ALBA_ID"))) {
				System.out.println("권한이 있습니다.");
				deleteAlbaQna(qnaAlbaNo);
			}
		} else if (((BigDecimal) MainService.login.get("AUTH")).intValue() == 3) {
			System.out.println("권한이 있습니다.");
			deleteAlbaQna(qnaAlbaNo);
		} else {
			System.out.println("권한이 없습니다.");
			qnaAlbaList();
		}
		return View.MAIN;
	}

	// 알바Q&A 게시판 삭제 - 완
	private void deleteAlbaQna(int qnaAlbaNo) {
		System.out.println("현재 게시글을 삭제하시겠습니까? y or n");
		System.out.println("입력 >");
		String input = ScanUtil.nextLine();

		switch (input) {
		case "Y":
		case "y":
			Map<String, Object> param = new HashMap<>();
			param.put("QA_AL_NUM", qnaAlbaNo);
			int result = OtherDao.deleteqnaAlba(param);
			if (0 < result) {
				System.out.println("삭제를 완료하였습니다.");
			} else
				System.out.println("삭제를 실패하였습니다.");
			break;
		case "N":
		case "n":
			System.out.println("삭제를 취소하였습니다.");
			selectAlbaQna();
			break;
		default:
			System.out.println("잘못된 입력입니다.");
			System.out.println("이전메뉴로 돌아갑니다.");
			selectAlbaQna();
			break;
		}
	}

	// 알바 Q&A 게시판 등록 권한 - 완
	public int insertAlbaQnaAuth() {
		if (((BigDecimal) MainService.login.get("AUTH")).intValue() == 1) {
			System.out.println("권한이 있습니다.");
			insertAlbaQna();
		} else if (((BigDecimal) MainService.login.get("AUTH")).intValue() == 2) {
			System.out.println("권한이 없습니다.");
			qnaAlbaList();
		} else {
			System.out.println("권한이 없습니다.");
			qnaAlbaList();
		}
		return View.MAIN;
	}

	
	// 알바Q&A 게시글 등록 - 완
	private int insertAlbaQna() {
		System.out.print("제목>");
		String qnaTitle = ScanUtil.nextLine();
		System.out.print("내용>");
		String qnaContent = ScanUtil.nextLine();

		Map<String, Object> param = new HashMap<>();
		param.put("QA_AL_TITLE", qnaTitle);
		param.put("QA_AL_CONTENT", qnaContent);
		param.put("QA_AL_DATE", sdf.format(now));
		param.put("AL_MAN_CONTENT", null);
		param.put("AL_MAN_DATE", null);
		param.put("ALBA_ID", MainService.login.get("ALBA_ID"));
		param.put("MAN_ID", null);

		int result = OtherDao.insertAlbaQna(param);

		if (0 < result) {
			System.out.println("등록하였습니다.");
		} else {
			System.out.println("등록에 실패하였습니다.");
		}
		return qnaAlbaList();
	}

	
	// 알바 Q&A 댓글 등록 권한 - 완
	private int insertAlbaQnaCommatuh(int qnaAlbaNo) {
		Map<String, Object> param = new HashMap<>();
		param.put("QA_AL_NUM", qnaAlbaNo);
		List<Map<String, Object>> selectQnaAlba = OtherDao.selectQnaAlba(param);

		if (((BigDecimal) MainService.login.get("AUTH")).intValue() == 3) {
			if ((selectQnaAlba.get(0).get("AL_MAN_ID")).equals("X")) {
				System.out.println("댓글 등록이 가능합니다.");
				updateAlbaQnaComm(qnaAlbaNo);
			} else {
				System.out.println("댓글은 하나만 작성할 수 있습니다.");
				qnaAlbaList();
			}
		}
		if (((BigDecimal) MainService.login.get("AUTH")).intValue() == 1) {
			System.out.println("권한이 없습니다.");
		}
		return View.MAIN;
	}
	
	// 알바Q&A 댓글 수정권한 - 완
	private int UpdateAlbaQnaCommatuh(int qnaAlbaNo) {
		Map<String, Object> param = new HashMap<>();
		param.put("QA_AL_NUM", qnaAlbaNo);
		List<Map<String, Object>> selectQnaAlba = OtherDao.selectQnaAlba(param);

		if (((BigDecimal) MainService.login.get("AUTH")).intValue() == 3) {
			if ((selectQnaAlba.get(0).get("AL_MAN_ID")).equals("X")) {
				System.out.println("댓글 수정 불가능. 댓글을 먼저 등록해주세요.");
				qnaAlbaList();
			} else {
				System.out.println("댓글 수정이 가능합니다.");
				updateAlbaQnaComm(qnaAlbaNo);
			}
		}
		if (((BigDecimal) MainService.login.get("AUTH")).intValue() == 1) {
			System.out.println("권한이 없습니다.");
		}
		return View.MAIN;
	}

	// 알바Q&A 댓글 수정 - 완
	private int updateAlbaQnaComm(int qnaAlbaNo) {
		System.out.println("댓글 내용>");
		String comment = ScanUtil.nextLine();

		Map<String, Object> param = new HashMap<>();

		param.put("QA_AL_NUM", qnaAlbaNo);
		param.put("MAN_ID", MainService.login.get("MAN_ID"));
		param.put("AL_MAN_DATE", sdf.format(now));
		param.put("AL_MAN_CONTENT", comment);

		int result = OtherDao.updateQnaAlbaComm(param);

		if (0 < result) {
			System.out.println("작성 되었습니다.");
		} else {
			System.out.println("작성이 실패하였습니다.");
		}
		return View.MAIN;
	}

	//알바Q&A 댓글삭제 권한 - 완
	private int deleteAlbaQnaCommatuh(int qnaAlbaNo) {
		Map<String, Object> param = new HashMap<>();
		param.put("QA_AL_NUM", qnaAlbaNo);
		List<Map<String, Object>> selectQnaAlba = OtherDao.selectQnaAlba(param);

		if (((BigDecimal) MainService.login.get("AUTH")).intValue() == 3) {
			if ((selectQnaAlba.get(0).get("AL_MAN_ID")).equals("X")) {
				System.out.println("댓글 삭제 불가능. 댓글을 먼저 등록해주세요.");
				qnaAlbaList();
			} else {
				System.out.println("댓글 삭제가 가능합니다.");
				deleteAlbaQnaComm(qnaAlbaNo);
			}
		}
		if (((BigDecimal) MainService.login.get("AUTH")).intValue() == 1) {
			System.out.println("권한이 없습니다.");
		}
		return View.MAIN;
	}
	
	//알바Q&A 댓글삭제  - 완
	private void deleteAlbaQnaComm(int qnaAlbaNo) {
		System.out.println("현재 게시글을 삭제하시겠습니까? y or n");
		System.out.println("입력 >");
		String input = ScanUtil.nextLine();

		switch (input) {
		case "Y":
		case "y":
			Map<String, Object> param = new HashMap<>();		
			param.put("QA_AL_NUM", qnaAlbaNo);
			param.put("MAN_ID", null);
			param.put("AL_MAN_DATE", null);
			param.put("AL_MAN_CONTENT",null);
			int result = OtherDao.updateQnaAlbaComm(param);			
			if (0 < result) {
				System.out.println("삭제를 완료하였습니다.");
			} else
				System.out.println("삭제를 실패하였습니다.");
			break;
		case "N":
		case "n":
			System.out.println("삭제를 취소하였습니다.");
			selectAlbaQna();
			break;
		default:
			System.out.println("잘못된 입력입니다.");
			System.out.println("이전메뉴로 돌아갑니다.");
			selectAlbaQna();
			break;
		}
}
	
	
	
	
}
