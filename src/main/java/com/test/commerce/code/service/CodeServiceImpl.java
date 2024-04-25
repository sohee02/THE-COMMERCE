package com.test.commerce.code.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.commerce.cmn.PcwkLogger;
import com.test.commerce.code.dao.CodeDao;
import com.test.commerce.code.domain.CodeVO;

@Service
public class CodeServiceImpl implements CodeService,PcwkLogger {

	@Autowired
	CodeDao dao;
	
	public CodeServiceImpl() {}
	
	@Override
	public List<CodeVO> doRetrieve(Map<String, Object> map) throws SQLException {
		return dao.doRetrieve(map);
	}

}
