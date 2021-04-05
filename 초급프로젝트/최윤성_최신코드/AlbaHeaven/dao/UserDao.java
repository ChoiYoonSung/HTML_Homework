package dao;

import java.util.ArrayList;

import java.util.List;
import java.util.Map;

import util.JDBCUtil;

public class UserDao {
	private UserDao(){}
	private static UserDao instance;
	public static UserDao getInstance(){
		if(instance == null){
			instance = new UserDao();
		}
		return instance;
	}
	
	private JDBCUtil jdbc = JDBCUtil.getInstance();
	
	public int insertUser(Map<String, Object> param) {
		String sql = " insert into ALBA "
					+ " values (?,?,?,?,?,?,?,?,?) ";
		
		List<Object> p = new ArrayList<>();
		p.add(param.get("ALBA_ID"));
		p.add(param.get("ALBA_PASSWORD"));
		p.add(param.get("ALBA_BIR"));
		p.add(param.get("ALBA_NAME"));
		p.add(param.get("ALBA_SEXDSTN"));
		p.add(param.get("ALBA_MAIL"));
		p.add(param.get("ALBA_TEL"));
		p.add(param.get("ALBA_ADD"));
		p.add(param.get("AUTH"));
		return jdbc.update(sql,p);
	}
	
	public int insertCom(Map<String, Object> param) {
		String sql = " insert into company "
				+ " values (?,?,?,?,?,?,?,?,?) ";
	
		List<Object> p = new ArrayList<>();
		p.add(param.get("COM_ID"));
		p.add(param.get("COM_PASSWORD"));
		p.add(param.get("COM_REGNO"));
		p.add(param.get("COM_NAME"));
		p.add(param.get("COM_MAIL"));
		p.add(param.get("COM_ADD"));
		p.add(param.get("COM_TEL"));
		p.add(param.get("COM_CEO"));
		p.add(param.get("AUTH"));
		return jdbc.update(sql,p);
	}

	public Map<String, Object> selectUser(String albaId, String password) {
		String sql = "select * from ALBA where alba_id = ? and alba_password = ?"; 
		List<Object> param = new ArrayList<>();
		param.add(albaId);
		param.add(password);
		
		return jdbc.selectOne(sql,param);
	}
	
	public Map<String, Object> selectCom(String comId, String password) {
		String sql = "select * from Company where com_id = ? and com_password = ?"; 
		List<Object> param = new ArrayList<>();
		param.add(comId);
		param.add(password);
		
		return jdbc.selectOne(sql,param);
	}
	
	public Map<String, Object> selectMan(String manId, String password) {
		String sql = "select * from Manager where man_id = ? and man_password = ?"; 
		List<Object> param = new ArrayList<>();
		param.add(manId);
		param.add(password);
		
		return jdbc.selectOne(sql,param);
	}
	
}

