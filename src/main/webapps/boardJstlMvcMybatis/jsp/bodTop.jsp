<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/memV02DAO/boardJstlMvcMybatis/css/bodTop.css">
    <meta charset="UTF-8">
    <title>borderTitleFrame.html</title>
    <script src="./../memJas/borderTitleFrame.js"></script>
  </head>
    <br>         
    <div id="list">
      <span onclick="location.href='<%= request.getContextPath() %>/boardJstlMvcMybatis.do?category=boardListMybatis'">[게시판 내용 List]</span>
      <span onclick="location.href='<%= request.getContextPath() %>/boardJstlMvcMybatis.do?category=boardTitleListMybatis'">[게시판 목록 List]</span>
      <span onclick="location.href='<%= request.getContextPath() %>/boardJstlMvcMybatis.do?category=boardWriteFrame'">[게시판 글쓰기]</span>
    </div>
    <hr id="topHr">
      
</html>