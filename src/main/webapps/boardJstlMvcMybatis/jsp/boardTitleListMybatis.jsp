<%@page import="boardV02.BoardV02DTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.Reader" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="org.apache.ibatis.io.Resources" %>
<%@ page import="org.apache.ibatis.session.SqlSession" %>
<%@ page import="org.apache.ibatis.session.SqlSessionFactory" %>
<%@ page import="org.apache.ibatis.session.SqlSessionFactoryBuilder" %>
<!DOCTYPE html>
  <head>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/memV02DAO/boardJstlMvcMybatis/css/boardWriteFrame.css">
    <meta charset="UTF-8">
    <title>boardWriteFrame.html</title>
    <script src="./../jas/boardWriteFrame.js"></script>
  </head>
<body>
    <div id="TopWrapper">
          <br>
          <div id="bodTitle">** 게시판 목록 **</div>
          <jsp:include page="bodTop.jsp"></jsp:include>
          <form>
          
          <table class='writeTable'>
           <tr>
            <td class="titleTd">번호</td>
            <td class="titleTd">제목</td>
            <td class="titleTd">글쓴이</td>
            <td class="titleTd">등록일</td>
            <td class="titleTd">조회</td>
            <td class="titleTd">IP</td>
           </tr>
<%
		Reader reader = Resources.getResourceAsReader("boardJstlMvcMybatis/mybatis-config.xml");
		SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(reader); 
		SqlSession session1 = sqlSessionFactory.openSession();

		int totalRecord = 0;
		int recPerPage = 10; 		// 페이지당 보여질 레코드 수
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
		pagingMap.put("endRow", (recOfBeginPage+1) + recPerPage); 
		
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
		<tr id="tr2"  onClick = "javascript:location.href ='<%=contPath %>boardContentFrame.jsp?bod_no=<%= dto.getBod_no() %>'">
        	<td class="data"><%= bod_no %></td>
        	<td class="data"><%= bod_subject %></td>
        	<td class="data"><%= bod_writer %></td>
        	<td class="data"><%= bod_logtime %></td>
        	<td class="data"><%= bod_readCnt %></td>
        	<td class="data"><%= bod_connIp %></td>
        </tr>
<%		} 	%>
        </table>
          
       		<div class="pagination">
       		    <!--  ◀를 클릭했을 때 -------------------------------------------------->
       			<%
       				String controllerPath = request.getContextPath() + "/boardJstlMvcMybatis.do?category=";
       				if (nowBlock != 0) { 
       			%>
       				<a href="<%=controllerPath %>boardTitleListMybatis&nowBlock=<%=nowBlock-1%>&nowPage=<%=(nowBlock-1)*pagePerBlock%>"
       					 class="page ">◀</a>
       			<%
       				} 
       			%>
       		
       			<!-- 페이지를 클릭했을 때  ------------------------------------------->
       			<%
       				for(int idx1 = pageOfBeginBlock; idx1 < pageOfBeginBlock + pagePerBlock; idx1++) {
	       				if(idx1 >= totalPage){
	       					break;
	       				}
       			%>
       				<a href="<%=controllerPath %>boardTitleListMybatis&nowBlock=<%=nowBlock%>&nowPage=<%= idx1%>"
       					 class="page <%= (nowPage == idx1)? "active": "" %>"> <!--  클릭한 페이지 active -->
       					 <%= idx1 + 1 %></a>
       			<%
       				}
       			%>
       			
       			<!--  ▶를 클릭했을 때  -------------------------------------------->
       			<%
       				if(nowBlock + 1 < totalBlock){
       			%>
       				<a href="<%=controllerPath %>boardTitleListMybatis&nowBlock=<%=nowBlock+1%>&nowPage=<%=(nowBlock+1)*pagePerBlock%>" class="page">▶</a>
       			<%
       				} 
       			%>
       			
       		</div>
       		</form>
        
       <jsp:include page="bodBottom.jsp"></jsp:include>
    </div>
</body>
