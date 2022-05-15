package com.test.java;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Scanner;

public class Ex04_select {

	public static void main(String[] args) {


		
		m1();
		//m2();
		//m3();
		//m4();
		//m5();
		//m6();
		//m7();
		//m8();
		//m9();
		
		

	}//main

	private static void m9() {
		
		Connection conn = null;
		Statement stat = null;
		ResultSet rs = null;
		
		
		try {
			
			conn = DBUtil.open();
			stat = conn.createStatement();
			
			//tblAddress 출력
			String sql = "select * from tblAddress order by seq asc";
			
			rs = stat.executeQuery(sql);
			
			while (rs.next()){
				
				System.out.println(rs.getString("name"));
				
			}
			
			
			
			//자원 해제 코드, Clean-up code > 자동으로 닫히지만 메모리 효울을 위해 바로바로 닫아주는게 좋다.
			rs.close();
			stat.close();
			conn.close();
						
			
		} catch (Exception e) {
			
			System.out.println("Ex04_select.m5");
			e.printStackTrace();
		}
		
	}
	

	private static void m8() {
		
		Connection conn = null;
		Statement stat = null;
		ResultSet rs = null;
		
		
		try {
			
			conn = DBUtil.open();
			stat = conn.createStatement();
			
			
			//요구사항] 영업부 직원수와 영업부 직원 명단을 출력하시오.
			//1. select count(*) as cnt from tblInsa where buseo = '영업부'
			//2. select * from tblInsa where buseo = '영업부'
			
			String sql = "";
			
			sql = "select count(*) as cnt from tblInsa where buseo = '영업부'";
			
			rs = stat.executeQuery(sql);
			
			//1개인게 확실 > if
			if(rs.next()) {
				System.out.println("직원수: " + rs.getString("cnt"));
			}
			
			rs.close(); //끝까지 내려갔으니 폐기
			
			
			
			
			sql = "select * from tblInsa where buseo = '영업부'";
			
			rs = stat.executeQuery(sql);
			
			int n = 0;
			
			//여러개인게 확실 > while
			while (rs.next()) {
				
				System.out.println(rs.getString("name"));
				n++;
			}
			
			System.out.println("직원수: " + n); //자바에서 카운트할건지 or 오라클에서 카운트 값을 가져와서 쓸건지 선택
			
			
			
		} catch (Exception e) {
			
			System.out.println("Ex04_select.m5");
			e.printStackTrace();
		}
		
	}

	private static void m7() {
		
		Connection conn = null;
		Statement stat = null;
		ResultSet rs = null;
		
		
		try {
			
			conn = DBUtil.open();
			stat = conn.createStatement();
			
			//회원명 + 대여한 비디오명
			String sql = "select m.name as mname, v.name as vname from tblVideo v inner join tblRent r on v.seq = r.video"
					+ " inner join tblMember m on m.seq = r.member";
			
			rs = stat.executeQuery(sql);
			
			while (rs.next()) {
				
				//System.out.println(rs.getString(1));
				//System.out.println(rs.getString(2));
				
				//System.out.println(rs.getString("m.name"));
				//System.out.println(rs.getString("v.name"));
				
				//System.out.println(rs.getString("name"));
				//System.out.println(rs.getString("name_1"));
				
				//System.out.println(rs.getString("name")); //m.name
				//System.out.println(rs.getString("name")); //m.name
				
				System.out.println(rs.getString("mname"));
				System.out.println(rs.getString("vname"));
				
				System.out.println();
				
			}
			
			rs.close();
			stat.close();
			conn.close();
			
			
		} catch (Exception e) {
			
			System.out.println("Ex04_select.m5");
			e.printStackTrace();
		}
		
	}

