<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	response.sendRedirect(request.getContextPath() + "/boardJstlMvcMybatis.do?category=boardTitleListMybatis&nowPage=0&nowBlock=0");
%>
</body>
</html>