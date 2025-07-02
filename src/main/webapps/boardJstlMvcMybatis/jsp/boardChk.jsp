<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <link rel="stylesheet" href="./../css/boardChk.css">
    <meta charset="UTF-8">
    <script src="./../jas/boardChk.js"></script>
  </head>
  <body onload="mInit()">
    <br><br>
    <div id="wrapper">
        <form>
          <table>
           <tr>
            <td class="td" >** 글을 남기실 때 입력하신 비밀번호를 입력하여 주십시오! **</td>
           </tr>
           <tr>
            <td><input type="password" id="passwd"></td>
           </tr>
           <tr>
            <td class="td">
              <input type="button" value="확인" class="button">
              <input type="button" value="방명록 쓰기" class="button"
              			   onclick="javascript:location.href ='boardChk.jsp'">
            </td>
           </tr>
          </table>
        </form>
    </div>
  </body>
</html>