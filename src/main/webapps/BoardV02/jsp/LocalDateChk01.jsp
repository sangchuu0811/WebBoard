<%@page import="java.time.*"%>
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
	LocalDate curDate = LocalDate.now();
	LocalTime curTime = LocalTime.now();
	
	// 로컬 현재 날짜와 시간을 불러옴 (시간은 0 ~ 8 인덱스까지 잘라냄)
	String curDateTime = LocalDate.now() + " " + LocalTime.now().toString().substring(0, 8);
	
	out.print("<h1 style='color:Orange'>");
	out.print("LocalDate.now() : " + curDate.toString() +  "<br>");
	out.print("LocalTime.now() : " + curTime.toString() +  "<br>");
	out.print(curDateTime + "<br>");
	out.print("<h1>");
%>
</body>
</html>