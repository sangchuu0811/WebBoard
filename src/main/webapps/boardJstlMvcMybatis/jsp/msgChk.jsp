<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <link rel="stylesheet" href="./../css/msgChkFrame.css">
    <meta charset="UTF-8">
    <title>msgChk.html</title>
    <%
    	request.setCharacterEncoding("UTF-8");
    	String vMsg = request.getParameter("msg");
    	if(vMsg == null) {
    		vMsg = "Message Chk";
    	}
    %>
  </head>
  <body>
  	  <header>
	  </header>
	  <main>
		    <div id="TopWrapper">
		    <jsp:include page="bodTop.jsp"></jsp:include>
			    <table>
			      <tr>
			        <td>Message</td>
			      </tr>
			      <tr>
			        <td class="msg"><%= vMsg %></td>
			      </tr>
			    </table>
			</div>
	</main>

  </body>
</html>