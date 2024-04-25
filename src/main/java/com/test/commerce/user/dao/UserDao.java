package com.test.commerce.user.dao;

import java.sql.SQLException;
import java.util.List;

import com.test.commerce.cmn.DTO;
import com.test.commerce.user.domain.UserVO;

public interface UserDao {

	int doCheckPassword(UserVO inVO) throws SQLException;
	
	int doCheckEmail(UserVO inVO) throws SQLException;

	int doCheckId(UserVO inVO) throws SQLException;
	
	int doCheckNickName(UserVO inVO) throws SQLException;
	
	int doSave(UserVO inVO) throws SQLException;
	
	int doUpdate(UserVO inVO) throws SQLException;
		
	int doDelete(UserVO inVO) throws SQLException;
	
	List<UserVO> doRetrieve(DTO inVO) throws SQLException;

}
