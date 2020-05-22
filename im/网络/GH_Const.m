//
//  GH_Const.m
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/19.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "GH_Const.h"

//  注册登录
NSString * const UserLogin = @"/user/login";
//验证码
NSString * const getCode = @"/user/getCode";
//微信或者QQ绑定手机号
NSString * const userFirstLogin = @"/user/firstLogin";
//忘记密码
NSString * const forgetPassword = @"/user/forgetPassword";
//修改用户信息
NSString * const changeUserMessage = @"/user/updateUser";
//修改用户手机号
NSString * const changUserPhone = @"/user/changePhone";
//获取阿里云上传凭证
NSString * const getALiOSS = @"/sts/oss";
//常见问题
NSString * const questionList = @"/questions/selectQuestion";
//我要融资
NSString * const Merchant = @"/merchant/insertMerchant";
//首页Bannaer
NSString * const HomeBanner = @"/banner/selectBanner";
//咨询留言标签
NSString * const selectLabel = @"/label/selectLabel";
//提交留言
NSString * const leaveMessage = @"/seek/insertSeek";
//问题反馈
NSString * const questionFeedBack = @"/feedBack/insertFeedBack";
//留言结果
NSString * const leaveMessageResult = @"/seek/selectSeek";
//判断是否留言
NSString * const leaveState = @"/seek/selectSeekState";
//购买服务列表
NSString * buyServiceList = @"/services/selectService";
//常见问题次数统计
NSString * commonQuestionCount = @"/questions/readQuestion";
//定金付款
NSString * paymenOrder = @"/order/paymentOrder";
//已购买服务列表
NSString * alreadyBuyService = @"/order/selectOrderAll";
//订单列表
NSString * orderList = @"/order/selectPartOrderAll";
//尾款付款
NSString * lastPaymentOrder = @"/order/lastPaymentOrder";
//订单确认完成
NSString * sureCompletement = @"/order/finishOrder";
//评价订单
NSString * evaluateOrder = @"/order/evaluateOrder";
//查询最新消息
NSString * lastMessage = @"/message/lastMessage";
//所有消息
NSString * allMessage = @"/message/selectAllMessage";
//用户协议
NSString * systemSet = @"/system/selectSystem";
//用户投诉
NSString * complaints = @"/feedBack/insertComplaint";
//删除留言
NSString * deleteLeaveMessage = @"/seek/deleteSeek";
//推荐服务列表
NSString * selectLawyerReCommend = @"/feedBack/selectLawyerReCommend";
//获取已购买数据
NSString * selectOrderById = @"/order/selectOrderById";
//liuyan
NSString * selectSeekById = @"/seek/selectSeekById";
//删除推荐服务
NSString * deleteReCommendNum = @"/feedBack/deleteReCommendNum";
//未支付推荐服务
NSString * selectReCommendNum = @"/feedBack/selectReCommendNum";
//获取邀请好友信息
NSString * inviteFriends = @"/user/inviteFriends";
//我的邀请
NSString * myInvitation = @"/user/myInvitation";
