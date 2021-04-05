package dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import service.MainService;
import util.JDBCUtil;

public class AlbaMenuDao {
	private AlbaMenuDao(){}
	private static AlbaMenuDao instance;
	public static AlbaMenuDao getInstance(){
		if(instance == null){
			instance = new AlbaMenuDao();
		}
		return instance;
	}
	
	private JDBCUtil jdbc = JDBCUtil.getInstance();

	
	public int update(Map<String, Object> albadata) {
		String sql = " update ALBA set ALBA_ID=?,ALBA_PASSWORD=?,ALBA_NAME=?,ALBA_BIR=?,ALBA_SEXDSTN=?,ALBA_MAIL=?,ALBA_TEL=?,ALBA_ADD=?,AUTH=? where ALBA_ID = ? ";
		
		List<Object> p = new ArrayList<>();
		String[] key = {"ALBA_ID","ALBA_PASSWORD","ALBA_NAME","ALBA_BIR","ALBA_SEXDSTN","ALBA_MAIL","ALBA_TEL","ALBA_ADD","AUTH"};
		for (int i = 0; i < key.length; i++) {
			p.add(albadata.get(key[i]));
		}
			p.add(albadata.get("ALBA_ID"));
			
		return jdbc.update(sql, p);
	}	
	
	
	public int delete(){
		String sql = " delete from alba where ALBA_ID=? ";
		List<Object> param = new ArrayList<>();
		param.add(MainService.login.get("ALBA_ID"));
		
		return jdbc.update(sql, param);
		
	}


	public Map<String, Object> selectResume(Map<String, Object> param) {
		String sql = "select A.RESUME_NO, B.ALBA_ID, A.RESUME_EDU1, A.RESUME_EDU2, A.RESUME_CR1, "
				+ " A.RESUME_INTRCN, A.RESUME_ADD, A.RESUME_SECTOR, A.RESUME_TYPE, A.RESUME_DATE, A.RESUME_TIME, "
				+ " A.RESUME_OPENTERM, A.RESUME_DAY, B.ALBA_BIR, B.ALBA_NAME, B.ALBA_SEXDSTN, B.ALBA_MAIL, B.ALBA_TEL, "
				+ " B.ALBA_ADD from RESUME A, ALBA B WHERE A.ALBA_ID = B.ALBA_ID AND A.ALBA_ID = ?";
		List<Object> par = new ArrayList<>();
		par.add(param.get("ALBA_ID"));
		return jdbc.selectOne(sql, par);
	}


	public int insertResume(Map<String, Object> param) {
		String sql = " INSERT INTO RESUME(RESUME_NO,ALBA_ID,RESUME_EDU1,"
				+ " RESUME_EDU2,RESUME_CR1,RESUME_INTRCN,RESUME_ADD,RESUME_SECTOR,"
				+ " RESUME_TYPE,RESUME_DATE,RESUME_TIME,RESUME_OPENTERM,RESUME_DAY)"
				+ " VALUES(SEQRSNO.NEXTVAL,?,?,?,?,?,?,?,?,?,?,?,?)";
		List<Object> par = new ArrayList<>();
		par.add(param.get("ALBA_ID"));//
		par.add(param.get("RESUME_EDU1"));//
		par.add(param.get("RESUME_EDU2"));//
		par.add(param.get("RESUME_CR1"));//
		par.add(param.get("RESUME_INTRCN"));
		par.add(param.get("RESUME_ADD"));//
		par.add(param.get("RESUME_SECTOR"));//
		par.add(param.get("RESUME_TYPE"));//
		par.add(param.get("RESUME_DATE"));//
		par.add(param.get("RESUME_TIME"));//
		par.add(param.get("RESUME_OPENTERM"));//
		par.add(param.get("RESUME_DAY"));//
		return jdbc.update(sql, par);
	}




	}
	
	

