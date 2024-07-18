<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>dept/list</title>
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
</head>
<body>
	<h1>부서목록</h1>
	<hr/>
	<div>
		<form action="dept/search" method="post">
			<select name="searchType" id="type">
				<option value="1">부서번호</option>
				<option value="2">부서명</option>
				<option value="3">도시코드</option>
			</select>
			<input type="text" name="searchValue" id="value" />
			<button type="button" onclick="sendData(this.form)">검색</button>
		</form>
	</div>
	<br/>
		<table id="t1">
			<caption>부서목록테이블</caption>
			<thead>
				<tr>
					<th>부서코드</th>
					<th>부서명</th>
					<th>도시코드</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="dvo" items="${d_ar }">
			<tr>
				<td>${dvo.deptno }</td>
				<td>${dvo.dname }</td>
				<td>${dvo.loc_code }</td>
			</tr>
			</c:forEach>
			</tbody>
		</table>

<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
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
		
		// 보내기
		// frm.submit();
		
		// FormData는 파일을 보낼 때만 사용하자!
		// let data = new FormData();
		// data.append("searchType",frm.searchType.value);
		// data.append("searchValue",frm.searchValue.value);
		
		
		$.ajax({
			url: "dept/search",
			data: {
				"searchType" : $("#type").val(),
				"searchValue" : $("#value").val(),
			},
			type: "post",
			dataType: "json",
		}).done(function(data){
			$("#t1 tbody").html("");
			let d_ar = data.d_ar;
					for(let i=0; i<data.len; i++){
			$("#t1 tbody").html(
					$("#t1 tbody").html()+
					"<tr>"+
					"<td>"+d_ar[i].deptno+"</td>"+
					"<td>"+d_ar[i].dname+"</td>"+
					"<td>"+d_ar[i].loc_code+"</td>"+
					"</tr>"
					);
					}
		});
		
		
	}
</script>
</body>
</html>