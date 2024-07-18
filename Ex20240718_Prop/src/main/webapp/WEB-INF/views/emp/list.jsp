<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>emp/list</title>
<style>
	#t1{
		border-collapse: collapse;
		width: 400px;
	}
	#t1 caption{
		text-indent: -9999px;
		height: 0;
	}
	#t1 th, #t1 td{
		border: 1px solid black;
	}
	#t1 thead tr{
		background-color: #cdcdcd;
	}
</style>
  <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.3/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script src="https://code.jquery.com/jquery-3.7.1.js" ></script>
  <script src="https://code.jquery.com/ui/1.13.3/jquery-ui.js"></script>
    <script>
	  $( function() {
		$( ".dialog" ).dialog({
	      autoOpen: false,
	    });
		// 새로 생성한 요소에 대해서 접근하기 위해서
		// 부모의 이벤트를 받아 자식으로 구체화 시킨다.
		$( "#t1 tbody" ).on( "click", "tr", function() {
		      $( "#"+$(this).data("idx") ).dialog( "open" );
		    });
		
		
	  } );
  </script>
</head>
<body>
	<h1>사원목록</h1>
	<hr/>
	<div>
		<form action="emp/search" method="post">
			<select name="searchType" id="type">
				<option value="1">사원번호</option>
				<option value="2">사원명</option>
				<option value="3">직종</option>
				<option value="4">부서코드</option>
			</select>
			<input type="text" name="searchValue" id="value" />
			<button type="button" onclick="sendData(this.form)">검색</button>
		</form>
	</div>
	<br/>
		<table id="t1">
			<caption>사원목록테이블</caption>
			<thead>
				<tr>
					<th>사번</th>
					<th>사원명</th>
					<th>직종</th>
					<th>부서코드</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="evo" items="${e_ar }">
			<tr class='opener' data-idx='${evo.empno }'>
				<td>${evo.empno }</td>
				<td>${evo.ename}</td>
				<td>${evo.job }</td>
				<td>${evo.deptno }</td>
			</tr>
			
			<div id='${evo.empno }' class="dialog" title="사원 정보">
			  <p><strong>사번</strong>: ${evo.empno }<p>
			  <p><strong>사원명</strong>: ${evo.ename}<p>
			  <p><strong>직종</strong>: ${evo.job }<p>
			  <p><strong>부서코드</strong>: ${evo.deptno }<p>
			</div>
			
			</c:forEach>
			</tbody>
		</table>
 
 			

<script>

	function sendData(frm) {
		// 유효성 검사
		let keyword = $("#value").val().trim();
		if(keyword.length < 1 || keyword == ''){
			alert("검색어를 입력하세요")
			$("#value").val('');
			$("#value").focus();
			return;
		}
		
		// FormData는 파일을 보낼 때만 사용하자!
		
		$.ajax({
			url: "emp/search",
			data: {
				"searchType" : $("#type").val(),
				"searchValue" : $("#value").val(),
			},
			type: "post",
			dataType: "json",
		}).done(function(data){
			let e_ar = data.e_ar;
			let str = "";
			
// 			$("div").remove(".ui-dialog");
// 			$("div").remove(".dialog");
			
			for(let i=0; i<data.len; i++){
				str += "<tr class='opener' data-idx='"+e_ar[i].empno+"'>";
				str +=   "<td>";
				str +=     e_ar[i].empno;
				str +=   "</td>";
				str +=   "<td>";
				str +=     e_ar[i].ename;
				str +=   "</td>";
				str +=   "<td>";
				str +=     e_ar[i].job;
				str +=   "</td>";
				str +=   "<td>";
				str +=     e_ar[i].deptno;
				str +=   "</td>";
				str += "</tr>";
								
			}
			
			console.log(str);
			
			$("#t1 tbody").html(str);
			
		});
		
		
	}
</script>
</body>
</html>