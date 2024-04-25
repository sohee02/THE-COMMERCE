package com.test.commerce.user.service;

import java.sql.SQLException;
import java.util.List;

import com.test.commerce.cmn.DTO;
import com.test.commerce.user.domain.UserVO;

public interface UserService {
	
	public int doCheckPassword(UserVO inVO) throws SQLException;

	public int doCheckEmail(UserVO inVO) throws SQLException;
	
	public int doCheckNickName(UserVO inVO) throws SQLException;

	public int doCheckId(UserVO inVO) throws SQLException;
	
	public int doSave(UserVO inVO) throws SQLException;
	
	public int doUpdate(UserVO inVO) throws SQLException;
	
	int doDelete(UserVO inVO) throws SQLException;
	
	List<UserVO> doRetrieve(DTO inVO) throws SQLException;

}
