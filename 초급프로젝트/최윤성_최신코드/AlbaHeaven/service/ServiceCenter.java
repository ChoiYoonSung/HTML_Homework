package service;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.OtherDao;
import util.ScanUtil;
import util.View;

public class ServiceCenter {

	
	ServiceCenter(){}
	private static ServiceCenter instance;
	public static ServiceCenter getInstance(){
		if(instance == null){
			instance = new ServiceCenter();
		}
		return instance;
	}
	
	private OtherDao otherDao = OtherDao.getInstance();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	Date now = new Date();
	
	//가이드 게시판 목록  - 완
	public int guide() {	
		List<Map<String, Object>> guideList = OtherDao.guideList();		
		System.out.println("===================이용 가이드==================");
		System.out.println("번호\t제목\t작성자");
		System.out.println("--------------------------------------------");
		for (Map<String, Object> GUIDE : guideList) {
			System.out.println(GUIDE.get("GUIDE_NO") + "\t"
					+ GUIDE.get("GUIDE_TITLE") + "\t"
					+ GUIDE.get("MAN_ID"));
		}
		System.out.println("===========================================");
		System.out.println("1.조회\t2.등록\t0.돌아가기");
		System.out.print("입력>");

		int input = ScanUtil.nextInt();
		switch (input) {
		case 1:
			selectGuide();
			break;
		case 2:
			insertGuideAuth();
			break;
		case 0:
			break;
		default:
			System.out.println("잘못 입력하셨습니다.");
			break;
		}
		return View.MAIN;
	}	
	
	// 가이드 게시판 조회  - 완
		private void selectGuide() {
			System.out.println("===================가이드 조회==================");
			System.out.println("조회할 게시글의 번호를 입력해주세요>");
			int guideNo = ScanUtil.nextInt();
			Map<String, Object> param = new HashMap<>();
			param.put("GUIDE_NO", guideNo);

			List<Map<String, Object>> selectGuide = OtherDao.selectGuide(param);

			System.out.println("===================이용가이드==================");
			System.out.println("글번호 : " + selectGuide.get(0).get("GUIDE_NO"));
			System.out.println("아이디 : " + selectGuide.get(0).get("MAN_ID"));
			System.out.println("제목 : " + selectGuide.get(0).get("GUIDE_TITLE"));
			System.out.println("내용 : " + selectGuide.get(0).get("GUIDE_CONTENT"));
			System.out.println("===========================================");
			System.out.println("1.수정\t2.삭제\t0.돌아가기");
			System.out.print("입력>");
			int input = ScanUtil.nextInt();
			switch (input) {
			case 1:
				updateGudieAuth(guideNo);
				break;
			case 2:
				deleteGudieAuth(guideNo);
				break;
			case 0:
				break;
			default:
				System.out.println("잘못된 입력입니다.");
				selectGuide();
				break;
			}
		}

	// 가이드 게시판 수정권한 - 완
		public int updateGudieAuth(int guideNo) {
			Map<String, Object> param = new HashMap<>();

			param.put("GUIDE_NO", guideNo);
			List<Map<String, Object>> selectGuide = OtherDao.selectGuide(param);

			if (((BigDecimal) MainService.login.get("AUTH")).intValue() == 3) {
					System.out.println("권한이 있습니다.");
					updateGuide(guideNo);
				} else if (((BigDecimal) MainService.login.get("AUTH")).intValue() == 1) {
					System.out.println("권한이 없습니다.");
					guide();
				} else if (((BigDecimal) MainService.login.get("AUTH")).intValue() == 2) {
					System.out.println("권한이 없습니다.");
					guide();
					} else { System.out.println("권한이 없습니다.");
					guide();
				}
			return View.MAIN;
		}
	
	// 가이드 게시판 수정 - 완
	private void updateGuide(int guideNo) {
		System.out.println("===================가이드 수정==================");
		System.out.println("수정할 제목>");
		String title = ScanUtil.nextLine();
		System.out.println("수정할 내용>");
		String content = ScanUtil.nextLine();

		Map<String, Object> param = new HashMap<>();
		param.put("GUIDE_NO", guideNo);
		param.put("GUIDE_TITLE", title);
		param.put("GUIDE_CONTENT", content);

		int result = OtherDao.updateGuide(param);

		if (0 < result) {
			System.out.println("게시글이 수정 되었습니다.");
		} else {
			System.out.println("게시글이 수정을 실패하였습니다.");
		}
	}

	// 가이드 게시판 삭제권한 - 완
	public int deleteGudieAuth(int guideNo) {
		Map<String, Object> param = new HashMap<>();

		param.put("GUIDE_NO", guideNo);
		List<Map<String, Object>> selectGuide = OtherDao.selectGuide(param);

		if (((BigDecimal) MainService.login.get("AUTH")).intValue() == 3) {
				System.out.println("권한이 있습니다.");
				deleteGudie(guideNo);
			} else if (((BigDecimal) MainService.login.get("AUTH")).intValue() == 1) {
				System.out.println("권한이 없습니다.");
				guide();
			} else if (((BigDecimal) MainService.login.get("AUTH")).intValue() == 2) {
				System.out.println("권한이 없습니다.");
				guide();
				} else { System.out.println("권한이 없습니다.");
				guide();
			}
		return View.MAIN;
	}
	
