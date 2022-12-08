--1. 70년대생 여자 전씨 사원 이름 주민번호 부서명 직급
SELECT EMP_NAME
      ,EMP_NO
      ,DEPT_TITLE
      ,JOB_NAME
FROM EMPLOYEE E, DEPARTMENT D, JOB J
WHERE E.DEPT_CODE=D.DEPT_ID
AND E.JOB_CODE=J.JOB_CODE
AND SUBSTR(EMP_NO,8,1)='2'
AND SUBSTR(EMP_NO,1,1)='7'
AND SUBSTR(EMP_NAME,1,1)='전';

--2. 가장 막내의 사원코드 사원명 나이 부서명 직급
SELECT ROWNUM 순위
      ,E.*
FROM(SELECT EMP_ID
      ,EMP_NAME    
      ,100-SUBSTR(EMP_NO,1,2)+SUBSTR(SYSDATE,1,2) "나이"
      ,DEPT_TITLE
      ,JOB_NAME
     FROM EMPLOYEE E, DEPARTMENT D, JOB J
     WHERE E.DEPT_CODE=D.DEPT_ID
     AND E.JOB_CODE=J.JOB_CODE
     ORDER BY 나이 ASC) E
WHERE ROWNUM<=1;

--3. 이름에 '형'이 들어가는 사원의 사원코드 사원 명  직급 조회
SELECT EMP_ID
      ,EMP_NAME
      ,JOB_NAME
FROM EMPLOYEE E,DEPARTMENT D,JOB J
WHERE EMP_NAME LIKE '%형%'
AND E.DEPT_CODE=D.DEPT_ID
AND E.JOB_CODE = J.JOB_CODE;

--4. 부서코드가 D5이거나 D6인 사원의 사원 명, 직급, 부코, 부서 명 조회
SELECT EMP_NAME
      ,JOB_NAME
      ,DEPT_CODE
      ,DEPT_TITLE
FROM EMPLOYEE E,DEPARTMENT D,JOB J
WHERE E.DEPT_CODE=D.DEPT_ID
AND E.JOB_CODE = J.JOB_CODE
AND DEPT_CODE IN ('D5','D6')
ORDER BY DEPT_CODE ;

--5. 보너스를 받는 사원의 사원 명, 부서 명, 지역 명 조회
SELECT EMP_NAME
      ,DEPT_TITLE
      ,LOCAL_NAME
FROM EMPLOYEE E,DEPARTMENT D,LOCATION L
WHERE E.DEPT_CODE=D.DEPT_ID
AND D.LOCATION_ID = L.LOCAL_CODE
AND E.BONUS IS NOT NULL;

--6. 사원명 직급명 부서명 지역명 조회
SELECT EMP_NAME
      ,JOB_NAME
      ,DEPT_TITLE
      ,LOCAL_NAME
FROM EMPLOYEE E,DEPARTMENT D,JOB J, LOCATION L
WHERE E.DEPT_CODE=D.DEPT_ID
AND E.JOB_CODE=J.JOB_CODE
AND D.LOCATION_ID = L.LOCAL_CODE;

--7. 한국이나 일본에서 근무 중인 사원의 사원명 부서명 지역명 국가명 조회
SELECT EMP_NAME
      ,DEPT_TITLE
      ,LOCAL_NAME
      ,NATIONAL_NAME
FROM EMPLOYEE E,DEPARTMENT D,LOCATION L,NATIONAL N
WHERE E.DEPT_CODE=D.DEPT_ID
AND D.LOCATION_ID = L.LOCAL_CODE
AND L.NATIONAL_CODE=N.NATIONAL_CODE
AND NATIONAL_NAME IN ('한국','일본');

--8. 한 사원과 같은 부서에서 일하는 사원의 이름 조회
SELECT E.EMP_NAME
      ,E.DEPT_CODE "부코"
      ,M.EMP_NAME
FROM EMPLOYEE E
JOIN EMPLOYEE M ON (E.DEPT_CODE=M.DEPT_CODE)
WHERE E.EMP_NAME != M.EMP_NAME
AND E.DEPT_CODE BETWEEN 'D1' AND 'D9'
ORDER BY E.EMP_NAME;

SELECT E.EMP_NAME
      ,E.DEPT_CODE "부코"
      ,M.EMP_NAME
FROM EMPLOYEE E
JOIN EMPLOYEE M ON (E.DEPT_CODE=M.DEPT_CODE)
WHERE E.EMP_NAME != M.EMP_NAME
ORDER BY E.EMP_NAME;

SELECT E.EMP_NAME
      ,E.DEPT_CODE "부코"
      ,M.EMP_NAME
FROM EMPLOYEE E, EMPLOYEE M 
WHERE E.DEPT_CODE=M.DEPT_CODE
AND E.EMP_NAME != M.EMP_NAME
ORDER BY E.EMP_NAME;

--9. 보넛 X 직코 J4 OR J7 사원의 이름 직급명 급여 NVL사용
SELECT EMP_NAME
      ,JOB_NAME
      ,SALARY
FROM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE=J.JOB_CODE)
WHERE J.JOB_CODE IN ('J4','J7')
;

--10. 보너스 포함 연봉 TOP5 사번 이름 부서명 직급 입사일 순위 조회
SELECT E.*,ROWNUM
FROM(SELECT EMP_ID 
      ,EMP_NAME
      ,DEPT_TITLE
      ,JOB_NAME
      ,HIRE_DATE
    FROM EMPLOYEE E
    JOIN DEPARTMENT D ON (E.DEPT_CODE=D.DEPT_ID)
    JOIN JOB J ON (E.JOB_CODE=J.JOB_CODE)
    ORDER BY (SALARY*NVL(BONUS,0)+SALARY)*12 DESC) E
WHERE ROWNUM <=5
;

--11. 부서별 급여 합계가 전체 급여 총 합의 20%보다 많은 부서의 부서명 부서별 급여 합계 조회







