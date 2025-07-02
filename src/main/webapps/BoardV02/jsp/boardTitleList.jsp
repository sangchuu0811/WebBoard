<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="common.DbSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <link rel="stylesheet" href="./../css/boardTitleList.css">
    <meta charset="UTF-8">
    <title>borderTitleFrame.html</title>
    <script src="./../jas/borderTitleFrame.js"></script>
  </head>
  <body onload="mInit()">
    <br><br>
    <div id="wrapper">
    <% int vNo;
    	  String vWrite, vTitle, vRegTime, vHits;
    %>
   		<form>
          <div>**Board Title List**</div>
          <div id="list">
            <span onclick="javascript:location.href ='boardWriteFrame.jsp'">[방명록 쓰기]</span>
            <span>[방명록 내용 List]</span>
          </div>
          <table>
           <tr>
            <td class="td">번호</td>
            <td class="td">제목</td>
            <td class="td">글쓴이</td>
            <td class="td">등록일</td>
            <td class="td">조회</td>
           </tr>
           <!-- 
           <tr>
            <td class="data">1</td>
            <td class="data">행복한 하루입니다</td>
            <td class="data">오렌지</td>
            <td class="data">2025-04-04 17:23:58</td>
            <td class="data">0</td>
            <td class="data">192.168.0.205</td>
           </tr>
           -->
          <!-- </table>-->
          <%
          	Connection conn = DbSet.getConnection();
            Statement stmt = conn.createStatement();
            String sql = "select * from board order by num desc";
            
            ResultSet rs = stmt.executeQuery(sql);
            
            while(rs.next()) {
            	vNo = rs.getInt("num");
            	vWrite = rs.getString("writer");
            	vTitle = rs.getString("title");
            	vRegTime = rs.getString("regtime");
            	vHits = rs.getString("hits");
          %>
          
          <tr id="tr2" onClick = "javascript:location.href ='boardViewFrame.jsp?num=<%= vNo %>' ">
          	<th><%= vNo %></th><th><%= vTitle %></th>
          	<th><%= vWrite%></th><th><%= vRegTime %></th>
          	<th><%= vHits %></th>
          </tr>
                <%} %>
       </table>
      </form>
 	</div>
  </body>
</html>