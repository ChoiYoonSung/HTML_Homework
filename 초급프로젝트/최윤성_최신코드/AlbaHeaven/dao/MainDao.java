package dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import util.JDBCUtil;

public class MainDao {
	private MainDao() {}

	private static MainDao instance;

	public static MainDao getInstance() {
		if (instance == null) {
			instance = new MainDao();
		}
		return instance;
	}
	
	private JDBCUtil jdbc = JDBCUtil.getInstance();
	//-------------------------이력서------------------------------
	
	//이력서 게시판 전체 출력
	public List<Map<String, Object>> resumeBoardList() {
		
		String sql = " SELECT A.RL_NO, A.RL_TITLE, B.ALBA_NAME, A.RL_DATE"
				   + " FROM RESUME_LIST A, ALBA B, RESUME C"
				   + " WHERE A.RESUME_NO = C.RESUME_NO AND B.ALBA_ID = C.ALBA_ID";
		return jdbc.selectList(sql);
	}

	//이력서게시판 선택 출력 +완
	public List<Map<String, Object>> selectResumeLs(Map<String, Object> param){
				
		String sql = " SELECT "
				   + "     B.RL_NO, B.RL_TITLE, B.RL_DATE,"
				   + "     A.ALBA_ID, A.ALBA_NAME, A.ALBA_BIR, A.ALBA_SEXDSTN, A.ALBA_TEL, A.ALBA_ADD, A.ALBA_MAIL,"
				   + "     C.RESUME_EDU1, C.RESUME_EDU2, C.RESUME_CR1, C.RESUME_INTRCN, C.RESUME_ADD, C.RESUME_SECTOR,"
				   + "     C.RESUME_TYPE, C.RESUME_DATE, C.RESUME_TIME, C.RESUME_OPENTERM, C.RESUME_DAY"
				   + " FROM ALBA A, RESUME_LIST B, RESUME C  "
				   + " WHERE B.RESUME_NO = C.RESUME_NO"
				   + " AND   A.ALBA_ID = C.ALBA_ID"
				   + " AND   A.ALBA_ID = ?";
		
		List<Object> p = new ArrayList<>();
		p.add(param.get("ALBA_ID"));
		
		return jdbc.selectList(sql, p);
	}
	public List<Map<String,Object>> careerLs(Map<String, Object>param){
		String sql = " SELECT A.CR_COM_NAME, A.CR_COM_TERM, A.CR_COM_TASK"
				   + " FROM CAREER A, RESUME B"
				   + " WHERE A.RESUME_NO = B.RESUME_NO"
				   + " AND  B.ALBA_ID = ?";
		
		List<Object> p = new ArrayList<>();
		p.add(param.get("ALBA_ID"));
		
		return jdbc.selectList(sql, p);
	}
	public List<Map<String, Object>> likeresumeList(Map<String, Object> param) {
		String sql = " SELECT A.RH_LIKE"
				   + " FROM RESUME_HIRE A, RESUME_LIST B, RESUME C"
				   + " WHERE A.RL_NO = B.RL_NO"
				   + " AND B.RESUME_NO = C.RESUME_NO"
				   + " AND C.ALBA_ID= ?";
		
		List<Object> p = new ArrayList<>();
		p.add(param.get("ALBA_ID"));
		
		return jdbc.selectList(sql, p);
	}
	
	
	//이력서게시판 선택 수정 +완
	public int updateResumeLs(Map<String, Object> param) {
		String sql = " UPDATE RESUME_LIST"
				   + " SET RL_TITLE = ?, RL_DATE = SYSDATE"
				   + " WHERE RESUME_NO ="
				   + " (SELECT RESUME_NO"
				   + "  FROM RESUME"
				   + "  WHERE ALBA_ID = ?)";
		
		List<Object> p = new ArrayList<>();
		p.add(param.get("RL_TITLE"));
		p.add(param.get("ALBA_ID"));
		return jdbc.update(sql,p);
	}

	//이력서게시판 선택 삭제 +완
	public int deleteResumeHireLs(Map<String, Object> param) {
		String sql = " DELETE FROM RESUME_HIRE"
				   + " WHERE RL_NO = "
				   + "  (SELECT B.RL_NO"
				   + "  FROM RESUME A, RESUME_LIST B"
				   + "  WHERE A.RESUME_NO = B.RESUME_NO"
				   + "  AND A.ALBA_ID = ?)";
		
		List<Object> p = new ArrayList<>();
		p.add(param.get("ALBA_ID"));

		return jdbc.update(sql,p);
	}
	public int deleteResumeLs(Map<String, Object> param){
		String sql = " DELETE FROM RESUME_LIST"
				   + " WHERE RESUME_NO = "
				   + "  (SELECT RESUME_NO"
				   + "  FROM RESUME"
				   + "  WHERE ALBA_ID = ?)";
		
		List<Object> p = new ArrayList<>();
		p.add(param.get("ALBA_ID"));
		return jdbc.update(sql,p);
	}
	
