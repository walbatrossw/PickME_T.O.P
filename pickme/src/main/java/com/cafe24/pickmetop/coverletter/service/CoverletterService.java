package com.cafe24.pickmetop.coverletter.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cafe24.pickmetop.coverletter.model.CoverletterCompanyJobInfoVo;
import com.cafe24.pickmetop.coverletter.model.CoverletterMemberArticleSaveVo;
import com.cafe24.pickmetop.coverletter.model.CoverletterMemberArticleVo;
import com.cafe24.pickmetop.coverletter.model.CoverletterMemberVo;
import com.cafe24.pickmetop.coverletter.repository.CoverletterDao;


@Service
public class CoverletterService {
	final static Logger logger = LoggerFactory.getLogger(CoverletterService.class);
	@Autowired
	CoverletterDao coverletterDao;
	
	// 01 자기소개서 리스트(회원이 직접 작성한 자기소개서 리스트)
	public List<CoverletterMemberVo> getMemberCoverletterList(){
		return coverletterDao.selectCoverletterMemberList();
	}
	
	// 02 기업채용공고의 자기소개서 리스트(자기소개서를 검색이나 체크리스트 체크를 통해 입력화면으로 이동)
	public List<CoverletterCompanyJobInfoVo> getCompanyJobCoverletterList(){
		return coverletterDao.selectCoverletterCompanyJobList();
	}
	
	// 03 자기소개서 입력화면(채용기업명/채용명/채용직무/상세직무/채용마감일자, 채용직무의 자기소개서항목리스트)
	public Map<String, Object> getCompanyOneJobCletter(String recruitJobCd){
		Map<String, Object> companyOneJobMap = new HashMap<String, Object>();
		companyOneJobMap.put("companyOneJobCletterInfo", coverletterDao.selectOneCletterCompanyJobInfo(recruitJobCd));
		companyOneJobMap.put("companyOneJobArticleList", coverletterDao.selectListCletterArticleByJobCd(recruitJobCd));
		return companyOneJobMap;
	}

	public void addCoverletter(CoverletterMemberVo coverletterMember, CoverletterMemberArticleVo memberArticle,	CoverletterMemberArticleSaveVo saveRecord){
		coverletterMember.setLoginId("walbatrossw@gmail.com");
		coverletterDao.insertCoverletter(coverletterMember);
		coverletterDao.insertCoverletterArticle(memberArticle);
		coverletterDao.insertCoverletterSaveRecord(saveRecord);
	}
	
	// 03_02 자기소개서 입력 처리(자기소개서 이름/마감시간/문항/내용)
	
}
