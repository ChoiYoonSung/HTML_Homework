package util;

import java.sql.Connection;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class JDBCUtil {

	// 싱글톤 패턴 : 인스턴스의 생성을 제한하여 하나의 인스턴스만 사용하는 디자인 패턴
	// 객체를 하나만 생성하여 사용할 수 있도록 함
	// JDBCUtil을 통해 생성된 객체는 다른 클래스에서 사용하지 못한다
	private JDBCUtil() {

	}

	// 인스턴스를 보관할 변수
	private static JDBCUtil instance;

	// 인스턴스를 빌려주는 매서드
	// 다른 클래스에서 사용할 수 있도록 매서드를 호출하여 객체를 생성하여 사용할 수 있도록 한다.
	public static JDBCUtil getInstance() {
		if (instance == null) {
			instance = new JDBCUtil();
		}
		return instance;
	}

	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String user = "test";
	String password = "java";

	Connection con = null;
	PreparedStatement ps = null;
	ResultSet rs = null;

	/*
	 * Map<String, Object> selectOne(String sql) Map<String, Object>
	 * selectOne(String sql, List<Object> param) List<Map<string, Object>>
	 * selectList(String sql) List<Map<String, Object>> selectList(String sql,
	 * List<Object> param) int update(String sql) int update(String sql,
	 * List<Object> param)
	 * 
	 * 파라미터가 차이나는 이유는 Java의 Query문에서 ?의 유무에 따라 다르다. ?가 있을 경우 (String sql) ?가 없을
	 * 경우 (String sql, List<Object> param)
	 */

	public Map<String, Object> selectOne(String sql) {
		Map<String, Object> hashMap = null;
		//한 컬럼이 아닌 한 개 이상의 컬럼이 조회될 수 있기에 null로 초기화1
		
		try {
			con = DriverManager.getConnection(url, user, password);
			
			ps = con.prepareStatement(sql);
			
			rs = ps.executeQuery();
			
			ResultSetMetaData metaData = rs.getMetaData();
			int columnCount = metaData.getColumnCount();
			
			while(rs.next()){
				hashMap = new HashMap<>();
				for (int i = 1; i <= columnCount; i++) {
					hashMap.put(metaData.getColumnName(i), rs.getObject(i));
				}
			}	
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			if (rs != null) try { rs.close(); } catch (Exception e) { }
			if (ps != null) try { ps.close(); } catch (Exception e) { }
			if (con != null) try { con.close(); } catch (Exception e) { }
		}
		return hashMap;
	}

	
	public Map<String, Object> selectOne(String sql, List<Object> param) {
		Map<String, Object> hashMap = null;
		try {
			con = DriverManager.getConnection(url, user, password);

			ps = con.prepareStatement(sql);
			for (int i = 0; i < param.size(); i++) {
				ps.setObject(i + 1, param.get(i));
			}
			
			rs = ps.executeQuery();

			ResultSetMetaData metaData = rs.getMetaData();
			int columnCount = metaData.getColumnCount();

			while (rs.next()) {
				hashMap = new HashMap<>();
				for (int i = 1; i <= columnCount; i++) {
					hashMap.put(metaData.getColumnName(i), rs.getObject(i));
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			if (rs != null) try { rs.close(); } catch (Exception e) { }
			if (ps != null) try { ps.close(); } catch (Exception e) { }
			if (con != null) try { con.close(); } catch (Exception e) { }
		}
		return hashMap;
	}

	
	public List<Map<String, Object>> selectList(String sql) {
		List<Map<String, Object>> list = new ArrayList<>();
		try {
			con = DriverManager.getConnection(url, user, password);
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();

			ResultSetMetaData metaData = rs.getMetaData();
			int columnCount = metaData.getColumnCount();

			while (rs.next()) {
				HashMap<String, Object> row = new HashMap<>();
				for (int i = 1; i <= columnCount; i++) {
					row.put(metaData.getColumnName(i), rs.getObject(i));
				}
				list.add(row);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			if (rs != null) try { rs.close(); } catch (Exception e) { }
			if (ps != null) try { ps.close(); } catch (Exception e) { }
			if (con != null) try { con.close(); } catch (Exception e) { }
		}
		return list;
	}

	// DB연결 > 쿼리 실행 > ?값 입력 > rs에서 값 추출 > List<Map<String, Object>> 형태로 리턴
	public List<Map<String, Object>> selectList(String sql, List<Object> param) {
		List<Map<String, Object>> list = new ArrayList<>();

		try {
			con = DriverManager.getConnection(url, user, password);

			ps = con.prepareStatement(sql);
			for (int i = 0; i < param.size(); i++) {
				ps.setObject(i + 1, param.get(i));
			}

			rs = ps.executeQuery();
			ResultSetMetaData metaData = rs.getMetaData();
			int columnCount = metaData.getColumnCount();

			while (rs.next()) {
				HashMap<String, Object> row = new HashMap<>();
				for (int i = 1; i <= columnCount; i++) {
					row.put(metaData.getColumnName(i), rs.getObject(i));
				}
				list.add(row);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			if (rs != null) try { rs.close(); } catch (Exception e) { }
			if (ps != null) try { ps.close(); } catch (Exception e) { }
			if (con != null) try { con.close(); } catch (Exception e) { }
		}
		return list;
	}
	
	
	public int update(String sql){
		int result = 0;
		
		try {
			con = DriverManager.getConnection(url,user,password);
			ps = con.prepareStatement(sql);
			result = ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			if (rs != null) try { rs.close(); } catch (Exception e) { }
			if (ps != null) try { ps.close(); } catch (Exception e) { }
			if (con != null) try { con.close(); } catch (Exception e) { }
		}
		
		return result;
	}
	
	
	public int update(String sql, List<Object> param){
		int result = 0;
		
		try {
			con = DriverManager.getConnection(url,user,password);
			
			ps = con.prepareStatement(sql);
			for (int i = 0; i < param.size(); i++) {
				ps.setObject(i + 1, param.get(i));
			}
			
			result = ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			if (rs != null) try { rs.close(); } catch (Exception e) { }
			if (ps != null) try { ps.close(); } catch (Exception e) { }
			if (con != null) try { con.close(); } catch (Exception e) { }
		}
		
		return result;
	}
}