	//가이드 게시판 삭제 - 완
	private void deleteGudie(int guideNo) {
		System.out.println("===================가이드 삭제==================");
		System.out.println("현재 게시글을 삭제하시겠습니까? y or n");
		System.out.println("입력 >");
		String input = ScanUtil.nextLine();

		switch (input) {
		case "Y":
		case "y":
			Map<String, Object> param = new HashMap<>();
			param.put("GUIDE_NO", guideNo);
			int result = OtherDao.deleteGuide(param);
			if (0 < result) {
				System.out.println("삭제를 완료하였습니다.");
			} else
				System.out.println("삭제를 실패하였습니다.");
			break;
		case "N":
		case "n":
			System.out.println("삭제를 취소하였습니다.");
			selectGuide();
			break;
		default:
			System.out.println("잘못된 입력입니다.");
			System.out.println("이전메뉴로 돌아갑니다.");
			selectGuide();
			break;
		}
	}
	
	// 가이드 등록 권한 - 완
	public int insertGuideAuth() {
		if (((BigDecimal) MainService.login.get("AUTH")).intValue() == 3) {
			System.out.println("권한이 있습니다.");
			insertGuide();
		} else if (((BigDecimal) MainService.login.get("AUTH")).intValue() == 1) {
			System.out.println("권한이 없습니다.");
			guide();
		} else if (((BigDecimal) MainService.login.get("AUTH")).intValue() == 2) {
			System.out.println("권한이 없습니다.");
			guide();
		} else {
			System.out.println("권한이 없습니다.");
			guide();
		}
		return View.MAIN;
	}
	
	// 가이드 게시글 등록 - 완
	private int insertGuide() {
		System.out.println("===================가이드 등록==================");
		System.out.print("제목>");
		String Title = ScanUtil.nextLine();
		System.out.print("내용>");
		String Content = ScanUtil.nextLine();

		Map<String, Object> param = new HashMap<>();
		param.put("GUIDE_TITLE", Title);
		param.put("GUIDE_CONTENT", Content);
		param.put("MAN_ID", MainService.login.get("MAN_ID"));

		int result = OtherDao.insertGuide(param);

		if (0 < result) {
			System.out.println("등록하였습니다.");
		} else {
			System.out.println("등록에 실패하였습니다.");
		}
		return guide();
	}

					
	//-----------------------------------------------------------------------------------
	
	// 공지 게시판 목록  - 완
	public int notice() {
		List<Map<String, Object>> noticeList = OtherDao.NoticeList();		
		System.out.println("====================공지사항===================");
		System.out.println("번호\t제목\t작성자\t작성일");
		System.out.println("---------------------------------------------");
		for (Map<String, Object> NOTICE : noticeList) {
			System.out.println(NOTICE.get("NOTICE_NO") + "\t"
					+ NOTICE.get("NOTICE_TITLE") + "\t"
					+ NOTICE.get("MAN_ID") + "\t"
					+ sdf.format(NOTICE.get("NOTICE_DATE")));
		}
		System.out.println("===========================================");
		System.out.println("1.조회\t2.등록\t0.돌아가기");
		System.out.print("입력>");

		int input = ScanUtil.nextInt();
		switch (input) {
		case 1:
			selectNotice();
			break;
		case 2:
			insertNoticeAuth();
			break;
		case 0:
			break;
		default:
			System.out.println("잘못 입력하셨습니다.");
			break;
		}
		return View.MAIN;
	}

	// 공지 게시판 조회  - 완
			private void selectNotice() {
				System.out.println("==================공지사항 조회==================");
				System.out.println("조회할 게시글의 번호를 입력해주세요>");
				int noticeNo = ScanUtil.nextInt();
				Map<String, Object> param = new HashMap<>();
				param.put("NOTICE_NO", noticeNo);

				List<Map<String, Object>> selectNotice = OtherDao.selectNotice(param);

				System.out.println("====================공지사항===================");
				System.out.println("글번호 : " + selectNotice.get(0).get("NOTICE_NO"));
				System.out.println("작성일 : " + sdf.format(selectNotice.get(0).get("NOTICE_DATE")));
				System.out.println("아이디 : " + selectNotice.get(0).get("MAN_ID"));
				System.out.println("제목 : " + selectNotice.get(0).get("NOTICE_TITLE"));
				System.out.println("내용 : " + selectNotice.get(0).get("NOTICE_CONTENT"));
				System.out.println("===========================================");
				System.out.println("1.수정\t2.삭제\t0.돌아가기");
				System.out.print("입력>");
				int input = ScanUtil.nextInt();
				switch (input) {
				case 1:
					updateNoticeAuth(noticeNo);
					break;
				case 2:
					deleteNoticeAuth(noticeNo);
					break;
				case 0:
					break;
				default:
					System.out.println("잘못된 입력입니다.");
					selectGuide();
					break;
				}
			}
			
