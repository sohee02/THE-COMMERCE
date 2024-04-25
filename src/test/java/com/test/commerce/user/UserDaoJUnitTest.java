package com.test.commerce.user;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertThat;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;

import org.junit.Before;
import org.junit.FixMethodOrder;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.ResultActions;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.ModelAndView;
import com.google.gson.Gson;
import com.test.commerce.code.domain.CodeVO;
import com.test.commerce.cmn.PcwkLogger;
import com.test.commerce.user.dao.UserDao;
import com.test.commerce.user.domain.UserVO;

@RunWith(SpringJUnit4ClassRunner.class) // 스프링 테스트 컨텍스트 프레임워크의 JUnit 확장기능 지정
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml","file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class UserDaoJUnitTest implements PcwkLogger {
	
	@Autowired
	UserDao dao;
	
	@Autowired // 테스트 오브젝트가 만들어지고 나면 스프링 테스트 컨텍스트에 자동으로 객체값으로 주입
	WebApplicationContext context;
	
	UserVO vo1;
	UserVO vo2;
	UserVO vo3;
	
	//브라우저 대역
	MockMvc  mockMvc;
	List<UserVO>  userList;
	UserVO   searchVO;

	
	

	@Before
	public void setUp() throws Exception {
		vo1 = new UserVO("sohee4", "sss1", "닉네임97","강소희25", "0110361797", "ksh2097@naver.com",  "사용하지않음");
		vo2 = new UserVO("sohee5", "sss2", "닉네임98","강소희25", "01190361798", "ksh2098@naver.com",  "사용하지않음");
		vo3 = new UserVO("sohee6", "sss3", "닉네임99","강소희25", "01190361799", "ksh2099@naver.com",  "사용하지않음");
		
		String id = "아이디";
		String pw = "비밀번호";
		String nickName = "닉네임";
		String name = "강소희";
		String phone = "전화번호";
		String email = "이메일";
		String regDt    = "사용 하지 않음";
		
		mockMvc  = MockMvcBuilders.webAppContextSetup(context).build();
		userList = Arrays.asList(
				 new UserVO(id, pw, nickName, name, phone, email, regDt)
		);
		searchVO = new UserVO();
		searchVO.setTitle(id);
				 
	}
	
	@Ignore
	@Test
	public void check() throws SQLException {
	    int count = 0;

	    count = dao.doCheckId(vo1);
	    if (count == 1)
	        LOG.debug("중복");
	    else
	        LOG.debug("사용 가능");

	    count = dao.doCheckId(vo2); 
	    if (count == 1)
	        LOG.debug("중복");
	    else
	        LOG.debug("사용 가능");

	    count = dao.doCheckId(vo3);
	    if (count == 1)
	        LOG.debug("중복");
	    else
	        LOG.debug("사용 가능");
	}
	
	@Ignore
	@Test
	public void checkEmail() throws SQLException {
	    int count = 0;

	    count = dao.doCheckEmail(vo1);
	    if (count == 1)
	        LOG.debug("이메일 중복");
	    else
	        LOG.debug("이메일 사용 가능");

	    count = dao.doCheckEmail(vo2); 
	    if (count == 1)
	        LOG.debug("이메일 중복");
	    else
	        LOG.debug("이메일 사용 가능");

	    count = dao.doCheckEmail(vo3);
	    if (count == 1)
	        LOG.debug("이메일 중복");
	    else
	        LOG.debug("이메일 사용 가능");
	}

	@Ignore
	@Test
	public void checkNickName() throws SQLException {
	    int count = 0;

	    count = dao.doCheckNickName(vo1);
	    if (count == 1)
	        LOG.debug("닉네임 중복");
	    else
	        LOG.debug("닉네임 사용 가능");

	    count = dao.doCheckNickName(vo2); 
	    if (count == 1)
	        LOG.debug("닉네임 중복");
	    else
	        LOG.debug("닉네임 사용 가능");

	    count = dao.doCheckNickName(vo3);
	    if (count == 1)
	        LOG.debug("닉네임 중복");
	    else
	        LOG.debug("닉네임 사용 가능");
	}

	
	@Ignore
	@Test
	public void Add() throws ClassNotFoundException, SQLException {
		// 2. 데이터 등록
		int flag = dao.doSave(vo1);
		
		if (flag == 1)
			LOG.debug("등록 성공");
		else
			LOG.debug("등록 실패");

		dao.doSave(vo2);

		dao.doSave(vo3);
	}
	
	@Ignore
	@Test
	public void doUpdate() throws SQLException {
	    // 사용자 정보를 업데이트할 사용자 객체 생성
	    UserVO updateUser = new UserVO("ksh01", "ksh10", "별명15","강소희7", "01090361729", "kcc2020@naver.com",  "사용하지않음");

	    // 사용자 정보 업데이트
	    int result = dao.doUpdate(updateUser);
	    
	    // 업데이트 결과 확인
	    assertThat(result, is(1)); // 업데이트가 정상적으로 이루어졌는지 확인
	}
	@Ignore
	@Test
	public void doDelete() throws SQLException {
       
        // 사용자 정보를 사용하여 삭제 메서드 호출
        int result = dao.doDelete(vo1);

        // 예상 결과와 실제 결과 비교
        assertThat(result, is(1));
    }
	
	//@Ignore
	@Test
	public void doRetrieve() throws Exception{
		//검색
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ doRetrieve()                              │");		
		LOG.debug("└───────────────────────────────────────────┘");
		
		MockHttpServletRequestBuilder  requestBuilder = MockMvcRequestBuilders.get("/user/doRetrieve.do")
				.param("pageSize",   "0")
				.param("pageNo",     "0")
				.param("searchDiv",  "")
				.param("searchWord", "")
				;		
		
		//호출 : ModelAndView      
		MvcResult mvcResult=  mockMvc.perform(requestBuilder).andExpect(status().isOk()).andReturn() ;
		//호출결과
		ModelAndView modelAndView = mvcResult.getModelAndView();
		List<UserVO>  list  = (List<UserVO>) modelAndView.getModel().get("list");
		UserVO  paramVO  = (UserVO) modelAndView.getModel().get("paramVO");
		
		
		List<CodeVO> userSearchList=(List<CodeVO>) modelAndView.getModel().get("userSearch");
		List<CodeVO> pageSizeList=(List<CodeVO>) modelAndView.getModel().get("pageSize");
		
		for(UserVO vo  :list) {
			LOG.debug(vo);
		}
		
		assertNotNull(userSearchList);
		assertNotNull(pageSizeList);
		assertNotNull(list);
		assertNotNull(paramVO);
		
	}

	@Ignore
	@Test
	public void beans() {
		assertNotNull(dao);
		assertNotNull(context);
	}

}
