<%@page import="boardV02.BoardV02DTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

   <jsp:useBean id="boardDAO" class="boardV02.BoardV02DAO"/>
           	
	<%
		int bod_no = Integer.parseInt(request.getParameter("bod_no"));
		BoardV02DTO dto = boardDAO.bodSelect(bod_no);
		int su = 1;

	%>
<html lang="en">
  <head>
    <link rel="stylesheet" href="./../css/boardWriteFrame.css">
    <meta charset="UTF-8">
    <title>boardWriteFrame.html</title>
  </head>
  <body>
    <br><br>
    <div id="writeWrapper">
    <div id="bodTitle">** 게시판 수정하기 **</div>
    <jsp:include page="./../jsp/bodTop.jsp"></jsp:include>
        <form name="frm01" action="<%= request.getContextPath() %>/boardJstlMvcMybatis.do" method="get" >
        	<input	type="hidden" name="bod_no" value="<%=bod_no %>">
        	<input	type="hidden" name="category" value="bodUpd">        
        		
            <table class="writeTable">
        
           <tr>
            <td class="td">Writer</td>
            <td><input type="text"  id="bod_writer"  name="bod_writer" class="inWriter" value="<%= dto.getBod_writer() %>"></td>
            <td class="td">Passwd</td>
            <td><input type="text"  id="bod_pwd" name="bod_pwd"  class="inWriter"  value="<%= dto.getBod_pwd() %>"></td>
           </tr>
           <tr>
            <td class="td">Title</td>
            <td colspan="3"><input type="text" class="inTitle" id="bod_subject" name="bod_subject" value="<%= dto.getBod_subject() %>"></td>
           </tr>
           <tr>
	        <td class="td">Email</td>
	        <td colspan="3"><input type="text" class="inEmail" id="bod_email" name="bod_email" value="<%= dto.getBod_email() %>"></td>
           </tr>
           <tr>
            <td class="td">Contents</td>
            <td colspan="3"><input type="text"  class="contents" id="bod_content" name="bod_content" value="<%= dto.getBod_content() %>"></td>
           </tr>
          </table>
          <div class="BtnDiv">
            <input type="submit" value="Update" class="button" id="update" >
            <input type="button" value="Reset" class="button"  id="reset">
          </div>
        </form>
       <jsp:include page="bodBottom.jsp"></jsp:include>
    </div>
  </body>
</html>