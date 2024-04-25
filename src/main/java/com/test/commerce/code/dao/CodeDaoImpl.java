package com.test.commerce.code.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Repository;

import com.test.commerce.cmn.PcwkLogger;
import com.test.commerce.code.domain.CodeVO;

@Repository
public class CodeDaoImpl implements CodeDao, PcwkLogger {

	final String NAMESPACE = "com.test.commerce.code";
	final String DOT = ".";

	@Autowired
	SqlSessionTemplate sqlSessionTemplate;

	@Override
	public int doUpdate(CodeVO inVO) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int doDelete(CodeVO inVO) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public CodeVO doSelectOne(CodeVO inVO) throws SQLException, EmptyResultDataAccessException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int doSave(CodeVO inVO) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<CodeVO> doRetrieve(Map<String, Object> map) throws SQLException {
		return sqlSessionTemplate.selectList(NAMESPACE + DOT + "doRetrieve", map);

	}

}
