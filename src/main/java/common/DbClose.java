package common;

import java.sql.Connection;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DbClose {
	// DML에 적용
	public static void close(Statement stmt, Connection conn) {
		try {
			 stmt.close();
			 conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	// DQL에 적용
	public static void close(ResultSet rs, Statement stmt, Connection conn) {
		try {
			 rs.close();
			 stmt.close();
			 conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
