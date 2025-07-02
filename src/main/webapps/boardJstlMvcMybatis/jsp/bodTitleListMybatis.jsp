<%@page import="java.sql.*"%>
<%@page import="boardV02.BoardV02DTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="common.DbSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/memV02DAO/boardJstlMvcMybatis/css/boardWriteFrame.css">
    
    <meta charset="UTF-8">
    <title>borderTitleFrame.html</title>
  </head>
  <body>
  	<jsp:useBean id="boardDAO" class="boardV02.BoardV02DAO"/>
    <br>
    <div id="TopWrapper">
        
          <div id="bodTitle">** 게시글 목록 **</div>
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
           		//------페이징-------------------------------------------------------
           		int vNo, vCnt;
           		String vSubject, vWriter, vTime, vIp;
           		
           		int vNum=0, totalRecord = 0;
           		
	    	    ResultSet rs;
	    	    PreparedStatement pstmt;
           	
	    	    Connection conn = DbSet.getConnection();
	            Statement stmt = conn.createStatement();
	             
	            rs = stmt.executeQuery("select count(*) from boardV02"); 
	            while (rs.next()) {
	             	totalRecord = rs.getInt(1);
	            }
	             
	            int recPerPage = 10; 			// 페이지당 보여질 레코드 수
	            int pagePerBlock = 10; 		// 블럭당 보여질 페이지
	             
	             int totalPage = (int)Math.ceil((double)totalRecord / recPerPage); 		// 총 페이지 수
	             int totalBlock = (int)Math.ceil((double)totalPage / pagePerBlock); 	// 총 블럭 수 
	             
	             int nowPage = 0; // 현재 페이지 위치
	             int nowBlock= 0; // 현재 블럭 위치
	             
	             // nowPage, nowBlock 값 재수신
	             if (request.getParameter("nowPage") != null) {
	             	nowPage = Integer.parseInt(request.getParameter("nowPage"));
	             }
	             
	             if(request.getParameter("nowBlock") != null) {
	             	nowBlock = Integer.parseInt(request.getParameter("nowBlock"));
	             }
	             
	             int recOfBeginPage = nowPage * recPerPage;
	             int pageOfBeginBlock= nowBlock* pagePerBlock;
	             
	             String sql = "select outerQ.* from " + 
   						 "(select rownum as rnum, innerQ.* " +
   						 "from(select * from boardV02 order by bod_no desc) innerQ ) outerQ " +
   						 " where outerQ.rnum between ? and ?";

			   pstmt = conn.prepareStatement(sql);
			   
			   pstmt.setInt(1, recOfBeginPage + 1);
			   pstmt.setInt(2, (recOfBeginPage + 1) + recPerPage);
			   
			   rs = pstmt.executeQuery();
           	//-----------------------------------------------------------------------------
           	for(int idx= recOfBeginPage; idx < recOfBeginPage + recPerPage; idx ++) {
        	   if(idx >= totalRecord){
        		   break;
        	   }
        	   rs.next();  				
	  				BoardV02DTO dto = new BoardV02DTO();
	 	    	   // rs값을 dto객체에 set : bean 적용
	 	    	   dto.setBod_no(rs.getInt("bod_no"));
	 	    	   dto.setBod_content(rs.getString("bod_content"));
	 	    	   dto.setBod_subject(rs.getString("bod_subject"));
	 	    	   dto.setBod_writer(rs.getString("bod_writer"));
	 	    	   dto.setBod_logtime(rs.getString("bod_logtime"));  		
	 	    	  dto.setBod_connIp(rs.getString("bod_connip"));  
	 	    	  
	 	    	  String contPath = request.getContextPath() + "/memV02DAO/boardJstlMvcMybatis/jsp/";
           	%>  
           	
           	<tr id="tr2"  onClick = "javascript:location.href ='<%=contPath %>boardContentFrame.jsp?bod_no=<%= dto.getBod_no() %>'">
           		<td class="data"><%= dto.getBod_no() %></td><td class="data"><%= dto.getBod_subject() %></td><td class="data"><%= dto.getBod_writer() %></td><td class="data"><%= dto.getBod_logtime() %></td>
           		<td class="data"><%= dto.getBod_readCnt() %></td><td class="data"><%= dto.getBod_connIp() %></td>
           	</tr>
    <%} %>
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
       										// 시작 블럭의 페이지 값			 // 시작 블럭의 페이지 값  // 블럭 당 보여질 페이지
       			%>
       				<a href="<%=controllerPath %>boardTitleListMybatis&nowBlock=<%=nowBlock%>&nowPage=<%= idx1%>"
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
       				<a href="<%=controllerPath %>boardTitleListMybatis&nowBlock=<%=nowBlock+1%>&nowPage=<%=(nowBlock+1)*pagePerBlock%>" class="page">▶</a>
       			<%
       				} else { }
       			%>
       			</form>
       		</div>
       		
        
       <jsp:include page="bodBottom.jsp"></jsp:include>
    </div>
  </body>
</html>