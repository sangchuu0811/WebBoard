<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="org.apache.ibatis.session.SqlSessionFactoryBuilder"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="org.apache.ibatis.session.SqlSessionFactory"%>
<%@page import="org.apache.ibatis.io.Resources"%>
<%@page import="java.io.Reader"%>
<%@page import="java.sql.*"%>
<%@page import="common.DbSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="boardV02.BoardV02DTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/memV02DAO/boardJstlMvcMybatis/css/boardWriteFrame.css">
<meta charset="UTF-8">
</head>
<body>
      <jsp:useBean id="boardDAO" class="boardV02.BoardV02DAO"/>
		<br>
	    <div id="writeWrapper">
	    	<div id="bodTitle">** 게시판 내용 목록 **</div>
	
	    	<form id="bodFrm" method="post" action ="boardDelUpdChk.jsp">
	    		 <input type="hidden" name="bod_no" value="">
	    		<input type="hidden" name="bod_pwd" value="">
	    		<input type="hidden" name="category" value="">
	    	</form>
	    	
	    	<jsp:include page="bodTop.jsp"></jsp:include>
    	
        	<%
        	
        	Reader reader = Resources.getResourceAsReader("boardJstlMvcMybatis/mybatis-config.xml");
    		SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(reader); 
    		SqlSession session1 = sqlSessionFactory.openSession();

    		int totalRecord = 0;
    		int recPerPage = 2; 		// 페이지당 보여질 레코드 수
    		int pagePerBlock = 10; 		// 블럭당 보여질 페이지
    		
    		totalRecord = (Integer) session1.selectOne("boardSelAll");
    		
    		int totalPage = (int)Math.ceil((double)totalRecord / recPerPage); 		// 총 페이지 수
    		int totalBlock = (int)Math.ceil((double)totalPage / pagePerBlock); 	// 총 블럭 수 
    		
    		int nowPage = 0; // 현재 페이지 위치 (0부터 시작)
    		int nowBlock= 0; // 현재 블럭 위치 (0부터 시작)
    		
    		// nowPage, nowBlock 값 재수신
    		if (request.getParameter("nowPage") != null) {
    			nowPage = Integer.parseInt(request.getParameter("nowPage"));
    		}
    		
    		if(request.getParameter("nowBlock") != null) {
    			nowBlock = Integer.parseInt(request.getParameter("nowBlock"));
    		}
    		
    		int recOfBeginPage = nowPage * recPerPage;
    		int pageOfBeginBlock= nowBlock* pagePerBlock;

    		// 쿼리에 넣을 시작행과 마지막 행을 Map에 담아 전달
    		Map<String, Integer> pagingMap = new HashMap<String, Integer>();
    		pagingMap.put("startRow", recOfBeginPage + 1); 
    		pagingMap.put("endRow", (recOfBeginPage) + recPerPage); 
    		
    		ArrayList<BoardV02DTO> dtoList = (ArrayList) session1.selectList("boardSelPaging", pagingMap);
    		session1.close();

       		for(BoardV02DTO dto : dtoList) {
    	   		int bod_no = dto.getBod_no();
    	   	    String bod_writer = dto.getBod_writer();
    	   	    String bod_subject = dto.getBod_subject();
    	   	    String bod_logtime = dto.getBod_logtime();
    	   	    String bod_connIp = dto.getBod_connIp();
    	   	 	int bod_readCnt = dto.getBod_readCnt();
    	   	 	
    	   	 String contPath = request.getContextPath() + "/memV02DAO/boardJstlMvcMybatis/jsp/";
        	
           	%>
           	 	
           		<table class="writeTable">
           		 	<div id="contentList">
			            <span onclick="valSend('<%= dto.getBod_no()%>', '<%=dto.getBod_pwd()%>', 'upd')">[수정]</span>
			            <span onclick="valSend('<%=dto.getBod_no()%>', '<%=dto.getBod_pwd()%>', 'del')">[삭제]</span>
	          		</div>
		           <tr>
		            <td class="td">Writer</td>
		            <td class="input"><span id="writer" name="bod_writer"><%= dto.getBod_writer() %></span></td>
		            <td class="td">Date</td>
		            <td class="input"><span id="date" name="bod_logtime"><%=dto.getBod_logtime()%></span></td>
		           </tr>
		           <tr>
		            <td class="td">Title</td>
		            <td colspan="3" class="inTitle"><span id="title" name="bod_subject"><%= dto.getBod_subject() %></span></td>
		           </tr>
		           <tr>
		            <td class="td">Contents</td>
		            <td colspan="3" class="contents" ><span id="contents" name="bod_content"><%= dto.getBod_content() %></span></td>
		           </tr>
           	<%} %>
		       </table>
           	
           	<div class="pagination">
       		    <!--  ◀를 클릭했을 때 -------------------------------------------------->
       			<%
       				String controllerPath = request.getContextPath() + "/boardJstlMvcMybatis.do?category=";
       				if (nowBlock != 0) { 
       			%>
       				<a href="<%=controllerPath %>boardListMybatis&nowBlock=<%=nowBlock-1%>&nowPage=<%=(nowBlock-1)*pagePerBlock%>"
       					 class="page ">◀</a>
       			<%
       				} 
       			%>
       		
       			<!-- 페이지를 클릭했을 때  ------------------------------------------->
       			<%
       				for(int idx1 = pageOfBeginBlock; idx1 < pageOfBeginBlock + pagePerBlock; idx1++) {
       										// 시작 블럭의 페이지 값			 // 시작 블럭의 페이지 값  // 블럭 당 보여질 페이지
       			%>
       				<a href="<%=controllerPath %>boardListMybatis&nowBlock=<%=nowBlock%>&nowPage=<%= idx1%>"
       					 class="page <%= (nowPage == idx1)? "active": "" %>"> <!--  클릭한 페이지 active -->
       					 <%= idx1 + 1 %></a>
       			<%
	       				if(idx1 + 1 == totalPage){ 
	       					break;
	       				}
       				}
       			%>
       			
       			<!--  ▶를 클릭했을 때  -------------------------------------------->
       			<%
       				if(nowBlock + 1 < totalBlock){
       			%>
       				<a href="<%=controllerPath %>boardListMybatis&nowBlock=<%=nowBlock+1%>&nowPage=<%=(nowBlock+1)*pagePerBlock%>" class="page">▶</a>
       			<%
       				} else { }
       			%>
       		</div>
           
     </div>
         <script>
    	var obj = document.getElementById("bodFrm");
    	function valSend(no, pwd, category) {
    		obj.bod_no.value= no;
    		obj.bod_pwd.value= pwd;
    		obj.category.value= category;

    		obj.submit();
    	}
    </script>
</body>

</html>