<%@page import="java.net.URLEncoder"%>
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
		String msg = "";
		String vURL = "";
		
	 	if(boardDTO.getBod_writer() != null) {
	 		String vIP = request.getRemoteAddr();
	 		out.print(vIP);
	 		boardDTO.setBod_connIp(vIP);
	 		out.print("<br> MV 수정 Chk : " + boardDTO.getBod_connIp());
	 		
	 		int su = boardDAO.bodWrite(boardDTO);
	 		out.print(su);
	 		
	 		if( su != 0) {
	 			msg = boardDTO.getBod_writer() + "님 글 등록 완료!!";
	 		} else {
	 			msg = boardDTO.getBod_writer() + "님 글 등록 오류입니다!!";
	 		}
	 		
	 		vURL = "./msgChk.jsp?msg=" + URLEncoder.encode(msg, "UTF-8");
	 		response.sendRedirect(vURL);
	 	}else{
	 		msg = "등록하지 않은 값이 있습니다.";
	 		vURL = "./msgChk.jsp?msg=" + URLEncoder.encode(msg, "UTF-8");
	 		response.sendRedirect(vURL);
	 	}
	%>
</body>
</html>