	//이력서리스트 입력  +완
	public int insertResumeLs(Map<String, Object> param) {
		
		String sql = " INSERT INTO RESUME_LIST"
				   + " VALUES("
				   + " (SELECT RESUME_NO"
				   + " FROM RESUME"
				   + " WHERE ALBA_ID = ?)"
				   + ", ?, SYSDATE, SEQRL.NEXTVAL)";
		
		List<Object> p = new ArrayList<>();
		p.add(param.get("ALBA_ID"));
		p.add(param.get("RL_TITLE"));
		return jdbc.update(sql,p);
		
	}
	
	//기업 이력서리스트 
	public List<Map<String, Object>> resumeHirels(Map<String, Object> param) {
		String sql = " SELECT "
				   + "       B.RL_NO, B.RL_TITLE, B.RL_DATE,"
				   + "       A.ALBA_ID, A.ALBA_NAME, A.ALBA_BIR, A.ALBA_SEXDSTN, A.ALBA_TEL, A.ALBA_ADD, A.ALBA_MAIL,"
				   + "       C.RESUME_EDU1, C.RESUME_EDU2, C.RESUME_CR1, C.RESUME_INTRCN, C.RESUME_ADD, C.RESUME_SECTOR,"
				   + "       C.RESUME_TYPE, C.RESUME_DATE, C.RESUME_OPENTERM, C.RESUME_DAY"
				   + " FROM  ALBA A, RESUME_LIST B, RESUME C  "
				   + " WHERE B.RESUME_NO = C.RESUME_NO"
				   + " AND   A.ALBA_ID = C.ALBA_ID"
				   + " AND   B.RL_NO = ? ";
		
		List<Object> p = new ArrayList<>();
		p.add(param.get("RL_NO"));
		return jdbc.selectList(sql, p);
	}
	public List<Map<String,Object>> careerHirels(Map<String, Object>param){
		String sql = " SELECT A.CR_COM_NAME, A.CR_COM_TERM, A.CR_COM_TASK"
				   + " FROM CAREER A, RESUME B, RESUME_LIST C"
				   + " WHERE A.RESUME_NO = B.RESUME_NO"
				   + " AND  B.RESUME_NO = C.RESUME_NO"
				   + " AND  C.RL_NO = ?";
		
		List<Object> p = new ArrayList<>();
		p.add(param.get("RL_NO"));
		
		return jdbc.selectList(sql, p);
	}
	
	//기업 이력서 면접 제의
	public int offerResume(Map<String, Object> param) {
		String sql = " INSERT INTO RESUME_HIRE"
				   + " VALUES("
				   + " (SELECT HIRE_NO"
				   + "  FROM HIRE, COMPANY"
				   + "  WHERE HIRE.HIRE_ID = COMPANY.COM_ID"
				   + "  AND HIRE.HIRE_ID = ?)"
				   + ",?,?)";
		
		List<Object> p = new ArrayList<>();
		p.add(param.get("COM_ID"));
		p.add(param.get("RL_NO"));
		p.add(param.get("RH_LIKE"));
		return jdbc.update(sql,p);
		
	}
	
	//관리자 이력서 게시판 삭제 전 확인
	public List<Map<String, Object>> checkResumeHire(Map<String, Object> param) {
		String sql = " SELECT *"
				   + " FROM RESUME_HIRE"
				   + " WHERE RL_NO = ?";
		
		List<Object> p = new ArrayList<>();
		p.add(param.get("RL_NO"));
		
		return jdbc.selectList(sql, p);
	}
	
	//관리자 이력서 게시판 삭제
	public int manDeleteResumeHire(Map<String, Object> param){
		String sql = " DELETE FROM RESUME_HIRE"
				   + " WHERE RL_NO = ?";
		
		List<Object> p = new ArrayList<>();
		p.add(param.get("RL_NO"));
		return jdbc.update(sql,p);
	}
	public int manDeleteResumeList(Map<String, Object> param){
		String sql = " DELETE FROM RESUME_LIST"
				   + " WHERE RL_NO = ?";
		
		List<Object> p = new ArrayList<>();
		p.add(param.get("RL_NO"));
		return jdbc.update(sql, p);
	}
	
	
	
	
	//-------------------------채용공고------------------------------
	//채용공고 전체 출력
	public List<Map<String, Object>> hireBoardList() {
		String sql = " SELECT HIRE_NO, HIRE_TITLE, COM_NAME, HIRE_DATE"
				+ " FROM HIRE, COMPANY"
				+ " WHERE HIRE.HIRE_ID = COMPANY.COM_ID";

		return jdbc.selectList(sql);
	}

