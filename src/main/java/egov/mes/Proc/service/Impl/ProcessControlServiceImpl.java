package egov.mes.Proc.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egov.mes.Proc.dao.ProcessControlMapper;
import egov.mes.Proc.dao.ProcessControlVO;
import egov.mes.Proc.service.ProcessControlService;

@Service
public class ProcessControlServiceImpl implements ProcessControlService {
	
	@Autowired ProcessControlMapper mapper;
	
	
	//공정전체조회
	@Override
	public List<ProcessControlVO> AllFind() {
		
		return mapper.AllFind();
	}
	
	//사원조회(반장만)
	@Override
	public List<ProcessControlVO> EmpFind() {
		
		return mapper.EmpFind();
	}

	
	//process 테이블데이터 단건삭제
	@Override
	public int ProcDelete(List<ProcessControlVO> procVO) {
		for(ProcessControlVO oneData : procVO)
			mapper.ProcDelete(oneData);
		return 0;
	}

	
	//common_code 테이블 단건삭제
	@Override
	public int CommonDelete(List<ProcessControlVO> procVO) {
		for(ProcessControlVO oneData : procVO)
			mapper.CommonDelete(oneData);
		return 0;
	}
	
	//process 테이블 데이터 추가
	@Override
	public int ProcAddData(List<ProcessControlVO> ProcVO) {
		for(ProcessControlVO procVO : ProcVO)
			mapper.ProcAddData(procVO);
		
		return 0;
	}
	
	//common_code 테이블 데이터 추가
	@Override
	public int CommonAddData(List<ProcessControlVO> ProcVO) {
		System.out.println("Impl 데이터준비");
		
		System.out.println(ProcVO);
		for(ProcessControlVO procVO : ProcVO) {
			System.out.println(procVO);
			
			mapper.CommonAddData(procVO);
		}
		System.out.println("Impl 성공");
		
		return 0;
	}
	
	//process 테이블데이터 수정
	@Override
	public void ProcChangeData(List<ProcessControlVO> ProcVO) {
		for(ProcessControlVO procVO : ProcVO)
			mapper.ProcChangeData(procVO);
		}
	
	//common_code 테이블 데이터 수정
	@Override
	public void CommonChangeData(List<ProcessControlVO> ProcVO) {
		for(ProcessControlVO procVO : ProcVO)
			mapper.CommonChangeData(procVO);
		}




}