	private static void m6() {
		
		//select > 오류 발생
		Connection conn = null;
		Statement stat = null;
		ResultSet rs = null;
		
		
		try {
			
			conn = DBUtil.open();
			stat = conn.createStatement(); //없으면 null 에러
			
			
			//같은 이름 에러라도 ORA가 있으면 오라클 에러 없으면 java에러
			
			//컬럼명 오타 > ORA-00904: "NAM": invalid identifier
			//테이블명 오타 > ORA-00942: table or view does not exist
			String sql = "select name, buseo, jikwi from tblInsa";
			
			
			rs = stat.executeQuery(sql); //서버로 보냄 > 없으면 null 에러
			
			while (rs.next()) {
				
				//Java 오류
				//java.sql.SQLException: 부적합한 열 이름
				System.out.println(rs.getString("nam"));
				System.out.println(rs.getString("buseo"));
				System.out.println(rs.getString("jikwi"));
				
			}
			
			
			
		} catch (Exception e) {
			
			System.out.println("Ex04_select.m5");
			e.printStackTrace();
		}
		
		
		
	}

	private static void m5() {
		
		//tblInsa + tblBonus
		//요구사항] 특정 직원에게 보너스를 지급하세요.
		//1. 모든 직원 명단을 출력(직원번호, 이름, 부서, 직위) > m4()참조
		//2. 사용자 > 직원 선택(직원번호 입력)
		//3. 보너스 금액 입력
		//4. 보너스 지급 > insert tblBonus
		//5. 지급된 내역을 명단 출력(직원번호, 이름, 부서, 직위, 보너스금액) > m4()
		
		
		Connection conn = null;
		Statement stat = null;
		ResultSet rs = null;
		
		Scanner sc = new Scanner(System.in);
		
		try {
			
			conn = DBUtil.open();
			stat = conn.createStatement();
			
			
			//1. 모든 직원 명단 출력
			String sql = "select num, name, buseo, jikwi from tblInsa";
			
			rs = stat.executeQuery(sql);
			
			while (rs.next()) {
				
				System.out.printf("%s\t%s\t%s\t%s\n"
							, rs.getString("num")
							, rs.getString("name")
							, rs.getString("buseo")
							, rs.getString("jikwi"));
				
			}
			
			rs.close(); //다 읽었으니 닫기
			System.out.println();
			
						
			//2. 직원 번호 입력
			System.out.print("직원 번호: ");
			String num = sc.nextLine();
			
			
			//3. 보너스 금액 입력
			System.out.print("보너스 금액: ");
			String bonus = sc.nextLine();
			
			
			//4. 보너스 지급
			sql = String.format("insert into tblBonus (seq, num, bonus) "
					+ "values (seqBonus.nextVal, %s, %s)", num, bonus);
			
			int result = stat.executeUpdate(sql);
			
			
			
			//5. 지급된 내역을 명단 출력(직원번호, 이름, 부서, 직위, 보너스금액)
			//보너스 지급에 성공하면
			if (result > 0 ) { 
				System.out.println("보너스 지급 완료");
				System.out.println();
				
				System.out.println("[번호]\t[이름]\t[부서]\t[직위]\t[보너스]");
				
				sql = "select i.num, i.name, i.buseo, i.jikwi, b.bonus from tblInsa i inner join tblBonus b on i.num = b.num order by b.num asc";
				
				rs = stat.executeQuery(sql);
				
				while (rs.next()) {
					
					System.out.printf("%s\t%s\t%s\t%s\t%,10d원\n"
								, rs.getString("num")
								, rs.getString("name")
								, rs.getString("buseo")
								, rs.getString("jikwi")
								, rs.getInt("bonus"));
					
				}
				
				System.out.println();
				System.out.println("프로그램 종료");
				rs.close();
				
			} else {
				System.out.println("보너스 지급을 실패했습니다.");
			}
			
					
			
			stat.close();
			conn.close();
			
			
		} catch (Exception e) {
			
			System.out.println("Ex04_select.m5");
			e.printStackTrace();
		}
		
		
		
	}

