package com.test.commerce.code.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.test.commerce.code.domain.CodeVO;


public interface CodeService {

	public List<CodeVO> doRetrieve(Map<String, Object> map) throws SQLException;

}
