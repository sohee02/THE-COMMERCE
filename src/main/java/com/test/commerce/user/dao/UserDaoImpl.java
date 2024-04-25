package com.test.commerce.user.dao;

import java.sql.SQLException;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.test.commerce.user.domain.UserVO;
import com.test.commerce.cmn.DTO;
import com.test.commerce.cmn.PcwkLogger;

@Repository
public class UserDaoImpl implements UserDao, PcwkLogger {
	
	final String NAMESPACE = "com.test.commerce.user";
	final String DOT = ".";

	@Autowired
	SqlSessionTemplate sqlSessionTemplate;

	public UserDaoImpl() {}

	@Override
	public int doCheckPassword(UserVO inVO) throws SQLException {
		
		return this.sqlSessionTemplate.selectOne(NAMESPACE + DOT + "doCheckPassword", inVO);
	}


	@Override
	public int doCheckId(UserVO inVO) throws SQLException {
		return this.sqlSessionTemplate.selectOne(NAMESPACE + DOT + "doCheckId", inVO);
	}

	@Override
	public int doSave(UserVO inVO) throws SQLException {
		return this.sqlSessionTemplate.insert(NAMESPACE + DOT + "doSave", inVO);
	}

	@Override
	public int doUpdate(UserVO inVO) throws SQLException {
		return this.sqlSessionTemplate.update(NAMESPACE + DOT + "doUpdate", inVO);
	}
	

	@Override
	public int doDelete(UserVO inVO) throws SQLException {
		return this.sqlSessionTemplate.delete(NAMESPACE + DOT + "doDelete", inVO);
	}

	@Override
	public int doCheckEmail(UserVO inVO) throws SQLException {
		return this.sqlSessionTemplate.update(NAMESPACE + DOT + "doCheckEmail", inVO);

	}

	@Override
	public int doCheckNickName(UserVO inVO) throws SQLException {
		return this.sqlSessionTemplate.update(NAMESPACE + DOT + "doCheckNickName", inVO);

	}

	@Override
	public List<UserVO> doRetrieve(DTO inVO) throws SQLException {
		return sqlSessionTemplate.selectList(NAMESPACE + DOT + "doRetrieve", inVO);

	}

	@Override
	public int doCheckPhone(UserVO inVO) throws SQLException {
		return this.sqlSessionTemplate.update(NAMESPACE + DOT + "doCheckPhone", inVO);

	}

	
}
