<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>자유게시판</title>
<meta charset="utf-8">
<!-- <meta name="viewport" content="width=device-width, initial-scale=1"> -->
<link rel="stylesheet"href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script> -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="/css/company/companyinfo.css">
<style>
/* Set height of the grid so .sidenav can be 100% (adjust if needed) */
 .row.content {height:1500px} 

/* Set gray background color and 100% height */
.sidenav {
	width : 20%;
	background-color: #f1f1f1;
	height: 100%; 
	position: fixed;
}
.body{

	margin-left : 25%;
}
/* On small screens, set height to 'auto' for sidenav and grid */
 @media screen and (max-width: 767px) {
	.sidenav {
		width : 20%;
		height: auto;
		padding: 15px;
		position: fixed;
	}
	.row.content {
		height: auto;
	} 
}
</style>
<script>
$(document).ready(function(){
	
	
	//게시글 등록
	$('#submitBtn').click(function(){
		//유효성검사
		console.log("카테고디"+$('#freeboardCateCd > option:selected').val());
		if($('#sessionId').val()==""||$('#sessionId').val()==null){
			location.href="/memberGeneralLogin";
		}else if($('#freeboardContent').val()==""){
			$('#freeboardContent').focus();
		}else if($('#freeboardTitle').val()==""){
			$('#freeboardTitle').focus();
		}else if($('#freeboardCateCd > option:selected').val()==""){
			$('#freeboardCateCd').focus();
			$('#insertError').text(' * 카테고리를 선택하세요 ');
		}else{
			$('#boardInsertForm').submit();
		}
		
	});
	
	
	//검색어  
	$('#searchBoardBtn').click(function(){
		if($('#cateFromServer').val()==""){
			location.href="/freeboardList?boardSearch="+$('#boardSearchKeyword').val();
		}else if($('#cateFromServer').val()!=""){
			location.href="/freeboardList?boardSearch="+$('#boardSearchKeyword').val()
					+"&cate="+$('#cateFromServer').val();
		}		
	});
	$('#boardSearchKeyword').change(function(){
		
		if($('#cateFromServer').val()==""){
			location.href="/freeboardList?boardSearch="+$('#boardSearchKeyword').val();
		}else if($('#cateFromServer').val()!=""){
			location.href="/freeboardList?boardSearch="+$('#boardSearchKeyword').val()
					+"&cate="+$('#cateFromServer').val();
		}		
	});
	
	
	//리플 
	$('.replyBtn').click(function(){
		
		var order = $('.replyBtn').index(this)
		console.log("order : "+order)
		$('.replyContent').eq(order).val().replace(/\n/g, "<br>")
 		if($('#sessionId').val()==""||$('#sessionId').val()==null){
 			location.href="/memberGeneralLogin";
 			console.log("1번")
		}else if($('.replyContent').eq(order).val()==""){
			$('.replyContent').eq(order).focus();
			console.log("2번")
		}else{
			location.href="/freeboardReply?freeboardCd="+$('.replyHidden').eq(order).val()
					+"&replyContent="+$('.replyContent').eq(order).val();
			console.log("3번")
		}
	});
	
	
	//댓글수정 
	var hiddenReplyCd;
	$('.updateReply').click(function(){
		var index = $('.updateReply').index(this);
		var oldReply = $('#hiddenReply').val();
		hiddenReplyCd = $('.hiddenReplyCd').eq(index).val();
		$('.replyUpdateForm').eq(index).replaceWith(
				'<table>'
					+'<tr>'
						+'<td>'
						+'<div class="input-group">'
						+'   <textarea class="form-control " id="updating" cols="120" rows="2" style="resize:none"  required></textarea>'     
						+'   <span class="input-group-addon btn btn-primary" id="updateFinish">수정완료</span>'
						+'</div>'
						+'</td>' 
					+'</tr>'
				+'</table>');
		$('#updating').text(oldReply);
	});
	$(document).on('click','#updateFinish',function(){ 
		var repleCd = hiddenReplyCd;
		if($('#updating').val()==""){
			$('#updating').focus()
		}else{
			location.href='/freeboardReplyUpdate?replyContent='+$('#updating').val()+'&replyCd='+repleCd;
		}
	});
	
	
	//게시글 수정
	$('.boardContentUpdate').click(function(){
		
		var index =$('.boardContentUpdate').index(this)
		var freeCate=$('.freeCate').eq(index).text();
		var freeTitle=$('.freeTitle').eq(index).text();
		var freeContent=$('.freeContent').eq(index).text();
		var replyHidden = $('.replyHidden').eq(index).val();
		
		$('.ContentUpdateForm').eq(index).replaceWith(
				'<table>'
				+'<input type="hidden" id="hiddenCd">'
				+'<tr>'
				+'<td>'	
					+'<select class="form-control" name="freeboardCateCd" id="updateCateCd">'
						+'<option value="">카테고리선택</option>'
						+'<option value="1">잡담</option>'
						+'<option value="2">근무환경</option>'
						+'<option value="3">자소서</option>'
						+'<option value="4">인적성</option>'
						+'<option value="5">자격증</option>'
						+'<option value="6">어학</option>'
					+'</select>'
				+'</td>'
				+'<td width="80%" colspan="2">'
				+'<input type="text" name="freeboardTitle" id="updateTitle" class="form-control" rows="1" required >'
				+'</td>'
				+'</tr>'
				+'<tr>'
				+'<td colspan="3">'
					+'<br>'
						+'<textarea name="updateContent" id="updateContent" class="form-control" rows="3" required ></textarea>'
						+'<br>'
				+'</td>'	
				+'</tr>'
				+'<tr>'
				+'<td colspan="3">'
					+'<center><a id="updateBtn" class="btn btn-default">수정완료</a></center>'
					+'<span id="updateError"></span>'
				+'</td>'
				+'</tr>'
				+'</table>');
		$('#updateTitle').val(freeTitle);
		$('#updateContent').text(freeContent);
		$('#hiddenCd').val(replyHidden);
	});
	$(document).on('click','#updateBtn',function(){ 
		if($('#updateTitle').val()==""){
			$('#updateTitle').focus();
		}else if($('#updateContent').val()==""){
			$('#updateContent').focus();
		}else if($('#updateCateCd option:selected').text()=="카테고리선택"||$('#updateCateCd option:selected').text()==""){
			$('#updateCateCd').focus();
		}else{
			location.href='/freeboardContentUpdate?freeboardTitle='+$('#updateTitle').val()+'&freeboardContent='+$('#updateContent').val()+'&freeboardCateCd='+$('#updateCateCd option:selected').text()+'&cd='+$('#hiddenCd').val();	
		}
		
	});
	
	//북마크 여부 
	var listOfBookmark = new Array();
	<c:forEach items="${bookmarkList}" var="bookmarkList">
		listOfBookmark.push("${bookmarkList}")
	</c:forEach> 
		
	$(".hiddenFreeboardCd").each(function(){
		var order = $(".hiddenFreeboardCd").index(this);
		console.log("게시물 코드의 order"+order);
		var hiddenFreeboardCd = $(this).attr("value");
		console.log("게시물 코드"+hiddenFreeboardCd);
		for(var i=0; i<listOfBookmark.length; i++){
		    if( listOfBookmark[i] == hiddenFreeboardCd ){
		    	console.log("안빈별 : 북마크의게시물코드"+listOfBookmark[i]);
		    	console.log("for문 게시물코드"+hiddenFreeboardCd);
		    	console.log("for문 게시물코드의 order"+order);
		        $('.bookmarkSpan').eq(order).html('<a href="#" style="font-size:3em;color: orange;" class="bookmark fill  glyphicon glyphicon-star"></a>');
		        console.log("for문 게시물코드의 order"+order);
		    }
		    else if(listOfBookmark[i] != hiddenFreeboardCd){
		    	console.log("빈별넣자 order: "+order);
		    	  $('.bookmarkSpan').eq(order).html('<a href="#" style="font-size:3em;color: orange;" class="bookmark empty glyphicon glyphicon-star-empty"></a>');
		    }
		}
    });
	
	//북마크 등록
	$('.fill').click(function(){
		var order =$('.bookmark').index(this);//잘됨
		var freeCd = $('.hiddenFreeboardCd').eq(order).val();//잘되
		alert($('.bookmarkSpan').eq(order).children($('.fill')))
		if($('.bookmarkSpan').eq(order).children($('.fill'))){//이게안되네 
			alert('북마크 등록 눌러따!! freeCd : '+freeCd );
			location.href="/freeboardbookmarkInsert?freeboardCd="+freeCd; 
		}else if($('.bookmark').eq(order).val()==$('.empty')){
			alert('북마크 해제!! freeCd : '+ freeCd)
			location.href="/freeboardbookmarkDelete?freeboardCd="+freeCd; 
		}		
	});
	//삭제 
	$('.empty').click(function(){
		var order= $('.empty').parent().index(this);
		console.log("empty order"+ order)
		/* var order2= $('.empty').index(this).parent().index();
		console.log("empty order"+ order2) */
		/* var order =$('.bookmark').index(this);//잘됨
		var freeCd = $('.hiddenFreeboardCd').eq(order).val();//잘되
		alert($('.bookmarkSpan').eq(order).children($('.fill')))
		if($('.bookmarkSpan').eq(order).children($('.fill'))){//이게안되네 
			alert('북마크 등록 눌러따!! freeCd : '+freeCd );
			location.href="/freeboardbookmarkInsert?freeboardCd="+freeCd; 
		}else if($('.bookmark').eq(order).val()==$('.empty')){
			alert('북마크 해제!! freeCd : '+ freeCd)
			location.href="/freeboardbookmarkDelete?freeboardCd="+freeCd; 
		}		 */
	});
/* 	//북마크 삭제 
	$(document).on('click','.bookmarkfill',function(){ 
		var order= $('.bookmark').index(this);
		var freeCd = $('.hiddenFreeboardCd').eq(order).val();
		location.href="/freeboardbookmarkDelete?freeboardCd="+freeCd; 
	}); */
	

	
});
</script>
</head>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/common/module/modHeader.jsp" />
<body>
<input type="hidden" id="cateFromServer" value="${freeboardCate}">
<input type="hidden" id="sessionId" value="${sessionScope.generalId}">
<br>

