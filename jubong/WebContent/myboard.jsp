<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
   <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <script src="https://code.jquery.com/jquery-3.0.0.min.js"></script>
      <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.16/css/jquery.dataTables.css">
      <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.js"></script>
      <title>test</title>
   </head>
   <body>
      <script>
         $(document).ready(function() {
             $('#example').DataTable({
                pageLength: 10,
                bLengthChange: true,
                   lengthMenu: [[3, 5, 10, -1], [3, 5, 10, "All"]],
                   bAutoWidth: false,
                   bStateSave: true,
                   order: [0, "desc"]
             })
         });
     
      </script>
      <br>
      <br>
      <form action="search" method="post" id="search">
         <table cellpadding="0" cellspacing="0">
            <tr height="20">
               <td width="150"><p align=center>기간검색</p></td>
               <td width="500">&nbsp;&nbsp;&nbsp;
                  <input type="text" name="startDate" size="20" placeholder="yyyy-mm-dd" style="width:200px; height:25px">&nbsp;&nbsp; ~ &nbsp;&nbsp;
                  <input type="text" name="lastDate" size="20" placeholder="yyyy-mm-dd" style="width:200px; height:25px"></p></td>
            </tr>
            <tr height="20">
               <td width="150"><p align=center>검색</p></td>
               <td width="700">&nbsp;&nbsp;
                  <select id="type" name="type" style="width:80px; height:25px">
                     <option selected value="전체">전체</option>
                     <option value="제목">제목</option>
                     <option value="내용">내용</option>
                     <option value="작성자">작성자</option>
                  </select>
                  <input type="text" name="sValue" size="40" style="width:400px; height:25px">
                  <input type="submit" value="검색" style="width:100px; height:30px"></td>
            </tr>
         </table>
      </form>
      
      <br><br>
      
       <table id="example" cellpadding="0" cellspacing="0" border="1" width="3000">
         <thead>
            <tr height="50">
               <td width="50"><p align=center>번호</p></td>
               <td><p align=center>이름</p></td>
               <td><p align=center>제목</p></td>
               <td><p align=center>날짜</p></td>
               <td><p align=center>수정된 날짜</p></td>
               <td><p align=center>조회수</p></td>
            </tr>
         </thead>
         <tbody>
            <c:forEach items="${list}" var="dto">
               <tr>
                  <td width="50"><p align=center>${dto.bId}</p></td>
                  <td width="200">${dto.bName}</td>
                  <td><a href ="content_view?bId=${dto.bId}">${dto.bTitle}</a></td>
                  <td width="200"><p align=center>${dto.bDate}</p></td>
                  <td width="200"><p align=center>${dto.bUpDate}</p></td>
                  <td width="70"><p align=center>${dto.bHit}</p></td>
               </tr>
            </c:forEach>
         </tbody>
      </table>
      <input type="button" value="목록보기 " onClick="location.href ='list';">&nbsp;&nbsp;
         <input type="button" value="글작성" style= "width:100px; float:right;" onClick="location.href = 'write_view';">
    
<%-- 검 색 폼       
      <form action="search" method="post" id="search">
         <table width="1500" cellpadding="0" cellspacing="0" border="1">
            <tr>
               <td width="150"><p align=center>기간검색</p></td>
               <td width="300"><p align=center><input type="text" name="startDate" size="20" placeholder="yyyy-mm-dd" style="width:200px; height:25px">&nbsp;&nbsp; ~ &nbsp;&nbsp;
                              <input type="text" name="lastDate" size="20" placeholder="yyyy-mm-dd" style="width:200px; height:25px"></p></td>
               <td width="150"><p align=center>활성</p></td>
               <td width="250"><p align=center>
                  <select name="putup" style="width:200px; height:25px">
                     <option SELECTED value="전체">전체</option>
                     <option value="활성">활성</option>
                     <option value="비활성">비활성</option>
                  </select></p></td>
            </tr>
            <tr>
               <td width="150"><p align=center>검색</p></td>
               <td colspan=3>&nbsp;&nbsp;
                  <select id="type" name="type" style="width:80px; height:25px">
                     <option SELECTED value="전체">전체</option>
                     <option value="제목">제목</option>
                     <option value="내용">내용</option>
                     <option value="작성자">작성자</option>
                  </select>
                  <input type="text" name="sValue" size="40" style="width:800px; height:25px">
                  <input type="submit" value="검색" style="width:100px; height:30px">
               </td>
            </tr>
         </table>
      </form>
      
      <br><br>
--%>

<%--게시물 리스트
      <table width="1500" cellpadding="0" cellspacing="0" border="1">
         <tr>
            <td><p align=center>번호</p></td>
            <td><p align=center>이름</p></td>
            <td><p align=center>제목</p></td>
            <td><p align=center>날짜</p></td>
            <td><p align=center>수정된 날짜</p></td>
            <td><p align=center>히트</p></td>
         </tr>
         <c:forEach items="${list}" var="dto">
         <tr>
            <td width='50'><p align=center>${dto.bId}</p></td>
            <td>${dto.bName}</td>
            
            
            <td><a href ="content_view?bId=${dto.bId}">${dto.bTitle}</a></td>
            <td width='170'><p align=center>${dto.bDate}</p></td>
            <td width='170'><p align=center>${dto.bUpDate}</p></td>
            <td width='50'><p align=center>${dto.bHit}</p></td>
         </tr>
         </c:forEach>
         <tr>
            <td colspan="5" height='50'> <a href="write_view">글작성 </a> <h2><a href="list">목록보기</a></h2></td>
            
         </tr>
      </table>
       --%>
   </body>
</html>