	// 공지 게시판 수정 권한 - 완
	public int updateNoticeAuth(int noticeNo) {
		Map<String, Object> param = new HashMap<>();

		param.put("NOTICE_NO", noticeNo);
		List<Map<String, Object>> selectNotice = OtherDao.selectNotice(param);

		if (((BigDecimal) MainService.login.get("AUTH")).intValue() == 3) {
			System.out.println("권한이 있습니다.");
			updateNotice(noticeNo);
		} else if (((BigDecimal) MainService.login.get("AUTH")).intValue() == 1) {
			System.out.println("권한이 없습니다.");
			notice();
		} else if (((BigDecimal) MainService.login.get("AUTH")).intValue() == 2) {
			System.out.println("권한이 없습니다.");
			notice();
		} else {
			System.out.println("권한이 없습니다.");
			notice();
		}
		return View.MAIN;
	}

	// 공지 게시판 수정 - 완
	private void updateNotice(int noticeNo) {
		System.out.println("===================공지사항 수정=================");
		System.out.println("수정할 제목>");
		String title = ScanUtil.nextLine();
		System.out.println("수정할 내용>");
		String content = ScanUtil.nextLine();

		Map<String, Object> param = new HashMap<>();
		param.put("NOTICE_NO", noticeNo);
		param.put("NOTICE_TITLE", title);
		param.put("NOTICE_CONTENT", content);

		int result = OtherDao.updateNotice(param);

		if (0 < result) {
			System.out.println("게시글이 수정 되었습니다.");
		} else {
			System.out.println("게시글이 수정을 실패하였습니다.");
		}
	}
	// 공지 게시판 삭제 - 완
	public int deleteNoticeAuth(int noticeNo) {
		if (((BigDecimal) MainService.login.get("AUTH")).intValue() == 3) {
			System.out.println("권한이 있습니다.");
			deleteNotice(noticeNo);
		} else if (((BigDecimal) MainService.login.get("AUTH")).intValue() == 1) {
			System.out.println("권한이 없습니다.");
			notice();
		} else if (((BigDecimal) MainService.login.get("AUTH")).intValue() == 2) {
			System.out.println("권한이 없습니다.");
			notice();
		} else {
			System.out.println("권한이 없습니다.");
			notice();
		}
		return View.MAIN;
	}
	// 공지 게시판 삭제 - 완
	private void deleteNotice(int noticeNo) {
		System.out.println("==================공지사항 삭제==================");
		System.out.println("현재 게시글을 삭제하시겠습니까? y or n");
		System.out.println("입력 >");
		String input = ScanUtil.nextLine();

		switch (input) {
		case "Y":
		case "y":
			Map<String, Object> param = new HashMap<>();
			param.put("NOTICE_NO", noticeNo);
			int result = OtherDao.deleteNotice(param);
			if (0 < result) {
				System.out.println("삭제를 완료하였습니다.");
			} else
				System.out.println("삭제를 실패하였습니다.");
			break;
		case "N":
		case "n":
			System.out.println("삭제를 취소하였습니다.");
			selectNotice();
			break;
		default:
			System.out.println("잘못된 입력입니다.");
			System.out.println("이전메뉴로 돌아갑니다.");
			selectNotice();
			break;
		}
	}

	// 공지 등록 권한 - 완
	public int insertNoticeAuth() {
		if (((BigDecimal) MainService.login.get("AUTH")).intValue() == 3) {
			System.out.println("권한이 있습니다.");
			insertNotice();
		} else if (((BigDecimal) MainService.login.get("AUTH")).intValue() == 1) {
			System.out.println("권한이 없습니다.");
			notice();
		} else if (((BigDecimal) MainService.login.get("AUTH")).intValue() == 2) {
			System.out.println("권한이 없습니다.");
			notice();
		} else {
			System.out.println("권한이 없습니다.");
			notice();
		}
		return View.MAIN;
	}
	
	// 공지 게시글 등록 - 완
	private int insertNotice() {
		System.out.println("===================공지사항 등록=================");
		System.out.print("제목>");
		String title = ScanUtil.nextLine();
		System.out.print("내용>");
		String content = ScanUtil.nextLine();

		Map<String, Object> param = new HashMap<>();
		param.put("NOTICE_TITLE", title);
		param.put("NOTICE_CONTENT", content);
		param.put("NOTICE_DATE", sdf.format(now));
		param.put("MAN_ID", MainService.login.get("MAN_ID"));
		int result = OtherDao.insertNotice(param);

		if (0 < result) {
			System.out.println("등록하였습니다.");
		} else {
			System.out.println("등록에 실패하였습니다.");
		}
		return notice();
	}

}
