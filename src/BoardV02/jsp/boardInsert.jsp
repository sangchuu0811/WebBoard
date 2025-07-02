<%@page import="board.boardDAO"%>
<%@page import="board.boardDTO"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.sql.*"%>
<%@page import="java.time.*"%>
<%@page import="common.DbSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert Process</title>
</head>
<body>
	<jsp:useBean id="bodDTO" class="board.boardDTO"/>
	<jsp:useBean id="bodDAO" class="board.boardDAO"/>
	<%
		request.setCharacterEncoding("UTF-8");
		
		bodDAO = boardDAO.getInstance();
	
		int su = bodDAO.bodWrite(bodDTO);
	
		String sendPath = "";
		String ContextPath = request.getContextPath();
	
		if(su != 0) {
			sendPath = ContextPath + "/BoardV02/jsp/msgChk.jsp?msg=" + URLEncoder.encode("게시글 추가 완료", "UTF-8");
		} else {
			sendPath = ContextPath + "/BoardV02/jsp/msgChk.jsp?msg=" + URLEncoder.encode("게시글 추가 실패", "UTF-8");
		}
		response.sendRedirect(sendPath);
	%>
</body>
</html>
