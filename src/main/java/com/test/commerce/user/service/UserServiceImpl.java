package com.test.commerce.user.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.commerce.cmn.DTO;
import com.test.commerce.cmn.PcwkLogger;
import com.test.commerce.user.dao.UserDao;
import com.test.commerce.user.domain.UserVO;

@Service("userServiceImpl")
public class UserServiceImpl implements UserService, PcwkLogger {

	@Autowired
	private UserDao userDao;
	
	public UserServiceImpl() {}
	
	@Override
	public int doCheckPassword(UserVO inVO) throws SQLException {
		return userDao.doCheckPassword(inVO);
	}

	@Override
	public int doCheckEmail(UserVO inVO) throws SQLException {
		return userDao.doCheckEmail(inVO);
	}

	@Override
	public int doCheckId(UserVO inVO) throws SQLException {
		return userDao.doCheckId(inVO);
	}

	@Override
	public int doSave(UserVO inVO) throws SQLException {
		return userDao.doSave(inVO);
	}

	@Override
	public int doUpdate(UserVO inVO) throws SQLException {
		return userDao.doUpdate(inVO);
	}

	
	@Override
	public int doDelete(UserVO inVO) throws SQLException {
		return userDao.doDelete(inVO);
	}

	@Override
	public int doCheckNickName(UserVO inVO) throws SQLException {
		return userDao.doCheckNickName(inVO);
	}

	@Override
	public List<UserVO> doRetrieve(DTO inVO) throws SQLException {
		return userDao.doRetrieve(inVO);

	}

	
}