	// 채용공고 입력
	public int insertHireLs(Map<String, Object> param) {

		String sql = " INSERT INTO HIRE" 
				   + " VALUES(SEQHIRE.NEXTVAL,"
				   + " (SELECT HIRE_ID"
				   + " FROM HIRE" 
				   + " WHERE HIRE_ID = ?)"
				   + ",?,?,?,?,?,?,?,?,?,?,?,?,?,SYSDATE+?,?)";

		List<Object> p = new ArrayList<>();
		p.add(param.get("COM_ID"));
		p.add(param.get("HIRE_AGE"));
		p.add(param.get("HIRE_ADD"));
		p.add(param.get("HIRE_SECTOR"));
		p.add(param.get("HIRE_DAY"));
		p.add(param.get("HIRE_TIME"));
		p.add(param.get("HIRE_EMP"));
		p.add(param.get("HIRE_AL_DATE"));
		p.add(param.get("HIRE_COST"));
		p.add(param.get("HIRE_SEXDTN"));
		p.add(param.get("HIRE_NUM"));
		p.add(param.get("HIRE_EDU1"));
		p.add(param.get("HIRE_EDU2"));
		p.add(param.get("HIRE_COST_TYPE"));
		p.add(param.get("HIRE_DATE"));
		p.add(param.get("HIRE_TITLE"));
		
		return jdbc.update(sql, p);

	}

	//채용공고 출력
	public List<Map<String, Object>> hireResumels(Map<String, Object> param) {
		String sql = " SELECT *"
				   + " FROM HIRE"
				   + " WHERE HIRE_NO = ?";
		
		List<Object> p = new ArrayList<>();
		p.add(param.get("HIRE_NO"));
		return jdbc.selectList(sql, p);
	}
	
	//개인회원 - 채용공고 신청
	public int offerhireList(Map<String, Object> param) {
		String sql = " INSERT INTO HIRE_RESUME"
				   + " VALUES("
				   + " (SELECT RESUME_NO"
				   + "  FROM RESUME"
				   + "  WHERE ALBA_ID = ?)"
				   + " ,?,?)";
		
		List<Object> p = new ArrayList<>();
		p.add(param.get("ALBA_ID"));
		p.add(param.get("HIRE_NO"));
		p.add(param.get("HR_LIKE"));
		return jdbc.update(sql,p);
	}
	
	//삭제 전 채용공고 지원 확인
	public List<Map<String, Object>> checkHireResume(Map<String, Object> param) {
		String sql = " SELECT *"
				   + " FROM HIRE_RESUME"
				   + " WHERE HIRE_NO = ?";
		
		List<Object> p = new ArrayList<>();
		p.add(param.get("HIRE_NO"));
		
		return jdbc.selectList(sql, p);
	}
	//관리자 채용공고 삭제
	public int manDeleteHireResume(Map<String, Object> param) {
		String sql = " DELETE FROM HIRE_RESUME"
				   + " WHERE HIRE_NO = ?";
		
		List<Object> p = new ArrayList<>();
		p.add(param.get("HIRE_NO"));
		return jdbc.update(sql,p);
	}

	public int manDeleteHire(Map<String, Object> param) {
		String sql = " DELETE FROM HIRE"
				   + " WHERE HIRE_NO = ?";
		
		List<Object> p = new ArrayList<>();
		p.add(param.get("HIRE_NO"));
		return jdbc.update(sql, p);
	}

/*	// 개인회원 키워드 검색
	public List<Map<String, Object>> keyword() {
		String sql = " SELECT DISTINCT A.COMMON_TYPE, B.COMMON_TYPE_COD"
				+ " FROM COMMON A, COMMON B"
				+ " WHERE A.COMMON_TYPE_COD = B.COMMON_TYPE_COD"
				+ " ORDER BY B.COMMON_TYPE_COD";
		return jdbc.selectList(sql);
	}

	public List<Map<String, Object>> keywordSearch(Map<String, Object> param) {
		String sql = " SELECT DISTINCT * "
				   + " FROM COMMON"
				   + " WHERE COMMON_TYPE_COD = ?";
		
		List<Object> p = new ArrayList<>();
		p.add(param.get("COMMON_TYPE_COD"));
		
		return jdbc.selectList(sql, p);
	}*/

}
