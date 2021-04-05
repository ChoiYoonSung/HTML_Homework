package dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import util.JDBCUtil;

public class ResumeDao {
	private ResumeDao(){}
	private static ResumeDao instance;
	public static ResumeDao getInstance(){
		if(instance == null){
			instance = new ResumeDao();
		}
		return instance;
	}
	private JDBCUtil jdbc = JDBCUtil.getInstance();
	
	public int update(Map<String, Object> resumedata) {
	String sql = " update RESUME set RESUME_INTRCN=?,"
			+ " RESUME_EDU1=?,RESUME_EDU2=?,RESUME_CR1=?,"
			+ " RESUME_ADD=?,RESUME_SECTOR=?,RESUME_TYPE=?,"
			+ " RESUME_DATE=?,RESUME_TIME=?,RESUME_OPENTERM=?,RESUME_DAY=? "
			+ " where ALBA_ID = ? ";
		
		List<Object> p = new ArrayList<>();
		String[] resumeKey = {"RESUME_INTRCN",
			      "RESUME_EDU1","RESUME_EDU2","RESUME_CR1", 
			      "RESUME_ADD","RESUME_SECTOR","RESUME_TYPE", 
			      "RESUME_DATE","RESUME_TIME","RESUME_OPENTERM","RESUME_DAY"};
		for (int i = 0; i < resumeKey.length; i++) {
			p.add(resumedata.get(resumeKey[i]));
		}
			p.add(resumedata.get("ALBA_ID"));
			
		return jdbc.update(sql, p);
	}
	
}
