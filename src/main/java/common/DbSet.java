package common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbSet {
	// 드라이버 로드 및 계정 접속 확인
	public static Connection getConnection() {
		String vURL = "jdbc:oracle:thin:@localhost:1521:XE";
		String vID = "hr";
		String vPWD = "hr";
		
			try {
				Class.forName("oracle.jdbc.driver.OracleDriver");
				Connection conn = DriverManager.getConnection(vURL, vID, vPWD);
				return conn;
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			return null;
	}
}
