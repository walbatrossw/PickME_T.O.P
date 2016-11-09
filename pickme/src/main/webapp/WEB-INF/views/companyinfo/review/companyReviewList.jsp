<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<link rel="stylesheet" href="/css/style.css">
<script>
	$(document).ready(function(){
		const $searchBtn = $('#searchBtn');
		const $searchCompanyName = $('#searchCompanyName');
		const $searchjobTopIndex = $('#searchjobTopIndex');
		
		//분류로 검색
		$searchjobTopIndex.val("${jobTopIndexCd}").attr("selected","selected");
		$searchCompanyName.val('${searchCompnayName}');
		$searchjobTopIndex.change(function(){
			console.log('test1');
			if($searchjobTopIndex.val() != "") {
				location.href="/review/companyReviewListAllow?jobTopIndexCd="+$searchjobTopIndex.val();
			}else{
				location.href="/review/companyReviewListAllow";
			}    
	    });
		
		$searchCompanyName.click(function(){
			$searchCompanyName.val("");
		});
		
		//기업명 검색
		$searchBtn.click(function(){
			if($searchCompanyName.val() != "" || $searchjobTopIndex.val() != "") {
				location.href="/review/companyReviewListAllow?searchCompanyName="+$searchCompanyName.val()+"&jobTopIndexCd="+$searchjobTopIndex.val();
			}else{
				location.href="/review/companyReviewListAllow";
			}    
		});
	});
</script>
<title>기업리뷰 승인 리스트</title>
</head>
<body>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/common/module/modHeader.jsp"/>
	<div class="container">
		<div class="jumbotron text-center">
			<h1>기업리뷰 리스트</h1>
		</div>
		<div class="companyReviewList">
			<div class="row">
				<div class="col-xs-3">
					 <select class="form-control" id="searchjobTopIndex" name="jobTopIndexCd">
					 	<option value="">직무분류</option>
					 	<c:forEach var="jobTopIndexList" items="${jobTopIndexList}" >
					 		<option value="${jobTopIndexList.jobTopIndexCd }">${jobTopIndexList.jobTopIndexName }</option>
					 	</c:forEach>
					 </select>
				</div>
				<div class="col-xs-2">
					<input type="text" class="form-control" id="searchCompanyName" name="searchCompanyName" placeholder="기업명"/>
				</div>
				<div class="col-xs-2">			
					<button class="btn .btn-default" id="searchBtn"><span class="glyphicon glyphicon-search"></span>검색</button>
				</div>
			</div>
			<c:forEach var="reviewListAllow" items="${reviewListAllow}">
				<div class="review">
					<div class="row">
						<div class="media">
							<div class="media-left">
								<img src="/img/company/company.png" class="media-object" style="width:60px">
							</div>
							<div class="media-body">
								<h4 class="media-heading">${reviewListAllow.companyName } | ${reviewListAllow.jobTopIndexName } </h4>
								<p>${reviewListAllow.reviewRegDate }</p>
							</div>
						</div>					
					</div>
					<div id="reviewComment" class="row">
						<div class="media">
							<div class="media-left">
								<span><img src="/img/company/people.png" class="media-object"></span>
							</div>
							<div class="media-body">
								<h4 class="media-heading">"${reviewListAllow.reviewComment }"</h4>
							</div>
						</div>
					</div>
					<div id="reviewStrength" class="row">
						<div class="panel panel-success">
							<div class="panel-heading">장점</div>
      						<div class="panel-body">${reviewListAllow.reviewStrength }</div>		
						</div>
					</div>
					<div id="reviewWeak" class="row">
						<div class="panel panel-danger">
							<div class="panel-heading">단점</div>
      						<div class="panel-body">${reviewListAllow.reviewWeak }</div>		
						</div>
					</div>
				</div>
			</c:forEach>		
		</div>
		
		<!-- 페이징 -->
		<div class="text-center">
			<ul class="pager">
				<c:if test="${page > 1}">
					<li class="previous"><a href="/review/companyReviewListAllow?searchCompanyName=${searchCompanyName }&jobTopIndexCd=${jobTopIndexCd}&page=${page-1}">이전</a><li>
				</c:if>
				<c:forEach var="i" begin="${startPage }" end="${endPage }">
					<c:if test="${page == i}">
						<li><a href="/review/companyReviewListAllow?searchCompanyName=${searchCompanyName }&jobTopIndexCd=${jobTopIndexCd}&page=${i }">[${i }]</a><li>
					</c:if>
					<c:if test="${page != i}">
						<li><a href="/review/companyReviewListAllow?searchCompanyName=${searchCompanyName }&jobTopIndexCd=${jobTopIndexCd}&page=${i }">${i }</a></li>
					</c:if>
				</c:forEach>
				<li class="next"><a href="/review/companyReviewListAllow?searchCompanyName=${searchCompanyName }&jobTopIndexCd=${jobTopIndexCd}&page=${page+1}">다음</a></li>
			</ul>
		</div>
	</div>
</body>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/common/module/modFooter.jsp"/>
</html>