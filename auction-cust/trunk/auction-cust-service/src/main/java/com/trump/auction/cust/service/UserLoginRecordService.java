package com.trump.auction.cust.service;

import com.cf.common.utils.ServiceResult;
import com.trump.auction.cust.domain.UserLoginRecord;
import com.trump.auction.cust.model.UserLoginRecordModel;

import java.util.List;

/**
 * @Author=hanliangliang
 * @Date=2018/03/15
 */
public interface UserLoginRecordService {


    /**
     * 根据用户id查询登陆日志
     * @param id 用户id
     * @return ServiceResult
     */
    List<UserLoginRecord> selectRecordByUserId(Integer id);

    /**
     * 记录登陆日志
     * @param userLoginRecordModel 登陆信息
     * @return ServiceResult
     */
    ServiceResult loginRecord(UserLoginRecordModel userLoginRecordModel);

    /**
     * 统计登陆次数
     *  @param id 用户id
     * @return 登陆次数
     */
    Integer countRecordByUserId(Integer id);
}
