package com.test.commerce.user.domain;

import com.test.commerce.cmn.DTO;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class UserVO extends DTO{

	private String id;
	private String pw;
	private String nickName;
	private String name;
	private String phone;
	private String email;
	private String regDt;
	
	@Override
	public String toString() {
		return "UserVO [id=" + id + ", pw=" + pw + ", nickName=" + nickName + ", name=" + name + ", phone=" + phone
				+ ", email=" + email + ", regDt=" + regDt + ", toString()=" + super.toString() + "]";
	}
	
	

	

}
