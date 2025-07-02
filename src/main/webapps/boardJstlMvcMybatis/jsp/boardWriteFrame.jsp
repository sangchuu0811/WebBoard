<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
  <head>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/memV02DAO/boardJstlMvcMybatis/css/boardWriteFrame.css">
    <meta charset="UTF-8">
    <title>boardWriteFrame.html</title>
    <script src="./../jas/boardWriteFrame.js"></script>
  </head>
  <body>
    <br>
    <div id="writeWrapper">
    	<div id="bodTitle">** 게시판 글쓰기 **</div>
    	<jsp:include page="bodTop.jsp"></jsp:include>
    	<form action="<%= request.getContextPath() %>/boardJstlMvcMybatis.do" method="get">
    		<input type="hidden" name="category" value="bodIns"/>
    		
           <table class="writeTable">
           <tr>
            <td class="td">Writer</td>
            <td><input type="text"  id="bod_writer" class="inWriter" name="bod_writer"></td>
            <td class="td">Passwd</td>
            <td><input type="password"  id="bod_pwd"  class="inWriter" name="bod_pwd"></td>
           </tr>
           <tr>
            <td class="td">Title</td>
            <td colspan="3"><input type="text" class="inTitle" id="bod_subject" name="bod_subject"></td>
           </tr>
           <tr>
	        <td class="td">Email</td>
	        <td colspan="3"><input type="text" class="inEmail" id="bod_email" name="bod_email"></td>
           </tr>
           <tr>
            <td class="td">Contents</td>
            <td colspan="3"><input type="text"  class="contents" id=bod_content name="bod_content"></td>
           </tr>
          </table>
          <div class="BtnDiv">
            <input type="submit" value="Write" class="button" id="write" >
            <input type="button" value="Reset" class="button" id="reset">
          </div>
        </form>
        
        
        <jsp:include page="bodBottom.jsp"></jsp:include>
    </div>
  </body>
</html>