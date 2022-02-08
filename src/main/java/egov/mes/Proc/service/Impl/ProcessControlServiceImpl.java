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
		for(ProcessControlVO oneData : procVO) {
			mapper.ProcDelete(oneData);
		}
		return 0;
	}

	
	//common_code 테이블 단건삭제
	@Override
	public int CommonDelete(List<ProcessControlVO> procVO) {
		for(ProcessControlVO oneData : procVO) {
			mapper.CommonDelete(oneData);
		}
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
		for(ProcessControlVO procVO : ProcVO) {
			System.out.println(procVO);
			
			mapper.CommonAddData(procVO);
		}
		
		return 0;
	}
	
	//process 테이블데이터 수정
	@Override
	public void ProcChangeData(List<ProcessControlVO> ProcVO) {
			for(ProcessControlVO procVO : ProcVO) {
				mapper.ProcChangeData(procVO) ;
				System.out.println("process 테이블 수정");
			}
		}
	
	//common_code 테이블 데이터 수정
	@Override
	public void CommonChangeData(List<ProcessControlVO> ProcVO) {
			for(ProcessControlVO procVO : ProcVO) {
				mapper.CommonChangeData(procVO);
				System.out.println("common_code 테이블 수정");
			}
		}

	
	//설비목록 전체조회
	@Override
	public List<ProcessControlVO> FacFind() {
		
		return mapper.FacFind();
	}
	
	
	//설비사용공정 데이터 추가
	@Override
	public void FacProcInput(List<ProcessControlVO> ProcVO) {
		for(ProcessControlVO procVO : ProcVO) {
			mapper.FacProcInput(procVO);
		}
		
	}
	
	//선택중인 설비 목록 조회
	@Override
	public List<ProcessControlVO> SelectedFac( String ProcCode) {
		return mapper.SelectedFac(ProcCode);
	}

	//가동중인설비 선택적 삭젠
	@Override
	public void FacDataDelt(List<ProcessControlVO> procVO) {
		for(ProcessControlVO oneData : procVO) {
			mapper.FacDataDelt(oneData);
		}
		
	}




}
