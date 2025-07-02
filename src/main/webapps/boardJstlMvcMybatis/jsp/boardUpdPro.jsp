<%@page import="java.net.URLEncoder"%>
<%@page import="boardV02.BoardV02DTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <!--  useBean : 객체 생성 -->
	<jsp:useBean id="boardDTO" class="boardV02.BoardV02DTO"/>
	<jsp:useBean id="boardDAO" class="boardV02.BoardV02DAO"/>
	<jsp:setProperty name = "boardDTO" property="*"/>
	
	<%
		request.setCharacterEncoding("UTF-8");
	
		BoardV02DTO dto = boardDAO.bodSelect(boardDTO.getBod_no()); // Msg 출력용 
		int su = boardDAO.bodUpdate(boardDTO);
		
		out.print(su);
		
		String msg="";
		if(su != 0) {
			msg = dto.getBod_writer() + "님 글 수정 완료!!";
		} else {
			msg = dto.getBod_writer() + "님 글 수정 오류 입니다!!";
		}
		String vURL = "./msgChk.jsp?msg=" + URLEncoder.encode(msg, "UTF-8");
		response.sendRedirect(vURL);
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>