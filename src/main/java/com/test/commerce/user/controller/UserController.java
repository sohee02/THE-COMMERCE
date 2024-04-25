package com.test.commerce.user.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.test.commerce.cmn.MessageVO;
import com.test.commerce.cmn.PcwkLogger;
import com.test.commerce.cmn.StringUtil;
import com.test.commerce.code.domain.CodeVO;
import com.test.commerce.code.service.CodeService;
import com.test.commerce.user.domain.UserVO;
import com.test.commerce.user.service.UserService;

@Controller
@RequestMapping("user")
public class UserController implements PcwkLogger {

	@Autowired
	UserService userService;

	@Autowired
	CodeService codeService;
	
	@GetMapping(value = "/moveToDelete.do")
	public String moveToDelete() throws SQLException {
		return "user/user_delete";
	}
	
	@GetMapping(value = "/moveToMod.do")
	public String moveToMod() throws SQLException {
		return "user/user_mod";
	}

	@GetMapping(value = "/moveToReg.do")
	public String moveToReg() throws SQLException {
		return "user/user_reg";
	}

	// ==========================개인정보 수정, 회원 탈퇴================================

	@PostMapping(value = "/doUpdate.do", produces = "application/json;charset=UTF-8")
	@ResponseBody // HTTP 요청 부분의 body 부분이 그대로 브라우저에 전달
	public String doUpdate(UserVO inVO) throws SQLException {
		String jsonString = "";

		LOG.debug("┌───────────────────┐");
		LOG.debug("┃  doUpdate()     │ inVO: " + inVO);
		LOG.debug("└───────────────────┘");

		int flag = userService.doUpdate(inVO);
		String message = "";

		if (flag == 1)
			message = "정상적으로 반영 되었습니다";
		else
			message = "업데이트 실패";

		MessageVO messageVO = new MessageVO(flag + "", message);
		jsonString = new Gson().toJson(messageVO);
		LOG.debug("jsonString: " + jsonString);

		return jsonString;
	}

	
	@GetMapping(value = "/doDelete.do", produces = "application/json;charset=UTF-8") // RequestMethod.GET)
	@ResponseBody // HTTP 요청 부분의 body부분이 그대로 브라우저에 전달된다.
	public MessageVO doDelete(UserVO inVO) throws SQLException {

		int count = userService.doCheckPassword(inVO);
		int flag = 0;
		String message = "";

		if (count == 1) {
			flag = userService.doDelete(inVO);
		} else {
			message = "잘못된 비밀번호 입니다.";
			MessageVO messageVO = new MessageVO(String.valueOf(flag), message);
			return messageVO;
		}

		if (1 == flag) {// 삭제 성공
			message = "그 동안 서비스를 이용해 주셔서 감사합니다.";
		} else {
			message = "탈퇴 실패!";
		}

		MessageVO messageVO = new MessageVO(String.valueOf(flag), message);

		LOG.debug("│ messageVO                           │" + messageVO);
		return messageVO;
	}	

	
	// ========================================================================

