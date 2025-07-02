<%@page import="java.net.URLEncoder"%>
<%@page import="board.boardDAO"%>
<%@page import="java.time.*"%>
<%@page import="java.sql.*"%>
<%@page import="common.DbSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:useBean id="bodDTO" class="board.boardDTO"/>
	<jsp:useBean id="bodDAO" class="board.boardDAO"/>
	<%
	System.out.println("update : " + request.getParameter("num"));
		request.setCharacterEncoding("UTF-8");
		
		int num = Integer.parseInt(request.getParameter("num"));
		int su = bodDAO.bodUpdate(bodDTO);
		String sendPath = "";
		String ContextPath = request.getContextPath();
		
		if(su != 0) {
			sendPath = ContextPath + "/BoardV02/jsp/msgChk.jsp?msg=" + URLEncoder.encode("게시글 수정 완료", "UTF-8");
		} else {
			sendPath = ContextPath + "/BoardV02/jsp/msgChk.jsp?msg=" + URLEncoder.encode("게시글 수정 실패", "UTF-8");
		}
		response.sendRedirect(sendPath);
	%>
</body>
</html>