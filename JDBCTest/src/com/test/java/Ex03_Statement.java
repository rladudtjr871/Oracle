package com.test.java;

import java.sql.Connection;
import java.sql.Statement;
import java.util.Scanner;

public class Ex03_Statement {

	public static void main(String[] args) {
		
		
		
		/*
		
			Connection
			- 연결/종료
			
			Statement
			- SQL 실행하는 역할
			- SQL Developer > SQL 작성 + 블럭 + Ctrl/Enter
			- 모든 SQL 실행 가능
			
			Statement 종류
			1. Statement
				- 기본
			
			2. PreparedStatement
				- Statement 개량 > 매개변수 처리 특화
				- 안정성 높음, 가독성 높음
				- 코드량 증가;
			
			3. CallableStatement
				- Statement 개량 > 프로시저 호출 전용
				- PreparedStatement 유사
		
		
		*/
		
		
		
		
		
	//m1();	
	//m2();
	//m3();
	m4();
	
	
	}//main

	private static void m4() {
		
		//UI + SQL
		//- 사용자 입력 > insert
		
		Connection conn = null;
		Statement stat = null;
		
		Scanner scan = new Scanner(System.in);
		
		try {
			
			//자바 자료형 <- 아무 연관성X -> 오라클 자료형
			System.out.print("이름: ");
			String name = scan.nextLine(); //varchar2
			
			System.out.print("나이: ");
			String age = scan.nextLine(); //number
			
			System.out.print("성별(m,f): ");
			String gender = scan.nextLine(); //char
			
			System.out.print("전화번호: ");
			String tel = scan.nextLine(); //varchar2
			
			System.out.print("주소: ");
			String address = scan.nextLine(); //varchar2
			
			
			conn = DBUtil.open();
			stat = conn.createStatement();
			
			String sql = String.format("insert into tblAddress (seq, name, age, gender, tel, address, regdate)"
					+ "values (seqAddress.nextVal, '%s', %s, '%s', '%s', '%s', default)",
					name, age, gender, tel, address);
			
			int result = stat.executeUpdate(sql);
			
			System.out.println(result);
			
			stat.close();
			conn.close();
			
			
		} catch (Exception e) {
			
			System.out.println("Ex03_Statement.m4");
			e.printStackTrace();
		}
		
		
		
	}

	private static void m3() {

		Connection conn = null;
		Statement stat = null;
		
		try {
			
			conn = DBUtil.open(); //데이터베이스를 연결하고
			stat = conn.createStatement(); //SQL 문을 보내기 위한 개체를 생성
			
			//String sql = "delete from tblAddress where seq = 1";
			//String sql = "create sequence seqJava";
			//String sql = "drop sequence seqJava";
			//String sql = "drop table tblAddress";
			String sql = "create table tblAddress ("
					+ "    seq number primary key,"
					+ "    name varchar2(10) not null,"
					+ "    age number(3) not null check (age between 0 and 150),"
					+ "    gender char(1) not null check(gender in ('m', 'f')),"
					+ "    tel varchar2(15) not null,"
					+ "    address varchar2(300) not null,"
					+ "    regdate date default sysdate not null"
					+ ")";
			
			
			int result = stat.executeUpdate(sql); //구문을 실행 > 진행한 건수 반환
			
			System.out.println(result);
			
			
			stat.close();
			conn.close();
			
		} catch (Exception e) {
			
			System.out.println("Ex03_Statement.m3");
			e.printStackTrace();
		}
		
		
	}

	private static void m2() {
		
		Connection conn = null;
		Statement stat = null;
		
		try {
			
			conn = DBUtil.open();
			stat = conn.createStatement(); //데이터베이스로 SQL 문을 보내기 위한 SQLServerStatement 개체를 만듭니다.
			
			//ORA-00911: invalid character
			String sql = "update tblAddress set age = age + 1 where seq = 1";
			
			int result = stat.executeUpdate(sql); //executeUpdate() > 반영된 건수를 반환
			
			System.out.println(result);
			
			stat.close();
			conn.close();
			
			
		} catch (Exception e) {
			
			System.out.println("Ex03_Statement.m2");
			e.printStackTrace();
		}
		
	}

	private static void m1() {

		//insert 실행
		
		//1. DB 접속
		//2. SQL 실행
		//3. DB 종료
		
		
		Connection conn = null;
		Statement stat = null;
		
		
		try {
			
			//1.
			conn = DBUtil.open();
			
			
			if(!conn.isClosed()) {
				//2.
				//- 자바는 SQL을 모른다. > SQL을 문자열로 취급한다.(아무 의미없이)
				String sql = "insert into tblAddress (seq, name, age, gender, tel, address, regdate) "
						+ "values (seqAddress.nextVal, '아무개', 25, 'm', '010-5555-5555', '서울시 강남구 대치동 OO빌딩', default)";
				
				
				//stat > SQL 실행 > 어느 DB + 어떤 계정으로 SQL을 실행할지 모르고 있음
				stat = conn.createStatement(); //데이터베이스로 SQL 문을 보내기 위한 SQLServerStatement 개체를 만듭니다.
				
				//반환값이 없는 쿼리 > 나머지(select 아닌)
				//- int stat.executeUpdate(sql)
				
				//반환값이 있는 쿼리 > select
				//- ResultSet stat.executeQuery(sql)
			
				
				//SQL Developer > Ctrl + Enter 동일!!!
				//sql이 insert구문이라 반환값이 없어서 > int stat.executeUpdate(sql)
				int result = stat.executeUpdate(sql); //executeUpdate() > 반영된 건수를 반환
				
				if (result == 1) {
					System.out.println("등록 성공");
				} else {
					System.out.println("등록 실패");
				}
				
				
				
				stat.close();
				
				
				
			}
			
			
			//3.
			DBUtil.close();
			
		} catch (Exception e) {
			
			System.out.println("Ex03_Statement.m1");
			e.printStackTrace();
		}
		
		
		
	}
	
	

}//Ex03









