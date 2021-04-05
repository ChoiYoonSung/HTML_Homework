package dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import service.MainService;
import util.JDBCUtil;

public class OtherDao {

	private static OtherDao instance;

	public static OtherDao getInstance() {
		if (instance == null)
			instance = new OtherDao();
		return instance;
	}

	private static JDBCUtil jdbc = JDBCUtil.getInstance();

	// 알바 Q&A 리스트 - 완
	public static List<Map<String, Object>> qnaAlbaList() {
		String sql ="SELECT QA_AL_NUM, QA_AL_TITLE, "
				+ "NVL2(AL_MAN_CONTENT, '[1]','[0]') AS AL_COMMNET,"
				+ "ALBA_ID, QA_AL_DATE, AL_MAN_CONTENT "
				+ "FROM QAALBABOARD "
				+ "ORDER BY QA_AL_NUM DESC";

		return jdbc.selectList(sql);
	}
		
	// 알바 Q&A 게시글 조회 - 완
	public static List<Map<String, Object>> selectQnaAlba(
			Map<String, Object> param) {

		String sql = "SELECT QA_AL_NUM, QA_AL_TITLE, "
				+ "QA_AL_CONTENT, QA_AL_DATE, ALBA_ID, "
				+ "NVL(AL_MAN_CONTENT, 'X') AS AL_CONTENT, "
				+ "NVL(TO_CHAR(AL_MAN_DATE), 'X') AS AL_DATE, "
				+ "NVL(MAN_ID, 'X') AS AL_MAN_ID "
				+ "FROM QAALBABOARD "
				+ "WHERE QA_AL_NUM =?";

		List<Object> p = new ArrayList<>();
		p.add(param.get("QA_AL_NUM"));

		return jdbc.selectList(sql, p);
	}

	// 알바 Q&A 게시글 수정 - 완
	public static int updateQnaAlba(Map<String, Object> param) {
		String sql = "UPDATE QAALBABOARD SET QA_AL_TITLE = ?, QA_AL_CONTENT = ?,"
				+ "QA_AL_DATE = SYSDATE "
				+ "WHERE QA_AL_NUM = "
				+ "(SELECT QA_AL_NUM "
				+ "FROM QAALBABOARD "
				+ "WHERE QA_AL_NUM = ?)";
			
		List<Object> p = new ArrayList<>();
		
		p.add(param.get("QA_AL_TITLE"));
		p.add(param.get("QA_AL_CONTENT"));
		p.add(param.get("QA_AL_NUM"));
		return jdbc.update(sql, p);
	}
	
	// 알바 Q&A 게시글 삭제 - 완
	public static int deleteqnaAlba(Map<String, Object> param) {
		String sql = "DELETE FROM QAALBABOARD " + "WHERE QA_AL_NUM = ("
				+ "SELECT QA_AL_NUM " + "FROM QAALBABOARD "
				+ "WHERE QA_AL_NUM = ?)";

		List<Object> p = new ArrayList<>();
		p.add(param.get("QA_AL_NUM"));
		return jdbc.update(sql, p);
	}

	// 알바 Q&A 게시글  등록 - 완
	public static int insertAlbaQna(Map<String, Object> param) {
		String sql = "INSERT INTO QAALBABOARD (QA_AL_NUM, QA_AL_TITLE, QA_AL_CONTENT, "
				+ "QA_AL_DATE, AL_MAN_CONTENT, AL_MAN_DATE, ALBA_ID, MAN_ID) "
				+ "VALUES (QAALBABOARDNO.NEXTVAL, ?, ?, ?, ?, ?,"
				+ " (SELECT ALBA_ID FROM ALBA WHERE ALBA_ID = ?), ?)";

		List<Object> p = new ArrayList<>();
		p.add(param.get("QA_AL_TITLE"));
		p.add(param.get("QA_AL_CONTENT"));
		p.add(param.get("QA_AL_DATE"));
		p.add(param.get("AL_MAN_CONTENT"));
		p.add(param.get("AL_MAN_DATE"));
		p.add(param.get("ALBA_ID"));
		p.add(param.get("MAN_ID"));
		
		return jdbc.update(sql, p);
	}

	//알바 Q&A 댓글  등록, 삭제 (등록이지만 update를 씀.) 완료
	public static int updateQnaAlbaComm(Map<String, Object> param) {
		String sql = "UPDATE QAALBABOARD "
				+ "SET AL_MAN_CONTENT = ?, MAN_ID = "
				+ "(SELECT MAN_ID "
				+ "FROM MANAGER "
				+ "WHERE MAN_ID = ?), "
				+ "AL_MAN_DATE = ? "
				+ "WHERE QA_AL_NUM = ? ";
			
		List<Object> p = new ArrayList<>();
		p.add(param.get("AL_MAN_CONTENT"));
		p.add(param.get("MAN_ID"));
		p.add(param.get("AL_MAN_DATE"));
		p.add(param.get("QA_AL_NUM"));
		return jdbc.update(sql, p);
	}
	
	
	// ------------------------------------------------------------------------------

