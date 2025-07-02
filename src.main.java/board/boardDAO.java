package board;

import java.net.Authenticator.RequestorType;
import java.sql.*;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;

import common.DbClose;
import common.DbSet;

public class boardDAO {

	private static boardDAO dao = new boardDAO();
	
	// 싱글톤 >>  객체 dao가 존재하지 않을 때 생성, 존재 시 기존 dao 반환
	public static boardDAO getInstance(){					
		if (dao == null){													
			dao = new boardDAO();								
		}
		return dao;														
	}
	
	public String mTest01() {
		return ("Singletone Pattern Chk");
	}
	//------------------------------------------------------------------
	
	Connection conn;
	Statement stmt;
	PreparedStatement pstmt;
	ResultSet rs;
	//---------------------------------------Insert
	public int bodWrite(boardDTO dto) {
		int su = 0;
		try {
			conn = DbSet.getConnection();
			stmt = conn.createStatement();
			String sqlSel= "select max(num) as num from boardServlet"; // 가장 큰 num 값 select
			rs = stmt.executeQuery(sqlSel);
			int num = 1;
			if (rs.next()) {
				num = rs.getInt("num") + 1;
			}
			
			//  현재 시간 얻기
			String curTime = LocalDate.now() + " " + 
							  LocalTime.now().toString().substring(0, 8);
			
			String sqlIns = "insert into boardServlet (num, writer, title, content, regtime, hits) " +
			                "values (" + num + ", '" + dto.getWriter() + "', '" + dto.getTitle() + "', '" + 
			                dto.getContent() + "', '" + curTime + "', " + dto.getHits() + ")";

			su = stmt.executeUpdate(sqlIns);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(stmt, conn);
		}
		return su;
	}
	
	
	//---------------------------------------Select All
	public ArrayList<boardDTO> bodSelect(){

	    ArrayList<boardDTO> aryLst = new ArrayList<>();

	    try {
	        conn = DbSet.getConnection();
	        stmt = conn.createStatement();
	        String sql = "select num, writer, title, content, regtime, hits from boardServlet "
	        					 + "order by regtime desc"; // 최신순으로 조회
	        rs = stmt.executeQuery(sql);

	        int vNum, vHits;
	        String vWriter, vTitle, vContent, vRegtime;

	        if(rs != null) {
	            while (rs.next()) {
	                vNum = rs.getInt("num");
	                vWriter = rs.getString("writer");
	                vTitle = rs.getString("title");
	                vContent = rs.getString("content");
	                vRegtime = rs.getString("regtime");
	                vHits = rs.getInt("hits");

	                boardDTO dto = new boardDTO(vWriter, vTitle, vContent, vRegtime, vHits);
	                // num은 setter로 설정
	                dto.setNum(vNum);

	                aryLst.add(dto);
	            }
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        DbClose.close(rs, stmt, conn);
	    }
	    return aryLst;
	}
	
	//---------------------------------------특정 번호의 게시물만 select
	public boardDTO bodSelect(int num){

		boardDTO dto = null;
		
	    try {
	        conn = DbSet.getConnection();
	        stmt = conn.createStatement();
	        
	        int vNum, vHits;
	        String vWriter, vTitle, vContent, vRegtime;
	        
	        String sql = "select * from boardServlet "
	        					 + "where num=" + num;
	        rs = stmt.executeQuery(sql);

	      
	        if(rs != null) {
	            while (rs.next()) {
	                vNum = rs.getInt("num");
	                vWriter = rs.getString("writer");
	                vTitle = rs.getString("title");
	                vContent = rs.getString("content");
	                vRegtime = rs.getString("regtime");
	                vHits = rs.getInt("hits") + 1; 

	               // 조회수 +1 
	               stmt.executeUpdate("update boardServlet set hits=hits+1 where num=" + vNum);
	               
	               dto = new boardDTO(vWriter, vTitle, vContent, vRegtime, vHits);
	               dto.setNum(vNum);
	            }
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        DbClose.close(rs, stmt, conn);
	    }
	    return dto;
	}
	
	//-------------------------------------- delete
		public int bodDelete(boardDTO dto){
			 System.out.print("num1: " + dto.getNum());
			int su=0;
		    try {
		    	String sql = "delete from boardServlet where num=?";
		        
		    	conn = DbSet.getConnection();
		        pstmt = conn.prepareStatement(sql);
		        
		        pstmt.setInt(1, dto.getNum());
		        
		        su = pstmt.executeUpdate();
		    } catch (SQLException e) {
		        e.printStackTrace();
		    } finally {
		        DbClose.close((Statement)pstmt, conn);
		    }
		    return su;
		}
		
	//-------------------------------------- update
			public int bodUpdate(boardDTO dto){
				 System.out.print("num2: " + dto.getNum());
				int su=0;
			    try {
			    	String sql = "update boardServlet " +
			    						"set writer=?, title=?, content=?, regtime=?, hits=? "+ 
			    						"where num=?";
			        
			    	conn = DbSet.getConnection();
			        pstmt = conn.prepareStatement(sql);
			        
			        pstmt.setString(1, dto.getWriter());
					pstmt.setString(2, dto.getTitle());
					pstmt.setString(3, dto.getContent());
					pstmt.setString(4, dto.getRegtime());
					pstmt.setInt(5, dto.getHits());
					pstmt.setInt(6, dto.getNum());
					
			        su = pstmt.executeUpdate();
			    } catch (SQLException e) {
			        e.printStackTrace();
			    } finally {
			        DbClose.close((Statement)pstmt, conn);
			    }
			    return su;
			}
	
}