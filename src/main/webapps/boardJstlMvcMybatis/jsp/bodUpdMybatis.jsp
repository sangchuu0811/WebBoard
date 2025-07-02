<%@page import="boardV02.BoardV02DTO"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.io.Reader"%>
<%@page import="org.apache.ibatis.session.SqlSessionFactoryBuilder"%>
<%@page import="org.apache.ibatis.session.SqlSessionFactory"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="org.apache.ibatis.io.Resources"%>
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
		String ContextPath = request.getContextPath();
		int bod_no = Integer.parseInt(request.getParameter("bod_no"));
		String bod_writer = request.getParameter("bod_writer");
		String bod_email = request.getParameter("bod_email");
		String bod_subject = request.getParameter("bod_subject");
		String bod_pwd = request.getParameter("bod_pwd");
		String bod_content = request.getParameter("bod_content");
		String bod_logtime = "";
		int bod_readCnt = 0;
		String bod_connIp = request.getRemoteAddr();
				
		
		BoardV02DTO bodDTO = new BoardV02DTO(bod_no, bod_writer, bod_email, bod_subject, bod_pwd, bod_logtime, bod_content, bod_readCnt, bod_connIp);
		
		Reader reader = Resources.getResourceAsReader("boardJstlMvcMybatis/mybatis-config.xml");
		SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(reader); 
		SqlSession session1 = sqlSessionFactory.openSession();
		int su = session1.update("boardUpd", bodDTO); // 반환형 int
		session1.commit();
		
		String msg="";
		if(su != 0) {
			msg = (bod_writer + "님 게시글 글 수정 성공"); // [ ] → Error		
		} else {
			msg = (bod_writer + "님 게시글 글 수정 실패"); 
		}
		
		msg = URLEncoder.encode(msg, "UTF-8"); // 한글 처리
		
		// 받아온 곳으로 넘겨주기
		// 전송할 때 : response
		response.sendRedirect(ContextPath + "/memV02DAO/boardJstlMvcMybatis/jsp/msgChk.jsp?msg=" + msg);
%>
</body>
</html>