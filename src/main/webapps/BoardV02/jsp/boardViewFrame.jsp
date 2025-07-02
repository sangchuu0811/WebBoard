<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="common.DbSet"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/BoardV02/css/boardViewFrame.css">
    <meta charset="UTF-8">
    <title>guestWriteFrame.html</title>
    <script src="./../jas/boardViewFrame.js"></script>
  </head>
  <body onload="mInit()"> 
  	<jsp:useBean id="bodDTO" class="board.boardDTO"/>
	<jsp:useBean id="bodDAO" class="board.boardDAO"/>
    <br><br>
    <div id="wrapper">
        <form>
          <div>**Board View**</div>
          <%
          	int vNo = 0,  vHits = 0;
          	String vWriter="", vTitle ="", vRegTime = "", vContent="", temp="";
          	
          	Connection conn = DbSet.getConnection();
          	Statement stmt = conn.createStatement();
          	temp = request.getParameter("num");
          	if(temp != null) {
          		vNo = Integer.parseInt(temp);
          	}
          	
          	String cookieName = "recent";
    	 	Cookie cookie = new Cookie(cookieName, temp); // Cookie 생성
    	 	cookie.setMaxAge(60*2);							// 유지시간 : 2분
    	 	response.addCookie(cookie);						// 응답 시 저장
    	 													// → ① + ② (생성 ~ 저장)
          	%>
          <div id="list">
            <span onclick="location.href='<%= request.getContextPath() %>/BoardV02/jsp/boardWriteFrame.jsp?num=<%= vNo %>'">[수 정]</span>
			<span onclick="location.href='<%= request.getContextPath() %>/ControllerBoard.do?category=bodDel&num=<%= vNo %>'">[삭 제]</span>
            <span onclick="location.href='<%= request.getContextPath() %>/BoardV02/jsp/boardTitleListPaging.jsp'">[목록보기]</span>
          </div>
          <table>
           <tr>
            <td class="td">글번호</td>
            <td class ="input"><span id="no">${bodSel.num}</span></td>
            <td class="td">조회수</td>
            <td  class ="input"><span id="hits">${bodSel.hits}</span></td>
           </tr>
           <tr>
            <td class="td">Writer</td>
            <td  class ="input"><span id="writer">${bodSel.writer}</span></td>
            <td class="td">Date</td>
            <td  class ="input"><span id="date">${bodSel.regtime}</span></td>
           </tr>
           <tr>
            <td class="td">Title</td>
            <td colspan="3"  class ="input"><span id="title">${bodSel.title}</span></td>
           </tr>
           <tr>
            <td class="td">Contents</td>
            <td colspan="3"  class ="contents"><span id="contents">${bodSel.content}</span></td>
           </tr>
          </table>

        </form>
    </div>
  </body>
</html>