package dao;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import service.MainService;
import util.JDBCUtil;

public class ComMenuDao {
	private ComMenuDao(){}
	private static ComMenuDao instance;
	public static ComMenuDao getInstance(){
		if(instance == null){
			instance = new ComMenuDao();
		}
		return instance;
	}
	private JDBCUtil jdbc = JDBCUtil.getInstance();
	

	
	public int update(Map<String, Object> comdata) {
		String sql = " update COMPANY set COM_ID=?,COM_PASSWORD=?,COM_REGNO=?,COM_NAME=?,COM_MAIL=?,COM_ADD=?,COM_TEL=?,COM_CEO=?,AUTH=? where COM_ID = ? ";
		
		List<Object> p = new ArrayList<>();
		String[] key = {"COM_ID","COM_PASSWORD","COM_REGNO","COM_NAME","COM_MAIL","COM_ADD","COM_TEL","COM_CEO","AUTH"};
		for (int i = 0; i < key.length; i++) {
			p.add(comdata.get(key[i]));
		}
			p.add(MainService.login.get("COM_ID"));
			
		return jdbc.update(sql, p);
	}
	
	public int delete() {
		String sql = " delete from company where COM_ID=? ";
		List<Object> param = new ArrayList<>();
		param.add(MainService.login.get("COM_ID"));
		
		return jdbc.update(sql, param);
		
	}

	public List<Map<String, Object>> selectResume(Map<String, Object> param) {
		String sql = " select B.HIRE_NO,	B.HIRE_TITLE, 	A.COM_NAME,	A.COM_REGNO,	A.COM_MAIL, "
				  + " A.COM_ADD,	A.COM_TEL,		A.COM_CEO,	B.HIRE_AGE,		B.HIRE_ADD,	"
				  + " B.HIRE_SECTOR, B.HIRE_DAY,		B.HIRE_TIME,B.HIRE_EMP,		B.HIRE_AL_DATE,	"
				  + " B.HIRE_COST, 	B.HIRE_COST_TYPE,	B.HIRE_SEXDTN,	B.HIRE_NUM,	B.HIRE_EDU1,"
				  + " B.HIRE_EDU2, B.HIRE_DATE from COMPANY A, HIRE B WHERE A.COM_ID = B.HIRE_ID AND A.COM_ID = ? ";
		
		List<Object> par = new ArrayList<>();
		par.add(param.get("COM_ID"));
		return jdbc.selectList(sql, par);
	}

	public List<Map<String, Object>> selectHR(Map<String, Object> param1) {
		String sql = " select A.HR_LIKE FROM HIRE_RESUME A , HIRE B WHERE A.HIRE_NO = B.HIRE_NO"
					+ " AND B.HIRE_NO = ?";
		List<Object> par1 = new ArrayList<>();
		par1.add(param1.get("HIRE_NO"));
		return jdbc.selectList(sql, par1);
		
	}

	
	
	
}
