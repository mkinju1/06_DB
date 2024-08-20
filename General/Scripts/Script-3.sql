[요구사항]

김영희 회원과 같은 지역에 사는 회원들의 지역명, 아이디, 이름, 등급명을 이름 오름차순으로 조회



[작성한 SQL]

SELECT AREA_NAME 지역명, MEMBER_ID 아이디, MEMBER_NAME 이름, GRADE_NAME 등급명

FROM TB_MEMBER

JOIN TB_GRADE ON(GRADE = GRADE_CODE)

JOIN TB_AREA ON (AREA_CODE = AREA_CODE)

WHERE AREA_CODE = (

SELECT AREA_CODE FROM TB_MEMBER

WHERE 이름 = '김영희')

ORDER BY 이름 DESC;




-- JOIN 조건 오류
문제 : 
JOIN에서 TB_AREA 테이블과 TB_MEMBER 테이블을 조인 시, 
AREA_CODE가 조인 조건으로 사용되고 있는데, 
두 테이블 모두 같은 이름의 컬럼을 가지고 있음
이 경우 어떤 테이블의 컬럼인지 명확하게 해야 됨

조치 :
 -- ON 절에서 컬럼을 명확하게 지정
	
	JOIN TB_AREA ON (AREA_CODE = AREA_CODE) 를
	
  JOIN TB_AREA ON (TB_MEMBER.AREA_CODE = TB_AREA.AREA_CODE)
  로 수정

 
 


-- 서브쿼리에서 WHERE 절 컬럼 이름
문제: 서브쿼리에서 WHERE 절에 사용된 이름 컬럼이 존재x
		 존재하지 않는 컬럼에서 데이터를 가져올 수 없음
조치: 서브쿼리에서 딸랑 이름만이 아니라 MEMBER_NAME을 사용

						WHERE 이름 = '김영희' 를

 						WHERE 
            MEMBER_NAME = '김영희' 로 변경



            
            
            
-- 서브쿼리 반환값 정확성
문제: 서브쿼리가 AREA_CODE를 반환하지만, AREA_CODE 값이 아닌 AREA_NAME이 필요

조치: AREA_CODE 대신 AREA_NAME을 직접 비교하는 것이 좋습니다. 
[요구 사항]에 따르면, AREA_CODE를 사용하여 지역을 비교해야 합니다.
-- ORDER BY 절에서 TB_MEMBER.MEMBER_NAME ASC를 사용하여 
-- 이름을 오름차순으로 정렬            
            
            
            

-- 문제점 3 : 서브 쿼리 반환 값

문제: 원래 코드에서는 AREA_CODE가 특정 테이블을 참조하는지 명시X 
			
		 여러 테이블이 조인된 경우, 
		 특정 컬럼이 어떤 테이블의 컬럼인지 명확히 해야 함
		 AREA_CODE가 TB_MEMBER 테이블의 컬럼인지, 
	   다른 테이블의 컬럼인지 명확하지 않으므로 
	   SQL이 어떤 테이블의 컬럼을 참조해야 하는지 혼동할 수 있음

수정 이유:

조치 3 : 
TB_MEMBER.AREA_CODE로 명시해, 
AREA_CODE가 TB_MEMBER 테이블의 컬럼임을 명확히 함. 



원인 4 : ORDER BY 절

문제 : 오름차순인데  내림차순인 DESC; 로 입력되어있음
			그리고 참조해야하는 컬럼의 이름이 명확하지 않음



조치 4. 
-- ORDER BY 절에서 TB_MEMBER.MEMBER_NAME ASC를 사용하여 
-- 이름을 오름차순으로 정렬 






SELECT 
    TB_AREA.AREA_NAME 지역명, 
    TB_MEMBER.MEMBER_ID 아이디, 
    TB_MEMBER.MEMBER_NAME 이름, 
    TB_GRADE.GRADE_NAME 등급명
FROM 
    TB_MEMBER
JOIN 
    TB_GRADE ON TB_MEMBER.GRADE = TB_GRADE.GRADE_CODE
JOIN 
    TB_AREA ON TB_MEMBER.AREA_CODE = TB_AREA.AREA_CODE
WHERE 
    TB_MEMBER.AREA_CODE = (
        SELECT 
            AREA_CODE 
        FROM 
            TB_MEMBER
        WHERE 
            MEMBER_NAME = '김영희'
    )
ORDER BY 
    TB_MEMBER.MEMBER_NAME ASC;