	// 기업 Q&A 리스트 - 완
	public static List<Map<String, Object>> qnaComList() {
		String sql ="SELECT QA_COM_NUM, QA_COM_TITLE, "
				+ "NVL2(COM_MAN_CONTENT, '[1]','[0]') AS COM_COMMNET,"
				+ "QA_COM_ID, QA_COM_DATE, COM_MAN_CONTENT "
				+ "FROM QACOMBOARD "
				+ "ORDER BY QA_COM_NUM DESC";

		return jdbc.selectList(sql);
	}
	
	// 기업 Q&A 게시글 조회 - 완
	public static List<Map<String, Object>> selectQnaCom(
			Map<String, Object> param) {

		String sql = "SELECT QA_COM_NUM, QA_COM_DATE, "
				+ "QA_COM_ID, QA_COM_TITLE, QA_COM_CONTENT, "
				+ "NVL(TO_CHAR(COM_MAN_DATE), 'X') AS COM_DATE, "
				+ "NVL(MAN_ID, 'X') AS COM_MAN_ID, "
				+ "NVL(COM_MAN_CONTENT, 'X') AS COM_CONTENT "
				+ "FROM QACOMBOARD " + "WHERE QA_COM_NUM = ? ";

		List<Object> p = new ArrayList<>();
		p.add(param.get("QA_COM_NUM"));

		return jdbc.selectList(sql, p);
	}

	// 기업 Q&A 게시글 수정 - 완
	public static int updateQnaCom(Map<String, Object> param) {
		String sql = "UPDATE QACOMBOARD SET QA_COM_TITLE = ?, QA_COM_CONTENT = ?, "
				+ "QA_COM_DATE = SYSDATE "
				+ "WHERE QA_COM_NUM = "
				+ "(SELECT QA_COM_NUM "
				+ "FROM QACOMBOARD "
				+ "WHERE QA_COM_NUM = ?)";

		List<Object> p = new ArrayList<>();
		p.add(param.get("QA_COM_TITLE"));
		p.add(param.get("QA_COM_CONTENT"));
		p.add(param.get("QA_COM_NUM"));
		return jdbc.update(sql, p);
	}

	// 기업 Q&A 게시글 삭제 - 완
	public static int deleteqnaCom(Map<String, Object> param) {
		String sql = "DELETE FROM QACOMBOARD " + "WHERE QA_COM_NUM = ("
				+ "SELECT QA_COM_NUM " + "FROM QACOMBOARD "
				+ "WHERE QA_COM_NUM = ?)";

		List<Object> p = new ArrayList<>();
		p.add(param.get("QA_COM_NUM"));
		return jdbc.update(sql, p);
	}

	// 기업 Q&A 게시글 등록 - 완
	public static int insertComQna(Map<String, Object> param) {
		String sql = "INSERT INTO QACOMBOARD (QA_COM_NUM, QA_COM_TITLE, QA_COM_CONTENT, "
				+ "QA_COM_DATE, COM_MAN_CONTENT, COM_MAN_DATE, QA_COM_ID, MAN_ID) "
				+ "VALUES (QAALBABOARDNO.NEXTVAL, ?, ?, ?, ?, ?,"
				+ " (SELECT COM_ID FROM COMPANY WHERE COM_ID = ?), ?)";

		List<Object> p = new ArrayList<>();
		p.add(param.get("QA_COM_TITLE"));
		p.add(param.get("QA_COM_CONTENT"));
		p.add(param.get("QA_COM_DATE"));
		p.add(param.get("COM_MAN_CONTENT"));
		p.add(param.get("COM_MAN_DATE"));
		p.add(param.get("QA_COM_ID"));
		p.add(param.get("MAN_ID"));
		
		return jdbc.update(sql, p);
	}

	//기업 Q&A 댓글  등록, 삭제 (등록이지만 update를 씀.) 완료	
	public static int updateQnaComComm(Map<String, Object> param) {
			String sql = "UPDATE QACOMBOARD "
					+ "SET COM_MAN_CONTENT = ?, MAN_ID = "
					+ "(SELECT MAN_ID "
					+ "FROM MANAGER "
					+ "WHERE MAN_ID = ?), "
					+ "COM_MAN_DATE = ? "
					+ "WHERE QA_COM_NUM = ? ";
				
			List<Object> p = new ArrayList<>();
			p.add(param.get("COM_MAN_CONTENT"));
			p.add(param.get("MAN_ID"));
			p.add(param.get("COM_MAN_DATE"));
			p.add(param.get("QA_COM_NUM"));
			return jdbc.update(sql, p);
		}
		
		
	// --------------------------------------------------------------------------------------

	// 가이드 리스트 - 완
	public static List<Map<String, Object>> guideList() {
		String sql = "SELECT GUIDE_NO, GUIDE_TITLE, GUIDE_CONTENT, MAN_ID "
				+ "FROM GUIDE " + "ORDER BY GUIDE_NO DESC";

		return jdbc.selectList(sql);
	}