	// ============================= 회원 가입 =====================================
	// id 검사
	@RequestMapping(value = "/doCheckId.do", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	@ResponseBody // HTTP 요청 부분의 body 부분이 그대로 브라우저에 전달
	public String doCheckId(UserVO inVO) throws SQLException {
		String jsonString = "";

		LOG.debug("┌───────────────────┐");
		LOG.debug("┃  doCheckId()     │ inVO: " + inVO);
		LOG.debug("└───────────────────┘");

		int count = userService.doCheckId(inVO);
		LOG.debug("count: " + count);

		String message = "";
		if (0 == count) {
			message = "사용 가능한 아이디 입니다.";
		} else {
			message = "중복된 아이디 입니다.";
		}
		MessageVO messageVO = new MessageVO(count + "", message);
		jsonString = new Gson().toJson(messageVO);
		LOG.debug("jsonString:" + jsonString);
		return jsonString;
	}

	// email 검사
	@RequestMapping(value = "/doCheckEmail.do", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	@ResponseBody // HTTP 요청 부분의 body 부분이 그대로 브라우저에 전달
	public String doCheckEmail(UserVO inVO) throws SQLException {
		String jsonString = "";

		LOG.debug("┌───────────────────┐");
		LOG.debug("┃  doCheckEmail()     │ inVO: " + inVO);
		LOG.debug("└───────────────────┘");

		int count = userService.doCheckEmail(inVO);
		LOG.debug("count: " + count);

		String message = "";
		if (0 == count) {
			message = "사용 가능한 이메일 입니다.";
		} else {
			message = "중복된 이메일 입니다.";
		}
		MessageVO messageVO = new MessageVO(count + "", message);
		jsonString = new Gson().toJson(messageVO);
		LOG.debug("jsonString:" + jsonString);
		return jsonString;
	}
	@RequestMapping(value = "/doCheckNickName.do", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	@ResponseBody // HTTP 요청 부분의 body 부분이 그대로 브라우저에 전달
	public String doCheckNickName(UserVO inVO) throws SQLException {
		String jsonString = "";

		LOG.debug("┌───────────────────┐");
		LOG.debug("┃  doCheckNickName()     │ inVO: " + inVO);
		LOG.debug("└───────────────────┘");

		int count = userService.doCheckNickName(inVO);
		LOG.debug("count: " + count);

		String message = "";
		if (0 == count) {
			message = "사용 가능한 닉네임 입니다.";
		} else {
			message = "중복된 닉네임 입니다.";
		}
		MessageVO messageVO = new MessageVO(count + "", message);
		jsonString = new Gson().toJson(messageVO);
		LOG.debug("jsonString:" + jsonString);
		return jsonString;
	}


	// password 검사
	@RequestMapping(value = "/doCheckPassword.do", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	@ResponseBody // HTTP 요청 부분의 body 부분이 그대로 브라우저에 전달
	public int doCheckPassword(UserVO inVO) throws SQLException {

		LOG.debug("┌───────────────────┐");
		LOG.debug("┃  doCheckPassword()     │ inVO: " + inVO);
		LOG.debug("└───────────────────┘");

		int flag = userService.doCheckPassword(inVO);

		return flag;
	}

	@PostMapping(value = "/doSave.do", produces = "application/json;charset=UTF-8")
	@ResponseBody // HTTP 요청 부분의 body 부분이 그대로 브라우저에 전달
	public String doSave(UserVO inVO) throws Exception {
		String jsonString = "";

		LOG.debug("┌───────────────────┐");
		LOG.debug("┃  doSave()     │ inVO: " + inVO);
		LOG.debug("└───────────────────┘");


		int flag = userService.doSave(inVO);
		String message = "";

		if (flag == 1)
			message = "회원가입 되었습니다";
		else
			message = "회원가입 실패";

		MessageVO messageVO = new MessageVO(flag + "", message);
		jsonString = new Gson().toJson(messageVO);
		LOG.debug("jsonString: " + jsonString);

		return jsonString;
	}

	// ============================= 회원 목록 조회 =====================================

		@GetMapping(value = "/doRetrieve.do")
		public ModelAndView doRetrieve(UserVO inVO, ModelAndView modelAndView) throws SQLException {
			LOG.debug("─────────────────────────────────────");
			LOG.debug(" doRetrieve"                          );
			LOG.debug(" UserVO: " + inVO                 );
			LOG.debug("─────────────────────────────────────");
			// Default처리
			// 페이지 사이즈:10
			if (null != inVO && inVO.getPageSize() == 0) {
				inVO.setPageSize(10L);
			}

			// 페이지 번호:1
			if (null != inVO && inVO.getPageNo() == 0) {
				inVO.setPageNo(1L);
			}

			// 검색구분:""
			if (null != inVO && null == inVO.getSearchDiv()) {
				inVO.setSearchDiv(StringUtil.nvl(inVO.getSearchDiv()));
			}
			// 검색어:""
			if (null != inVO && null == inVO.getSearchWord()) {
				inVO.setSearchDiv(StringUtil.nvl(inVO.getSearchWord()));
			}
			LOG.debug("User Default처리: " + inVO);
			
			Map<String, Object> codes = new HashMap<String, Object>();
			String[] codeStr = { "PAGE_SIZE", "SEARCH" };

			codes.put("code", codeStr);
			List<CodeVO> codeList = this.codeService.doRetrieve(codes);

			List<CodeVO> userSearchList = new ArrayList<CodeVO>();
			List<CodeVO> pageSizeList = new ArrayList<CodeVO>();
			
			for (CodeVO vo : codeList) {
				if (vo.getCategory().equals("SEARCH")) {
					userSearchList.add(vo);
				}

				if (vo.getCategory().equals("PAGE_SIZE")) {
					pageSizeList.add(vo);
				}
			}
			List<UserVO> list = userService.doRetrieve(inVO);
			
			long totalCnt = 0;
			
			for(UserVO vo: list) {
				if(totalCnt == 0) {
					totalCnt = vo.getTotalCnt();
					break;
				}
			}
			modelAndView.addObject("totalCnt", totalCnt);
			
			modelAndView.setViewName("user/user_list");
			modelAndView.addObject("list", list);
			modelAndView.addObject("paramVO", inVO);
			modelAndView.addObject("userSearch", userSearchList);
			modelAndView.addObject("pageSize", pageSizeList);
			
			long bottomCount = StringUtil.BOTTOM_COUNT;// 바닥글
			String html = StringUtil.renderingPager(totalCnt, inVO.getPageNo(), inVO.getPageSize(), bottomCount,
					"/commerce/user/doRetrieve.do", "pageDoRerive");
			modelAndView.addObject("pageHtml", html);

			String title = "회원목록";
			modelAndView.addObject("title", title);
			
			
			return modelAndView;
			}

	
}