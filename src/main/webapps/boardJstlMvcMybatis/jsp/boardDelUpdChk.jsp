<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <link rel="stylesheet" href="./../css/boardChk.css">
    <meta charset="UTF-8">
  </head>
  <body onload="mInit()">
      <%
      	request.setCharacterEncoding("UTF-8");
      
      	String contextPath = request.getContextPath(); // URI 값 반환
      	String vURL = null;
      	
      	int vNo = 0;
      	String vNos = request.getParameter("bod_no");
      	String vPwd = request.getParameter("bod_pwd");
      	String vCategory = request.getParameter("category");
      	String vWriter = request.getParameter("bod_writer");
      	
      	if(vNos != null) {
      		vNo = Integer.parseInt(request.getParameter("bod_no"));
      		
      		if(vCategory.equals("del")) {
      			vURL = contextPath + "/boardJstlMvcMybatis.do?category=bodDel";
      		} else if(vCategory.equals("upd")) {
      			vURL = contextPath + "/memV02DAO/boardJstlMvcMybatis/jsp/boardUpdFrame.jsp";
      		}
      	}
      %>
      
    <br><br>
    <div id="wrapper">
	<div id="bodTitle">** 게시판 체크 **</div>
    <jsp:include page="bodTop.jsp"></jsp:include>
        <form name = "frm01" id="frm01" method="post" onsubmit="return false">
        	<input type="hidden" name="bod_no" value="">
        	<input type="hidden" name="bod_writer" value="">
        	
          <table id="chkTable">
           <tr>
            <td class="chkTd" >** 글을 남기실 때 입력하신 비밀번호를 입력하여 주십시오! **</td>
           </tr>
           <tr>
            <td><input type="password" id="passwd" name="bod_pwd"></td>
           </tr>
           <tr>
            <td class="chkTd">
              <input type="button" value="확인" class="button" onclick = "mPwdChkSend()">
              <input type="button" value="게시판 쓰기" class="button"
              			   onclick="javascript:location.href ='boardWriteFrame.jsp'">
            </td>
           </tr>
           <tr id="bodMsg">
           	<td><input type="text"  id="resultInput" class="resultChk" value="" /></td>
           </tr>
          </table>
        </form>
         <jsp:include page="bodBottom.jsp"></jsp:include>
    </div>
    <script src="./../jas/jquery-3.7.1.js"></script>
	<script>
		let frmChk;
		let bodMsg;
	
		function mInit() {
		    passwd =  document.getElementById("passwd");
		    passwd.value = "";
		    passwd.focus();
		}
	
		function mPwdChkSend(){
			frmChk = document.forms.frm01;
			bodMsg = document.getElementById("bodMsg");
			
			if(frmChk.bod_pwd.value != "<%=vPwd%>") {
				bodMsg.innerHTML ="<b>▶ 비밀번호가 일치하지 않습니다 !! ◀";
				frmChk.bod_pwd.select(); // 입력창 블럭 커서 지정
			} else {
				bodMsg.innerHTML = "<b> ▶ 비밀번호가 일치 : 클릭 시 이동 ◀";
				bodMsg.style.cursor = "pointer"; // 커서 포인터
				frmChk.bod_no.value = "<%=vNo%>";
				frmChk.bod_pwd.value = "<%=vPwd%>";
				frmChk.bod_writer.value = "<%=vWriter%>";
				frmChk.action = "<%=vURL%>";
			}
		}
		
		$("#bodMsg").on('click', ()=>{ // id가 bodMsg인 요소에 클릭 리스너 적용
			frmChk.submit(); 					// 폼 제출
		})	
	</script>
  </body>
</html>