	// 가이드 게시글 조회 - 완
	public static List<Map<String, Object>> selectGuide(
			Map<String, Object> param) {

		String sql = "SELECT GUIDE_NO, GUIDE_TITLE, GUIDE_CONTENT, MAN_ID "
				+ "FROM GUIDE " + "WHERE GUIDE_NO =?";

		List<Object> p = new ArrayList<>();
		p.add(param.get("GUIDE_NO"));

		return jdbc.selectList(sql, p);
	}

	// 가이드 게시글 수정 - 완
	public static int updateGuide(Map<String, Object> param) {
		String sql = "UPDATE GUIDE SET GUIDE_TITLE = ?, GUIDE_CONTENT = ? "
				+ "WHERE GUIDE_NO = " + "(SELECT GUIDE_NO " + "FROM GUIDE "
				+ "WHERE GUIDE_NO = ?)";

		List<Object> p = new ArrayList<>();
		p.add(param.get("GUIDE_TITLE"));
		p.add(param.get("GUIDE_CONTENT"));
		p.add(param.get("GUIDE_NO"));
		return jdbc.update(sql, p);
	}

	// 가이드 게시글 삭제 - 완
	public static int deleteGuide(Map<String, Object> param) {
		String sql = "DELETE FROM GUIDE " + "WHERE GUIDE_NO = ("
				+ "SELECT GUIDE_NO " + "FROM GUIDE " + "WHERE GUIDE_NO = ?)";

		List<Object> p = new ArrayList<>();
		p.add(param.get("GUIDE_NO"));
		return jdbc.update(sql, p);
	}

	// 가이드 게시글 등록 - 완
	public static int insertGuide(Map<String, Object> param) {
		String sql = "INSERT INTO GUIDE (GUIDE_NO, GUIDE_TITLE, GUIDE_CONTENT, MAN_ID) "
				+ "VALUES (SEQGUIDENO.NEXTVAL, ?, ?, (SELECT DISTINCT MAN_ID FROM GUIDE WHERE MAN_ID = ?))";

		List<Object> p = new ArrayList<>();
		p.add(param.get("GUIDE_TITLE"));
		p.add(param.get("GUIDE_CONTENT"));
		p.add(param.get("MAN_ID"));
		return jdbc.update(sql, p);
	}

	// ------------------------------------------------------------------------------------

	// 공지 리스트 - 완
	public static List<Map<String, Object>> NoticeList() {
		String sql = "SELECT NOTICE_NO, NOTICE_TITLE, NOTICE_CONTENT, NOTICE_DATE, MAN_ID "
				+ "FROM NOTICE " + "ORDER BY NOTICE_NO DESC";

		return jdbc.selectList(sql);
	}

	// 공지 게시글 조회 - 완
	public static List<Map<String, Object>> selectNotice(
			Map<String, Object> param) {

		String sql = "SELECT NOTICE_NO, NOTICE_TITLE, NOTICE_CONTENT, NOTICE_DATE, MAN_ID "
				+ "FROM NOTICE " + "WHERE NOTICE_NO =?";

		List<Object> p = new ArrayList<>();
		p.add(param.get("NOTICE_NO"));

		return jdbc.selectList(sql, p);
	}
	
	// 공지 게시글 등록 - 완
	public static int insertNotice(Map<String, Object> param) {
		String sql = "INSERT INTO NOTICE (NOTICE_NO, NOTICE_TITLE, NOTICE_CONTENT, NOTICE_DATE, MAN_ID) "
				+ "VALUES (SEQGUIDENO.NEXTVAL, ?, ?, ?, "
				+ "(SELECT DISTINCT MAN_ID FROM GUIDE WHERE MAN_ID = ?))";

		List<Object> p = new ArrayList<>();
		p.add(param.get("NOTICE_TITLE"));
		p.add(param.get("NOTICE_CONTENT"));
		p.add(param.get("NOTICE_DATE"));
		p.add(param.get("MAN_ID"));
		return jdbc.update(sql, p);
	}

	
	// ------------------------------------------------------------------------------------

	// 가이드 게시글 수정 - 완
	public static int updateNotice(Map<String, Object> param) {
		String sql = "UPDATE NOTICE SET NOTICE_TITLE = ?, NOTICE_CONTENT = ? "
				+ "WHERE NOTICE_NO = " + "(SELECT NOTICE_NO " + "FROM NOTICE "
				+ "WHERE NOTICE_NO = ?)";

		List<Object> p = new ArrayList<>();
		p.add(param.get("NOTICE_TITLE"));
		p.add(param.get("NOTICE_CONTENT"));
		p.add(param.get("NOTICE_NO"));
		return jdbc.update(sql, p);
	}

	// 가이드 게시글 삭제 - 완
	public static int deleteNotice(Map<String, Object> param) {
		String sql = "DELETE FROM NOTICE " + "WHERE NOTICE_NO = ("
				+ "SELECT NOTICE_NO " + "FROM NOTICE " + "WHERE NOTICE_NO = ?)";

		List<Object> p = new ArrayList<>();
		p.add(param.get("NOTICE_NO"));
		return jdbc.update(sql, p);
	}



}
