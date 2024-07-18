<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>emp/list_ans</title>
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
	.modal_bg {
      
      display: none;
      width: 100%;
      height: 100%;
      position: fixed; 
      top: 0;
      left: 0;
      right: 0;
      background: rgba(0, 0, 0, 0.6);
      z-index: 999; 

   }
   
   .modal_wrap {
      
      display: none;
      position: absolute; 
      top: 50%;
      left: 50%;
      transform:translate(-50%,-50%);
      width: 400px;
      height: 400px;
      background: #fff;
      z-index: 1000; 

   }
   
   .modal_btn{
   	text-align: center;
    margin-top: 20px;
    margin-left: 10px;
    position: relative;
    bottom: 0;
    }
    
    header{
    text-align: center;
    }
    
   .table{
   border-collapse: collapse;
   width: 380px;
   margin: auto;
   }
   .table th, .table td {
   border: 1px solid black;
   padding: 4px;
   }
   .table thead tr{
   background-color: #cdcdcd;
   }
	
</style>
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
					<th>입사일</th>
					<th>부서코드</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="evo" items="${e_ar }">
			<tr>
				<td>${evo.empno }</td>
				<td>${evo.ename}</td>
				<td>${evo.job }</td>
				<td>${evo.hiredate }</td>
				<td>${evo.deptno }</td>
			</tr>
			
			</c:forEach>
			</tbody>
		</table>
    	<div class="modal_bg" onClick="javascript:popClose();"></div>
	   <div class="modal_wrap">
	   <header>
	   	<h2>사원 정보</h2>
	   </header>
	   	 <table class="table">
            <thead>
                <tr>
                    <th>사번</th>
                    <th>이름</th>
                    <th>직종</th>
                    <th>입사일</th>
                    <th>부서코드</th>
                </tr>
            </thead>
            <tbody></tbody>
        </table>
	      <button class="modal_btn modal_close" onClick="javascript:popClose();">닫기</button>
	   </div>
 
 			

<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script>

	$("#t1 tbody tr").click(function() {
		viewData(this);
	});
	
	function viewData(tr){
		// 클릭한 tr객체가 인자로 넘어온다.
		// 그 tr의 자식들(td들)을 얻어낸다.
		let td_ar = $(tr).children();
		let str = "<tr>";
		for(let i=0;i<td_ar.length;i++){
			str += "<td>";
			str += td_ar.eq(i).text();
			str += "</td>";
		}
		str += "</tr>"
		$(".table tbody").html(str);
		popOpen();
	}
	
	function popOpen(){
		var modalPop = $('.modal_wrap');
		var modalBg = $('.modal_bg');
		$(modalPop).show();
		$(modalBg).show();
	}

	function popClose(){
		var modalPop = $('.modal_wrap');
		var modalBg = $('.modal_bg');
		$(modalPop).hide();
		$(modalBg).hide();
	}

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
				str += "<tr onclick='viewData(this)'>";
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
				str +=     e_ar[i].hiredate;
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