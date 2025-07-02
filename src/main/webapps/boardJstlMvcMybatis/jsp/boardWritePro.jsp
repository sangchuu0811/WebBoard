<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%request.setCharacterEncoding("UTF-8");%>

	<!--  useBean : 객체 생성 -->
	<jsp:useBean id="boardDTO" class="boardV02.BoardV02DTO"/>
	<jsp:useBean id="boardDAO" class="boardV02.BoardV02DAO"/>
	<jsp:setProperty name = "boardDTO" property="*"/>
	
	<%

		out.print("작성자 :  " + boardDTO.getBod_writer() +  "<br>");
		out.print("PWD :  " + boardDTO.getBod_pwd() +  "<br>");
		out.print("Title :  " + boardDTO.getBod_subject() +  "<br>");
		out.print("Email :  " + boardDTO.getBod_email() +  "<br>");
		out.print("Contents :  " + boardDTO.getBod_content() +  "<br>");
		String vIp = request.getRemoteAddr();
		out.print(vIp);
		out.print("</h1>");
	%>
</body>
</html>