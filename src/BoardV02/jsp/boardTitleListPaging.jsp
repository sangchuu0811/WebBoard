<%@page import="java.sql.*"%>
<%@page import="common.DbSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <link rel="stylesheet" href="./../css/boardTitleList.css">
    <meta charset="UTF-8">
    <title>borderTitleFrame.html</title>
    <script src="./../jas/boardTitleListPaging.js"></script>
  </head>
  <body>
    <br><br>
    <div id="wrapper">

   		<form>
          <div>**게시글 목록**</div>
          <div id="list">
            <span onclick="javascript:location.href ='boardWriteFrame.jsp'">[방명록 쓰기]</span>
            <span onclick="javascript:location.href ='boardTitleListPaging.jsp'">[목록보기]</span>
          </div>
          <table>
           <tr>
            <td class="td">번호</td>
            <td class="td">제목</td>
            <td class="td">글쓴이</td>
            <td class="td">등록일</td>
            <td class="td">조회</td>
           </tr>
          <%
             int vNo, totalRecord = 0;
    	     String vWrite, vTitle, vRegTime, vHits;
    	     ResultSet rs;
    	     PreparedStatement pstmt;
    	  
          	Connection conn = DbSet.getConnection();
            Statement stmt = conn.createStatement();
            
            rs = stmt.executeQuery("select count(*) from boardServlet"); 
            while (rs.next()) {
            	totalRecord = rs.getInt(1);
            }
            
            int recPerPage = 10; // 페이지당 보여질 레코드 수
            int pagePerBlock = 10; // 블럭당 보여질 페이지
            
            int totalPage = (int)Math.ceil((double)totalRecord / recPerPage); // 총 페이지 수
            int totalBlock = (int)Math.ceil((double)totalPage / pagePerBlock); // 총 블럭 수 
            
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
           				"from(select * from boardServlet order by num desc) innerQ ) outerQ " +
           				" where outerQ.rnum between ? and ?";
           
           pstmt = conn.prepareStatement(sql);
           
           pstmt.setInt(1, recOfBeginPage + 1);
           pstmt.setInt(2, (recOfBeginPage + 1) + recPerPage);
           
           rs = pstmt.executeQuery();
           //----------------------------------------------------------------------------
           for(int i= recOfBeginPage; i < recOfBeginPage + recPerPage; i ++) {
        	   if(i >= totalRecord){
        		   break;
        	   }
        	   rs.next();
	        	    vNo = rs.getInt("num");
		           	vWrite = rs.getString("writer");
		           	vTitle = rs.getString("title");
		           	vRegTime = rs.getString("regtime");
		           	vHits = rs.getString("hits");         
          %>        
         <!--  <tr id="tr2" onClick = "javascript:location.href ='boardViewFrame.jsp?num=<%= vNo %>' "> -->
         <tr id="tr2" onClick = "location.href='<%= request.getContextPath() %>/ControllerBoard.do?category=bodSel&num=<%= vNo %>'">
          	<th><%= vNo %></th><th><%= vTitle %></th>
          	<th><%= vWrite%></th><th><%= vRegTime %></th>
          	<th><%= vHits %></th>
          </tr>
        <%} %>
       </table>
       
       <div class="center">
       <!--  ◀를 클릭했을 때 -------------------------------------------------->
       		<div class="pagination">
       			<%
       				if (nowBlock != 0) { // 처음 블럭이 아니면 < 나옴
       			%>
       				<a href="boardTitleListPaging.jsp?nowBlock=<%=nowBlock-1 %>&nowPage=<%=(nowBlock-1) * pagePerBlock%>" class="page">◀</a>
       			<%
       				} // 현재 블럭과 페이지 category 값을 보내서 다시 nowBlock과 nowPage값을 받아올 수 있도록 한다
       			%>
       		
       		<!-- 페이지를 클릭했을 때  ------------------------------------------->
       			<%
       				for(int idx1 = pageOfBeginBlock; idx1 < pageOfBeginBlock + pagePerBlock; idx1++) {
       										// 시작 블럭의 페이지 값			 // 시작 블럭의 페이지 값  // 블럭 당 보여질 페이지
       			%>
       				<a href="boardTitleListPaging.jsp?nowBlock=<%=nowBlock %>&nowPage=<%= idx1 %>"
       					 class="page <%= (nowPage == idx1)? "active": "" %>"> <!--  클릭한 페이지 active -->
       					 <%= idx1 + 1 %></a>
       			<%
	       				if(idx1 + 1 == totalPage){ // 전체 페이지 값과 같으면 for문을 탈출
	       					break;
	       				}
       				}
       			%>
       			
       			<!--  ▶를 클릭했을 때  -------------------------------------------->
       			<%
       				if(nowBlock + 1 < totalBlock){
       			%>
       				<a href="boardTitleListPaging.jsp?nowBlock=<%=nowBlock+1 %>&nowPage=<%= (nowBlock+1)*pagePerBlock %>" class="page">▶</a>
       			<%
       				} else { }
       			%>
       		</div>
       </div>
      </form>
 	</div>
  </body>
</html>