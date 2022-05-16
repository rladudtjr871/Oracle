package com.test.java;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class Ex05_PreparedStatement {

	public static void main(String[] args) {


		
		//m1();
		m2();
		
	}//main

	private static void m2() {

		Connection conn = null;
		Statement stat = null;
		PreparedStatement pstat = null;
		ResultSet rs = null;
		
		
		try {
			
			conn = DBUtil.open();
			
			//정적 쿼리
			String sql = "select name from tblInsa where num = 1001";
			
			stat = conn.createStatement();
			
			rs = stat.executeQuery(sql);
			
			if (rs.next()) {
				System.out.println(rs.getString("name"));
			}
			
			rs.close();
			stat.close();
			
			
			
			//동적 쿼리
			sql = "select name from tblInsa where num = ?";
			
			pstat = conn.prepareStatement(sql);
			
			//java.sql.SQLException: 인덱스에서 누락된 IN 또는 OUT 매개변수:: 1 > 1은 몇번쨰 ?인지
			pstat.setString(1, "1001");
			//pstat.setInt(1, 1001);
			
			
			rs = pstat.executeQuery();
			
			
			if (rs.next()) {
				System.out.println(rs.getString("name"));
			}
			
			
			rs.close();
			pstat.close();
			
			
			
			
			//인자 없는 쿼리 > pstat
			sql = "select count(*) as cnt from tblInsa";
			
			pstat = conn.prepareStatement(sql);
			
			rs = pstat.executeQuery();
			
			if (rs.next()) {
				System.out.println(rs.getString("cnt"));
			}
			
			
			rs.close();
			pstat.close();
			
			conn.close();
			
			
			
		} catch (Exception e) {
			
			System.out.println("Ex05_PreparedStatement.m1");
			e.printStackTrace();
		}
		
		
		
		
	}

	private static void m1() {

		//Statement vs PreparedStatement
		//- SQL 실행
		//- 매개변수 처리 지원 유무
		//- Statement > 정적 SQL
		//- PreparedStatement > 동적 쿼리
		
		//insert > 사용자 입력
		String name = "하하하";
		String age = "20";
		String gender = "m";
		String tel = "010-1111-2222";
		String address = "서울시 동대문구 이문's동";
		
		//address = address.replace("'", "''");
		
		Connection conn = null;
		Statement stat = null;
		PreparedStatement pstat = null;
		
		
		try {
			
			conn = DBUtil.open();
			
			
			//Statement 
			String sql = String.format("insert into tblAddress (seq, name, age, gender, tel, address, regdate)"
					+ " values (seqAddress.nextVal, '%s', %s, '%s', '%s', '%s', default)"
						, name, age, gender, tel, address);
			
			stat = conn.createStatement(); //A.
			
			//int result = stat.executeUpdate(sql); //A. 실행 시 SQL 대입
			
			//System.out.println(result);
			
			
			
			
			//PreparedStatement
			//- ?: 오라클 매개변수
			//- SQL 작성이 용이하다. > String.fromat() 유사
			//- 매개변수값으로 부적절한 값이 있어도 자동으로 이스케이프를 시켜준다.(*****)
			sql = "insert into tblAddress (seq, name, age, gender, tel, address, regdate)"
					+ " values (seqAddress.nextVal, ?, ?, ?, ?, ?, default)";
			
			pstat = conn.prepareStatement(sql); //B. 미리 SQL 대입
			
			//인자값에 대한 처리 추가 진행(***)
			pstat.setString(1, name); //1번째 물음표에 name을 넣어라
			pstat.setString(2, age);
			pstat.setString(3, gender);
			pstat.setString(4, tel);
			pstat.setString(5, address);
			
			
			int result = pstat.executeUpdate(); //B. 미리 대입했기때문에 여기서는 sql을 따로 대입 안한다.
			
			System.out.println(result);
			
			
		} catch (Exception e) {
			
			System.out.println("Ex05_PreparedStatement.m1");
			e.printStackTrace();
		}
		
		
		
	}

}//Ex05





















