package egov.mes.manufacture.process.dao;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("manProcessMapper")
public interface ManProcessMapper {
	
	//불량량 브라우저에 보여주기
	List<ManProcessVO> selectDefQnt(ManProcessVO processVO);
	
	//이전공정의 종료시간 구하기
	ManProcessVO selectPreEndTime(ManProcessVO processVO);
	
	//작업지시량만큼 업데이트
	int updateManQnt(ManProcessVO processVO);
	
	//작업지시량조회
	String selectManGoalQnt(ManProcessVO processVO);
	
	//지시테이블의 상태 값 변경
	int updateComEtc(ManProcessVO processVO);
	
	//스케쥴러 종료
	int updateEndTime(ManProcessVO processVO);
	
	//인덱스 최대값
	int selectIndexMax(ManProcessVO processVO);
	
	//현재 내공정의 인덱스
	int selectIndexNow(ManProcessVO processVO);
	
	//다음 공정의 시작날짜 조회
	ManProcessVO selectNextProc(ManProcessVO processVO);
	
	//다음 공정의 시작날짜를 update
	void updateNowProc(ManProcessVO processVO);
	
	//현재공정 조회
	String selectProcNow(ManProcessVO processVO);
	
	//첫공정의 시작시간만 업테이트
	int updateFirstProc (ManProcessVO processVO);
	
	//브라우저 화면에 보여줄 진행공정 테이블
	List<ManProcessVO> selectProcList(ManProcessVO processVO);
	
	//작업완료량 합계
	String selectSumManQnt(ManProcessVO processVO);
	
	//앞공정의 생산수량 유무 확인
	ManProcessVO selectPreManQnt (ManProcessVO processVO);
	
	//진행공정 테이블에 insert
	int insertProcess(ManProcessVO processVO);
	
	//지시된 제품에 해당하는 공정 조회
	List<ManProcessVO> selectProcess(ManProcessVO processVO);
	
	//생산중 & 생산완료 제품에 해당하는 공정 정보
	List<ManProcessVO> findProcess(ManProcessVO processVO);

	//생산지시서 조회
	List<ManProcessVO> selectCommand(ManProcessVO processVO);
	
	//제품에 해당하는 공정 조회
	List<ManProcessVO> selectProc(ManProcessVO processVO);
	
	//주기적으로 진행공정 테이블을 조회
	List<ManProcessVO> selectProcTable();
	
	//10초당 생산량 조회
	int qntPer10Second();
	
	//10초가 지났을 때 작업완료량 update
	int updateSecondQnt(ManProcessVO processVO);
	
	//해당공정의 10초당 생산량조회
	ManProcessVO selectSecondQnt(ManProcessVO processVO);
	
}