	private static void m4() {

		//다중값 반환
		//- N행 N열
		//- 레코드 N줄 + 컬럼 N개
		Connection conn = null;
		Statement stat = null;
		ResultSet rs = null;
		
		try {
			
			conn = DBUtil.open();
			stat = conn.createStatement();
			
			String buseo = "총무부";
			
			String sql = "select name, jikwi, city, basicpay from tblInsa"
					+	" where buseo = '" + buseo + "'";
			
			rs = stat.executeQuery(sql);
			
			System.out.println("[이름]\t[직위]\t[지역]\t[급여]");
			
			while (rs.next()) {
				
				//직원 1명
				System.out.printf("%s\t%s\t%s\t%,10d원\n"
									 , rs.getString("name")
									 , rs.getString("jikwi")
									 , rs.getString("city")
									 , rs.getInt("basicpay"));
				
			}
			
			
			rs.close();
			stat.close();
			conn.close();
			
			
			
			
		} catch (Exception e) {
			
			System.out.println("Ex04_select.m4");
			e.printStackTrace();
		}
		
		
		
	}

	private static void m3() {
		
		//다중값 반환
		//- N행 1열
		//- 레코드 N줄 + 컬럼 1개
		Connection conn = null;
		Statement stat = null;
		ResultSet rs = null;
		
		try {

			conn = DBUtil.open();
			stat = conn.createStatement();
			
			String sql = "select name from tblInsa order by name";
			
			//60명
			rs = stat.executeQuery(sql);
			
			
			rs.next();
			rs.next();
			rs.next();
			
			//몇바퀴? > 60바퀴 > 57바퀴			
			while (rs.next()) { 
				System.out.println(rs.getString("name"));
			} //EOF
			
			
			//결과 집합을 모두 소모했음
			//ResultSet.next가 호출되지 않았음
			//rs = stat.executeQuery(sql); //BOF
			//System.out.println(rs.getString("name"));
			
			
			rs.close();
			stat.close();
			conn.close();
			
		} catch (Exception e) {

			System.out.println("Ex04_select.m3");
			e.printStackTrace();
		}
		
		
	}

	private static void m2() {
		
		//다중값 반환
		//- 1행 N열
		//- 레코드 1줄 + 여러개 컬럼
		Connection conn = null;
		Statement stat = null;
		ResultSet rs = null;
		
		try {
			
			conn = DBUtil.open();
			stat = conn.createStatement();
			
			String sql = "select name, age, tel, address from tblAddress where seq = 5";
			
			rs = stat.executeQuery(sql);
			
			if (rs.next()) {
				
				System.out.println("이름: " + rs.getString("name"));
				System.out.println("나이: " + rs.getString("age"));
				System.out.println("전화: " + rs.getString("tel"));
				System.out.println("주소: " + rs.getString("address"));
				
				
			} else {
				System.out.println("데이터가 없습니다.");
			}
			
						
			rs.close();
			stat.close();
			conn.close();
			
			
			
		} catch (Exception e) {
			
			System.out.println("Ex04_select.m2");
			e.printStackTrace();
		}
		
		
	}

	private static void m1() {
		
		//단일값 반환
		//-1행 1열
		
		Connection conn = null;
		Statement stat = null;
		ResultSet rs = null;
		
		try {
			
			conn = DBUtil.open();
			stat = conn.createStatement();
			
			String sql = "select count(*) + 100 as cnt from tblInsa";
			
			//반환값X -> executeUpdate()
			//반환값O -> executeQuery()
			
			rs = stat.executeQuery(sql);
			
			
			//Result == 커서(Cursor) > 판독기 > 스트림, Iterator, 향상된 for
			
			rs.next(); //BOF에서 > 커서를 1줄 전진 > 레코드 위치
			
			//현재 커서가 가리키고 있는 레코드의 특정 컬럼값을 가져와라
			int cnt1 = rs.getInt(1); //1(Index) > 컬럼순서
			int cnt2 = rs.getInt("cnt"); //"" > 컬럼명 **********
			String cnt3 = rs.getString("cnt");
			
			System.out.println(cnt1);
			System.out.println(cnt2);
			System.out.println(cnt3);
			
			
			
			
			
			
			stat.close();
			conn.close();
			
			
			
		} catch (Exception e) {
			
			System.out.println("Ex04_select.m1");
			e.printStackTrace();
		}
		
		
	}

	
}//Ex04












