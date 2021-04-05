package dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import util.JDBCUtil;

public class CommonDao {
	private CommonDao(){}
	private static CommonDao instance;
	public static CommonDao getInstance(){
		if(instance == null){
			instance = new CommonDao();
		}
		return instance;
	}
	
	
	private JDBCUtil jdbc = JDBCUtil.getInstance();
	
public List<Map<String, Object>> Commoncod(Map<String,Object> par){
	String sql = " SELECT *"
			+ " FROM COMMON "
			+ " WHERE COMMON_TYPE_COD = ?";
	List<Object> p = new ArrayList<>();
	p.add(par.get("COMMON_TYPE_COD"));
	
		return jdbc.selectList(sql, p);
	}
}