<div class="container-fluid">
	<div class="row content">
		<!-- 사이드바 -->
		<div class="sidenav">
			<h3><a href="/freeboardList">자유게시판</a></h3>
			<ul class="nav nav-pills nav-stacked">
				<li><a href="/freeboardList">전체글보기</a></li>
				<c:forEach items="${cateForView}" var="cateForView">
					<c:if test="${freeboardCate==cateForView.freeboardCateCd}">
						<li class="active">
							<a href="/freeboardList?cate=${cateForView.freeboardCateCd}">${cateForView.categoryKeyword}</a>
						</li>
					</c:if>
					<c:if test="${freeboardCate!=cateForView.freeboardCateCd}">
						<li>
							<a href="/freeboardList?cate=${cateForView.freeboardCateCd}">${cateForView.categoryKeyword}</a>
						</li>
					</c:if>
				</c:forEach>
				<c:if test="${sessionScope.generalId!=null}">
					<li>
						<a href="/freeboardList?bookmark=bookmark">내 북마크보기</a>
					</li>
				</c:if>
			</ul>
			<br>
			
			<div class="input-group">
				<input type="text" id="boardSearchKeyword" class="form-control" placeholder="검색어 입력">
				<span class="input-group-btn">
					<button class="btn btn-default" type="button" id="searchBoardBtn">
						<span class="glyphicon glyphicon-search"></span>
					</button>
				</span>
			</div>
		</div>
		<!-- 사이드바 -->
		

		<!-- 게시글입력 -->
		<div class="body">
		<div class="col-sm-9">
			<hr>
			<form role="form" id="boardInsertForm" action="/freeboardInsert">
				<table>
					<tr>
						<td>		
							<select class="form-control" name="freeboardCateCd" id="freeboardCateCd">
								<option value="">카테고리선택</option>
								<option value="1">잡담</option>
								<option value="2">근무환경</option>
								<option value="3">자소서</option>
								<option value="4">인적성</option>
								<option value="5">자격증</option>
								<option value="6">어학</option>
							</select>
						</td>
						<td width="80%" colspan="2">
							<input type="text" name="freeboardTitle" id="freeboardTitle" placeholder="제목입력" class="form-control" rows="1" required >
						</td>
					</tr>
					<tr>
						<td colspan="3">
							<br>
							<textarea name="freeboardContent" id="freeboardContent" class="form-control" rows="3"
							placeholder="이곳은 소통을 위한공간입니다. 서비스문의및 건의사항은 사이트 하단의 문의하기를 이용해 주세요"  required ></textarea>
							<br>
						</td>
					</tr>
					<tr>
						<td colspan="3">
							<button type="button" id="submitBtn" class="btn btn-default">게시하기</button>
							<span id="insertError"></span>
						</td>
					</tr>
				</table>
				<hr>
			</form>
		
		<!-- 게시글리스트 -->
		
		<c:forEach items="${freeList}" var="freeList">
		<input type="hidden" class="replyHidden" value="${freeList.freeboardCd}">
				<div class="ContentUpdateForm">
				<table>
						<tr>
							<td style="font-size: large;  font-weight: bolder;">
									<span class="freeCate label label-success">
										<c:if test="${freeList.freeboardCateCd=='1'}">
											잡담
										</c:if>
										<c:if test="${freeList.freeboardCateCd=='2'}">
											근무환경
										</c:if>
										<c:if test="${freeList.freeboardCateCd=='3'}">
											자소서
										</c:if>
										<c:if test="${freeList.freeboardCateCd=='4'}">
											인적성
										</c:if>
										<c:if test="${freeList.freeboardCateCd=='5'}">
											자격증
										</c:if>
										<c:if test="${freeList.freeboardCateCd=='6'}">
											어학
										</c:if>
									</span>
									<span class="freeTitle">&nbsp; ${freeList.freeboardTitle}</span>
							</td>
							<td style="text-align: 'right';">
							
							<!-- 북마크 별표 -->
							<input type="hidden" class="hiddenFreeboardCd" value="${freeList.freeboardCd}">
								 <span class="bookmarkSpan"></span>
								 
							</td>
						</tr>
						<tr>
							<td colspan=2>
								<h5>
									${freeList.freeboardNick} /<span class="glyphicon glyphicon-time"></span>${freeList.freeboardRegdate}
								</h5>
							</td>
						</tr>
						<tr>
							<td width="740px">
								<br>
								
									<p class="freeContent">${freeList.freeboardContent}</p>
								
								<br>
							</td>
							<td>
							<c:if test="${freeList.loginId==sessionScope.generalId}">
								<a class="btn btn-default" href="/freeboardContentDelete?freeboardCd=${freeList.freeboardCd}">삭제</a>
								|<a class="boardContentUpdate btn btn-default ">수정</a>
							</c:if>
							<c:if test="${freeList.loginId!=sessionScope.generalId}">
								<span>&nbsp; &nbsp; &nbsp; &nbsp; </span>
							</c:if>
							</td>
							
						</tr>
					</table>
					</div>
					<table>
					<!-- 댓글입력 -->					
					<tr>
						<td colspan=2>
							<div class="input-group">
							    <textarea class="form-control replyContent"  rows="2" cols="120" style="resize:none" placeholder="댓글 입력" required></textarea>     
							    <span class="input-group-addon btn btn-primary replyBtn">등록</span>
							</div>
							<br>
						</td>
					</tr>
				</table>
				
				
				
					<!-- 댓글리스트 -->
				<c:forEach items="${replyMap}" var="replyMap">
					<input type="hidden" id="replyCd" value="${replyMap.freeboardCd}">
					<c:if test="${replyMap.freeboardCd == freeList.freeboardCd}">
					
					<table>
					<tr>
						<td colspan="2">
							<div class="row"> 
								<div class="col-sm-10">
									<span style="font-weight: bolder;">
										${replyMap.loginNick}  
										<span class="glyphicon glyphicon-time"></span><small>${replyMap.replyRegdate}</small>
									</span>
						</td>
					</tr>	
					</table>
					
					<div class="replyUpdateForm">
					<table>
						<tr>
							<td width="750px">	
								<p><span class="reply1">${replyMap.replyContent}</span>
								<input type="hidden" value="${replyMap.replyCd}" class="hiddenReplyCd">
								<input type="hidden" value="${replyMap.replyContent}" id="hiddenReply">
							</td>
							<td>		
								<span>
								<c:if test="${replyMap.loginId==sessionScope.generalId}">
								<a href="/freeboardReplyDelete?replyCd=${replyMap.replyCd}" class="btn btn-default btn-sm">삭제</a>|
								<a  class="updateReply btn btn-default btn-sm">수정</a> 
								</c:if>
		
								<c:if test="${replyMap.loginId!=sessionScope.generalId}">
								<span>&nbsp; &nbsp; &nbsp; &nbsp; </span>
								</c:if>
								</span>
							 		</div>
								 </div>
					 		</td>
						</tr>
					 </table>
					 </div>
				</c:if>
			</c:forEach>
			<hr>
			<br>
		</c:forEach>
		<!-- 게시글리스트끝 -->
				<!-- 페이징 -->
				<div class="text-center">
					<ul class="pager">
						<li class="previous"><a href="/freeboardList?cate=${freeboardCate}&page=${page-1}">이전</a></li>
						<c:forEach var="i" begin="${startPage}" end="${endPage}">
								<c:if test="${page == i}">
									<li class="active"><a href="/freeboardList?cate=${freeboardCate}&page=${i}">${i}</a></li>
								</c:if>
								<c:if test="${page != i}">
									<li><a href="/freeboardList?cate=${freeboardCate}&page=${i}">${i}</a></li>
								</c:if>
						</c:forEach>
						<li class="next"><a href="/freeboardList?cate=${freeboardCate}&page=${page+1}">다음</a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/common/module/modFooter.jsp" />
</html>

