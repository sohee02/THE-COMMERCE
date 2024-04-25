package com.test.commerce.cmn;

import java.sql.SQLException;
import org.springframework.dao.EmptyResultDataAccessException;

	
public interface WorkDiv<T> {

		int doUpdate(T inVO) throws SQLException;
		int doDelete(T inVO) throws SQLException;
		T doSelectOne(T inVO) throws SQLException, EmptyResultDataAccessException;
		int doSave(T inVO) throws SQLException;

}

