package service;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import util.ScanUtil;
import util.View;
import dao.OtherDao;

public class ComQna {
	private ComQna() {
	}// 생성자

	private static ComQna instance;// 변수생성

	public static ComQna getInstance() {
		if (instance == null) {
			instance = new ComQna();
		}
		return instance;
	}

	private OtherDao otherDao = OtherDao.getInstance();

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	Date now = new Date();

	// 기업Q&A 게시판 목록 - 완
	public int qnaComList() {
		List<Map<String, Object>> qnaComList = OtherDao.qnaComList();
		System.out.println("================== 기업회원 Q & A =================");
		System.out.println("번호\t제목\t\t작성자\t\t작성일");
		System.out.println("-------------------------------------------------");
		for (Map<String, Object> QACOMBOARD : qnaComList) {
			System.out.println(QACOMBOARD.get("QA_COM_NUM") + "\t"
					+ QACOMBOARD.get("QA_COM_TITLE") + "\t"
					+ QACOMBOARD.get("COM_COMMNET") + "\t"
					+ QACOMBOARD.get("QA_COM_ID") + "\t"
					+ sdf.format(QACOMBOARD.get("QA_COM_DATE")));
		}
		System.out.println("=================================================");
		System.out.println("1.조회\t2.등록\t0.돌아가기");
		System.out.print("입력>");

		int input = ScanUtil.nextInt();
		switch (input) {
		case 1:
			selectComQna();
			break;
		case 2:
			insertComQnaAuth();
			break;
		case 0:
			break;
		default:
			System.out.println("잘못 입력하셨습니다.");
			break;
		}
		return View.MAIN;
	}

	// 기업Q&A 게시판 권한 - 완
	public int qnaCom() {
		if (((BigDecimal) MainService.login.get("AUTH")).intValue() == 2) {
			qnaComList();
		} else if (((BigDecimal) MainService.login.get("AUTH")).intValue() == 3) {
			qnaComList();
		} else {
			System.out.println("권한이 없습니다.");
		}
		return View.MAIN;
	}

	// 기업Q&A 게시판 조회 - 완
	private void selectComQna() {
		System.out.println("조회할 게시글의 번호를 입력해주세요>");
		int qnaComNo = ScanUtil.nextInt();
		Map<String, Object> param = new HashMap<>();
		param.put("QA_COM_NUM", qnaComNo);

		List<Map<String, Object>> selectQnaCom = OtherDao.selectQnaCom(param);

		System.out.println("===================기업회원 Q&A===================");
		System.out.println("글번호 : " + selectQnaCom.get(0).get("QA_COM_NUM"));
		System.out.println("작성일 : "
				+ sdf.format(selectQnaCom.get(0).get("QA_COM_DATE")));
		System.out.println("아이디 : " + selectQnaCom.get(0).get("QA_COM_ID"));
		System.out.println("제목 : " + selectQnaCom.get(0).get("QA_COM_TITLE"));
		System.out.println("내용 : " + selectQnaCom.get(0).get("QA_COM_CONTENT"));
		System.out.println("=====================경력======================");
		System.out.println("작성일 : " + selectQnaCom.get(0).get("COM_DATE"));
		System.out.println("작성자 : " + selectQnaCom.get(0).get("COM_MAN_ID"));
		System.out.println("내용 : " + selectQnaCom.get(0).get("COM_CONTENT"));
		System.out
				.println("================================================");
		System.out.println("1.게시글 수정\t2.게시글 삭제\t0.돌아가기");
		System.out.println("3.댓글 등록\t4.댓글수정\t5.댓글삭제");
		System.out.print("입력>");
		int input = ScanUtil.nextInt();
		switch (input) {
		case 1:
			updateComQnaAtuh(qnaComNo);
			break;
		case 2:
			deleteComQnaAuth(qnaComNo);
			break;
		case 3:
			insertComQnaCommatuh(qnaComNo);
			break;
		case 4:
			UpdateComQnaCommatuh(qnaComNo);
			break;
		case 5:
			deleteComQnaCommatuh(qnaComNo);
			break;
		case 0:
			break;
		default:
			System.out.println("잘못된 입력입니다.");
			selectComQna();
			break;
		}
	}

	// 기업Q&A 게시판 수정권한 - 완
	public int updateComQnaAtuh(int qnaComNo) {
		Map<String, Object> param = new HashMap<>();

		param.put("QA_COM_NUM", qnaComNo);
		List<Map<String, Object>> selectQnaCom = OtherDao.selectQnaCom(param);

		if (((BigDecimal) MainService.login.get("AUTH")).intValue() == 2) {
			if ((MainService.login.get("COM_ID")).equals(selectQnaCom.get(0)
					.get("QA_COM_ID"))) {
				System.out.println("권한이 있습니다.");
				updateComQna(qnaComNo);
			} else {
				System.out.println("권한이 없습니다.");
				qnaComList();
			}
		}
		if (((BigDecimal) MainService.login.get("AUTH")).intValue() == 3) {
			System.out.println("권한이 없습니다.");
			qnaComList();
		}
		return View.MAIN;
	}

