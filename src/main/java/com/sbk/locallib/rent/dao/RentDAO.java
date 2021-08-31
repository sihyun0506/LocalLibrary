package com.sbk.locallib.rent.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sbk.locallib.rent.vo.RentVO;

@Repository
public class RentDAO {

	@Autowired
	private SqlSession session;

	public int reservation(RentVO rent) {
		int rent_id = 0;
		try {
			RentMapper mapper = session.getMapper(RentMapper.class);
			mapper.reservation(rent);
			rent_id = rent.getRent_id();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rent_id;
	}

	public int updateOwnerRentCk(RentVO rent) {
		int result = 0;
		try {
			RentMapper mapper = session.getMapper(RentMapper.class);
			result = mapper.updateOwnerRentCk(rent);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public int updateRentCk(RentVO rent) {
		int result = 0;
		try {
			RentMapper mapper = session.getMapper(RentMapper.class);
			result = mapper.updateRentCk(rent);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public int updateOwnerReturnCk(RentVO rent) {
		int result = 0;
		try {
			RentMapper mapper = session.getMapper(RentMapper.class);
			result = mapper.updateOwnerReturnCk(rent);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public int updateReturnCk(RentVO rent) {
		int result = 0;
		try {
			RentMapper mapper = session.getMapper(RentMapper.class);
			result = mapper.updateReturnCk(rent);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public RentVO checkRent(int rent_id) {
		RentVO rent = null;
		try {
			RentMapper mapper = session.getMapper(RentMapper.class);
			rent = mapper.checkRent(rent_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rent;
	}

	public ArrayList<RentVO> getMyRentInfo(String loginId) {
		ArrayList<RentVO> list = null;
		try {
			RentMapper mapper = session.getMapper(RentMapper.class);
			list = mapper.getMyRentInfo(loginId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}
