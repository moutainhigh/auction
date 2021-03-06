package com.trump.auction.cust.service;


import com.trump.auction.cust.model.NotificationDeviceModel;

/**
 * Author: zhanping
 */
public interface NotificationDeviceService {

    /**
     * 根据设备id添加或者更新对应的推送设备
     * @param obj
     * @return
     */
    int save(NotificationDeviceModel obj);
}