	// 기업Q&A 게시글 수정 - 완
	private void updateComQna(int qnaComNo) {
		System.out.println("===================게시글 수정===================");
		System.out.println("수정할 제목>");
		String title = ScanUtil.nextLine();
		System.out.println("수정할 내용>");
		String content = ScanUtil.nextLine();

		Map<String, Object> param = new HashMap<>();
		param.put("QA_COM_NUM", qnaComNo);
		param.put("QA_COM_TITLE", title);
		param.put("QA_COM_CONTENT", content);

		int result = OtherDao.updateQnaCom(param);

		if (0 < result) {
			System.out.println("Q&A게시글이 수정 되었습니다.");
		} else {
			System.out.println("Q&A게시글이 수정을 실패하였습니다.");
		}
	}

	// 기업Q&A 게시판 삭제권한 - 완
	public int deleteComQnaAuth(int qnaComNo) {
		Map<String, Object> param = new HashMap<>();

		param.put("QA_COM_NUM", qnaComNo);
		List<Map<String, Object>> selectQnaCom = OtherDao.selectQnaCom(param);

		if (((BigDecimal) MainService.login.get("AUTH")).intValue() == 2) {
			if ((MainService.login.get("COM_ID")).equals(selectQnaCom.get(0)
					.get("QA_COM_ID"))) {
				System.out.println("권한이 있습니다.");
				deleteComQna(qnaComNo);
			}else{
				System.out.println("권한이 없습니다.");
				qnaComList();
			}
		} else if (((BigDecimal) MainService.login.get("AUTH")).intValue() == 3) {
			System.out.println("권한이 있습니다.");
			deleteComQna(qnaComNo);
		} else {
			System.out.println("권한이 없습니다.");
			qnaComList();
		}
		return View.MAIN;
	}

	// 기업Q&A 게시판 삭제 - 완
	private void deleteComQna(int qnaComNo) {
		System.out.println("===================게시글 삭제===================");
		System.out.println("현재 게시글을 삭제하시겠습니까? y or n");
		System.out.println("입력 >");
		String input = ScanUtil.nextLine();

		switch (input) {
		case "Y":
		case "y":
			Map<String, Object> param = new HashMap<>();
			param.put("QA_COM_NUM", qnaComNo);
			int result = OtherDao.deleteqnaCom(param);
			if (0 < result) {
				System.out.println("삭제를 완료하였습니다.");
			} else
				System.out.println("삭제를 실패하였습니다.");
			break;
		case "N":
		case "n":
			System.out.println("삭제를 취소하였습니다.");
			selectComQna();
			break;
		default:
			System.out.println("잘못된 입력입니다.");
			System.out.println("이전메뉴로 돌아갑니다.");
			selectComQna();
			break;
		}
	}

	// 기업 Q&A 게시판 등록 권한 - 완
	public int insertComQnaAuth() {
		if (((BigDecimal) MainService.login.get("AUTH")).intValue() == 2) {
			System.out.println("권한이 있습니다.");
			insertComQna();
		} else if (((BigDecimal) MainService.login.get("AUTH")).intValue() == 3) {
			System.out.println("권한이 없습니다.");
			qnaComList();
		} else {
			System.out.println("권한이 없습니다.");
			qnaComList();
		}
		return View.MAIN;
	}

	// 기업Q&A 게시글 등록 - 완
	private int insertComQna() {
		System.out.println("===================게시글 등록===================");
		System.out.print("제목>");
		String qnaTitle = ScanUtil.nextLine();
		System.out.print("내용>");
		String qnaContent = ScanUtil.nextLine();

		Map<String, Object> param = new HashMap<>();
		param.put("QA_COM_TITLE", qnaTitle);
		param.put("QA_COM_CONTENT", qnaContent);
		param.put("QA_COM_DATE", sdf.format(now));
		param.put("COM_MAN_CONTENT", null);
		param.put("COM_MAN_DATE", null);
		param.put("QA_COM_ID", MainService.login.get("COM_ID"));
		param.put("COM_ID", null);

		int result = OtherDao.insertComQna(param);

		if (0 < result) {
			System.out.println("등록하였습니다.");
		} else {
			System.out.println("등록에 실패하였습니다.");
		}
		return qnaComList();
	}

