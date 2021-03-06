package com.trump.auction.trade.pay.alipay;

public class AlipayConfig {  
  
    public static String ali_public_key  = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCnxj/9qwVfgoUh/y2W89L6BkRAFljhNhgPdyPuBV64bfQNN1PjbCzkIM6qRdKBoLPXmKKMiFYnkd6rAoprih3/PrQEB/VsW8OoM8fxn67UDYuyBTqA23MML9q1+ilIZwBC2AQ2UBVOrFXfFl75p6/B5KsiNG9zpgmLCUYuLkxpLQIDAQAB";  
    public static final String SIGN_ALGORITHMS = "SHA1WithRSA";  
    // 字符编码格式 目前支持 gbk 或 utf-8  
    public static String input_charset = "UTF-8";  
    // 签名方式 不需修改  
    public static String sign_type = "RSA";  
    public static String format = "json";  
    public static String gateway_url = "https://openapi.alipay.com/gateway.do";
}  