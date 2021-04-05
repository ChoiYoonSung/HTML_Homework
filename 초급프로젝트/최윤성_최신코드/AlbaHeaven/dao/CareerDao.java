package dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import util.JDBCUtil;

public class CareerDao {
	private CareerDao(){}
	private static CareerDao instance;
	public static CareerDao getInstance(){
		if(instance == null){
			instance = new CareerDao();
		}
		return instance;
	}

	private JDBCUtil jdbc = JDBCUtil.getInstance();
	
	
	public List<Map<String, Object>> selectcareer(Map<String, Object> param) {
		String sql = " SELECT A.CR_NUM, A.CR_COM_NAME ,A.CR_COM_TERM,A.CR_COM_TASK"
					+" FROM CAREER A, RESUME B  "
					+" WHERE A.RESUME_NO = B.RESUME_NO"
					+" AND B.ALBA_ID = ?";
		
		List<Object> par = new ArrayList<>();
		par.add(param.get("ALBA_ID"));
		
		return jdbc.selectList(sql, par);
	}

	//번호 회사명 근무기간 업무 이력서번호
	public int insertCareer(Map<String, Object> param) {
		String sql = " INSERT INTO CAREER"
				   + " VALUES(SEQCAREER.NEXTVAL,"
				   + " ?,?,?,"
				   + " (SELECT RESUME_NO"
				   + "  FROM RESUME"
				   + "  WHERE ALBA_ID = ?)"
				   + ")";
		
		List<Object> p = new ArrayList<>();
		p.add(param.get("CR_COM_NAME"));
		p.add(param.get("CR_COM_TERM"));
		p.add(param.get("CR_COM_TASK"));
		p.add(param.get("ALBA_ID"));
		
		return jdbc.update(sql,p);
	}

	public int deleteCareer(Map<String, Object> param) {
		String sql = " DELETE FROM CAREER"
				   + " WHERE CR_NUM = ?";
		
		List<Object> p = new ArrayList<>();
		p.add(param.get("CR_NUM"));
		return jdbc.update(sql, p);
	}
	
	

	
	
}
