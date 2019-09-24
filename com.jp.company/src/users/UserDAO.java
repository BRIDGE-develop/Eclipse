package users;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {

		private Connection conn;
		private PreparedStatement pstmt;
		private ResultSet rs;
		String driver = "oracle.jdbc.driver.OracleDriver"; 
		public UserDAO() {
			try {
				String dbURL = "jdbc:oracle:thin:@localhost:1521:orcl";
				String dbID = "bridge_admin";
				String dbPassword = "bridge1234";
				Class.forName(driver);
				conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		public int login(String userID, String userPassword) {
			String SQL = "select userPassword from users where userID = ?";
			try {
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, userID);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					if(rs.getString(1).equals(userPassword))
						return 1; //로그인 성공
					else 
						return 0; //비밀번호 틀림
				}
				return -1; //아디가 없음
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -2; //데이터베이스 오류
		}
		public int join(Users users) {
			String SQL = "insert into users values (?, ?, ?, ?, ?)";
			try {
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, users.getUserID());
				pstmt.setString(2, users.getUserPassword());
				pstmt.setString(3, users.getUserName());
				pstmt.setString(4, users.getUserEmail());
				pstmt.setString(5, users.getUserGender());
				return pstmt.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			return -1;
			
		}
		
}
