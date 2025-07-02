<%@page import="common.DbSet"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <link rel="stylesheet" href="./../css/boardWriteFrame.css">
    <meta charset="UTF-8">
    <title>boardWriteFrame.html</title>
    <script src="./../jas/boardWriteFrame.js"></script>
  </head>
  <body onload="mInit()">
  <% 
  	int vNo;
    String vWriter, vTitle, vRegTime, vHits, vContent;
    String currTitle = "** 게시판 글쓰기 **";
    // 글 번호 값 얻기, 주어지지 않았으면 0으로 설정
    String tmp = request.getParameter("num");
    vNo = (tmp != null && tmp.length() > 0) ? Integer.parseInt(tmp) : 0;
    
    Connection conn = DbSet.getConnection();
    Statement stmt = conn.createStatement();
    // 새 글쓰기 모드를 가정하고 변수 초기값 설정
     vWriter = ""; vTitle = ""; vContent="";
    
    // 글 번호가 주어졌으면, 글 수정 모드
    if(vNo > 0) {
    	String sql = "select * from boardServlet where num =" + vNo;
    	
    	ResultSet rs = stmt.executeQuery(sql);
    	
    	if(rs.next()) {
    		// 읽어들인 글 데이터를 변수에 저장
    		vWriter = rs.getString("writer");
    		vTitle = rs.getString("title");
    		vContent = rs.getString("content");
    		currTitle = "** 게시판 수정 **";
    	}
    }
  %>
    <br><br>
    <div id="wrapper">
        <form action="<%= request.getContextPath() %>/ControllerBoard.do" method="get">
			        
		  <input type="hidden" name="category" value="<%=request.getParameter("num") != null? "bodUpd" :"bodIns" %>"/>
		  <input type="hidden" name="num" value="<%=request.getParameter("num") != null? vNo : 0%>"/>
		  
          <div><%=currTitle %></div>
          <div id="list" onclick = "location.href='boardTitleListPaging.jsp'">
            [목록보기]
          </div>
          <table>
           <tr>
            <td class="td">Title</td>
            <td><input type="text" id="title" class="title"  name="title" onkeypress="line(this)" value="<%=vTitle %>"></td>
           </tr>
           <tr>
            <td class="td">Writer</td>
            <td colspan="3"><input type="text" class="title" name="writer" id="writer" onkeypress="line(this)" value="<%=vWriter %>"></td>
           </tr>
           <tr>
            <td class="td">Contents</td>
            <td colspan="3"><input type="text" class="contents" name="content"  id="content" onkeypress="line(this)" value="<%=vContent %>"></td>
           </tr>
          </table>
          <div>
            <input type="submit" value="<%=request.getParameter("num") != null? "Update" :"Write" %>" class="button" id="write" onkeypress="line(this)">
            <input type="button" value="Reset" class="button" onclick="mInit()" id="reset">
          </div>
        </form>
    </div>
  </body>
</html>