	// 기업 Q&A 댓글 등록 권한 - 완
	private int insertComQnaCommatuh(int qnaComNo) {
		Map<String, Object> param = new HashMap<>();
		param.put("QA_COM_NUM", qnaComNo);
		List<Map<String, Object>> selectQnaCom = OtherDao.selectQnaCom(param);

		if (((BigDecimal) MainService.login.get("AUTH")).intValue() == 3) {
			if ((selectQnaCom.get(0).get("COM_MAN_ID")).equals("X")) {
				System.out.println("댓글 등록이 가능합니다.");
				updateComQnaComm(qnaComNo);
			} else {
				System.out.println("댓글은 하나만 작성할 수 있습니다.");
				qnaComList();
			}
		}
		if (((BigDecimal) MainService.login.get("AUTH")).intValue() == 2) {
			System.out.println("권한이 없습니다.");
		}
		return View.MAIN;
	}

	// 기업Q&A 댓글 수정권한 - 완
	private int UpdateComQnaCommatuh(int qnaComNo) {
		Map<String, Object> param = new HashMap<>();
		param.put("QA_COM_NUM", qnaComNo);
		List<Map<String, Object>> selectQnaCom = OtherDao.selectQnaCom(param);

		if (((BigDecimal) MainService.login.get("AUTH")).intValue() == 3) {
			if ((selectQnaCom.get(0).get("COM_MAN_ID")).equals("X")) {
				System.out.println("댓글 수정 불가능. 댓글을 먼저 등록해주세요.");
				qnaComList();
			} else {
				System.out.println("댓글 수정이 가능합니다.");
				updateComQnaComm(qnaComNo);
			}
		}
		if (((BigDecimal) MainService.login.get("AUTH")).intValue() == 2) {
			System.out.println("권한이 없습니다.");
		}
		return View.MAIN;
	}

	// 기업Q&A 댓글 수정 - 완
	private int updateComQnaComm(int qnaComNo) {
		System.out.println("===================댓글 수정===================");
		System.out.println("댓글 내용>");
		String comment = ScanUtil.nextLine();

		Map<String, Object> param = new HashMap<>();

		param.put("QA_COM_NUM", qnaComNo);
		param.put("MAN_ID", MainService.login.get("MAN_ID"));
		param.put("COM_MAN_DATE", sdf.format(now));
		param.put("COM_MAN_CONTENT", comment);

		int result = OtherDao.updateQnaComComm(param);

		if (0 < result) {
			System.out.println("작성 되었습니다.");
		} else {
			System.out.println("작성이 실패하였습니다.");
		}
		return View.MAIN;
	}

	// 기업Q&A 댓글삭제 권한 - 완
	private int deleteComQnaCommatuh(int qnaComNo) {

		Map<String, Object> param = new HashMap<>();
		param.put("QA_COM_NUM", qnaComNo);
		List<Map<String, Object>> selectQnaCom = OtherDao.selectQnaCom(param);

		if (((BigDecimal) MainService.login.get("AUTH")).intValue() == 3) {
			if ((selectQnaCom.get(0).get("COM_MAN_ID")).equals("X")) {
				System.out.println("댓글 삭제 불가능. 댓글을 먼저 등록해주세요.");
				qnaComList();
			} else {
				System.out.println("댓글 삭제가 가능합니다.");
				deleteComQnaComm(qnaComNo);
			}
		}
		if (((BigDecimal) MainService.login.get("AUTH")).intValue() == 2) {
			System.out.println("권한이 없습니다.");
		}
		return View.MAIN;
	}

	// 기업Q&A 댓글삭제 - 완
	private void deleteComQnaComm(int qnaComNo) {
		System.out.println("===================댓글 삭제===================");
		System.out.println("현재 댓글을 삭제하시겠습니까? y or n");
		System.out.println("입력 >");
		String input = ScanUtil.nextLine();

		switch (input) {
		case "Y":
		case "y":
			Map<String, Object> param = new HashMap<>();
			param.put("QA_COM_NUM", qnaComNo);
			param.put("MAN_ID", null);
			param.put("AL_MAN_DATE", null);
			param.put("AL_MAN_CONTENT", null);
			int result = OtherDao.updateQnaComComm(param);
			if (0 < result) {
				System.out.println("삭제를 완료하였습니다.");
			} else
				System.out.println("삭제를 실패하였습니다.");
			break;
		case "N":
		case "n":
			System.out.println("삭제를 취소하였습니다.");
			selectComQna();
			break;
		default:
			System.out.println("잘못된 입력입니다.");
			System.out.println("이전메뉴로 돌아갑니다.");
			selectComQna();
			break;
		}
	}

}