<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="boardV02.BoardV02DAO"%>
<%@page import="boardV02.BoardV02DTO"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
  <head>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/memV02DAO/boardJstlMvcMybatis/css/boardWriteFrame.css">
    <meta charset="UTF-8">
    <title>boardContentsFrame.html</title>
    <script src="./../jas/boardWriteFrame.js"></script>
  </head>
  <body>
    <br><br>
      <jsp:useBean id="boardDAO" class="boardV02.BoardV02DAO"/>
      
    		<%
    			int bod_no = Integer.parseInt(request.getParameter("bod_no"));
           		BoardV02DTO dto = boardDAO.bodSelect(bod_no);
           	%>         
           	
    <div id="writeWrapper">
    	<div id="bodTitle">** 게시판 내용 **</div>
    	
    	<form id="bodFrm" method="post" action ="boardDelUpdChk.jsp">
    		<input type="hidden" name="bod_no" value="">
    		<input type="hidden" name="bod_pwd" value="">
    		<input type="hidden" name="category" value="">
    		<input type="hidden" name="bod_writer" value="">
    	</form>
    	
    	<jsp:include page="bodTop.jsp"></jsp:include>
    	
    	   <div id="contentList">
            <span onclick="valSend('<%= dto.getBod_no()%>', '<%=dto.getBod_pwd()%>', 'upd', '<%= dto.getBod_writer() %>')">[수정]</span>
            <span onclick="valSend('<%= dto.getBod_no()%>', '<%=dto.getBod_pwd()%>', 'del', '<%= dto.getBod_writer() %>')">[삭제]</span>
          </div>
          
          
        <form action="boardDAOWritePro.jsp" method="get" >
           <table class="writeTable">
           <tr>
            <td class="td">글번호</td>
            <td class="input"><span id="no"  name="bod_no"><%= dto.getBod_no() %></span></td>
            <td class="td">조회수</td>
            <td class="input"><span id="readcnt" name="bod_readcnt"><%= dto.getBod_readCnt()%></span></td>
           </tr>
           <tr>
            <td class="td">Writer</td>
            <td class="input"><span id="writer" name="bod_writer"><%= dto.getBod_writer() %></span></td>
            <td class="td">Date</td>
            <td class="input"><span id="date" name="bod_logtime"><%=dto.getBod_logtime() %></span></td>
           </tr>
           <tr>
            <td class="td">Title</td>
            <td colspan="3" class="inTitle"><span id="title" name="bod_subject"><%= dto.getBod_subject() %></span></td>
           </tr>
           <tr>
	        <td class="td">Email</td>
	        <td colspan="3" class="inEmail"><span id="email" name="bod_email"><%= dto.getBod_email() %></span></td>
           </tr> 
           <tr>
            <td class="td">Contents</td>
            <td colspan="3" class="contents" ><span id="contents" name="bod_content"><%= dto.getBod_content() %></span></td>
           </tr>
          </table>
        </form>
        <jsp:include page="bodBottom.jsp"></jsp:include>
    </div>
    
    <script>
    	var obj = document.getElementById("bodFrm");
    	function valSend(no, pwd, category, writer) {
    		obj.bod_no.value= no;
    		obj.bod_pwd.value= pwd;
    		obj.category.value= category;
    		obj.bod_writer.value= writer;
    		
    		obj.submit();
    	}
    </script>
  </body>
</html>