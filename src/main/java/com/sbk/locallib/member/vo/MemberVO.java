package com.sbk.locallib.member.vo;

import lombok.Data;

@Data
public class MemberVO {
   private String user_id;
   private String pw;
   private String name;
   private String nickname;
   private String phone;
   private int phone_auth;
   private String postcode;
   private String addr1;
   private String addr2;
   private String email;
   private String birthday;
   private int gender;
   private int user_gb;
   private String join_date;
   private int state_gb;
}