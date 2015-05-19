//
//  AppDelegate.swift
//  SwiftShareSDK
//
//  Created by lisk@uuzu.com on 15/5/12.
//  Copyright (c) 2015年 lisk@uuzu.com. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
         //各平台申请key的方法可参阅：http://bbs.mob.com/forum.php?mod=viewthread&tid=275&page=1&extra=#pid860
         //1.初始化ShareSDK应用,字符串"4a88b2fb067c"换成你申请的ShareSDK应用的Appkey，这个key来源于ShareSDK官网上申请获得
        ShareSDK.registerApp("3df7a36158b2")
        
/**---------------------------------------------------------**/
        
        //2.初始化新浪微博
        ShareSDK.connectSinaWeiboWithAppKey("568898243", appSecret: "38a4f8204cc784f81f9f0daaf31e02e3", redirectUri: "http://www.sharesdk.cn", weiboSDKCls: WeiboSDK.classForCoder())
        //上面的方法会又客户端跳客户端，没客户端条web.
        
        //下面这方法，如果不想用新浪客户端授权只用web的话就可以使用。
        
        //[ShareSDK connectSinaWeiboWithAppKey:<#(NSString *)#> appSecret:<#(NSString *)#> redirectUri:<#(NSString *)#>]

/**---------------------------------------------------------**/
        
        //初始化微信，微信开放平台上注册应用
        ShareSDK.connectWeChatWithAppId("wx4868b35061f87885",appSecret:"64020361b8ec4c99936c0e3999a9f249",wechatCls:WXApi.classForCoder());
        
        //如果在分享菜单中想取消微信收藏，可以初始化微信及微信朋友圈，取代上面整体初始化的方法
        //微信好友[ShareSDK connectWeChatSessionWithAppId:<#(NSString *)#> appSecret:<#(NSString *)#> wechatCls:<#(__unsafe_unretained Class)#>]
        //微信朋友圈[ShareSDK connectWeChatTimelineWithAppId:<#(NSString *)#> appSecret:<#(NSString *)#> wechatCls:<#(__unsafe_unretained Class)#>]

/**---------------------------------------------------------**/
        
        //初始化QQ,QQ空间，使用同样的key，请在腾讯开放平台上申请，注意导入头文件：
        /**
        已经在桥街文件ShareSDK-Bridging-Header.h中导入
        
        #import <TencentOpenAPI/QQApiInterface.h>
        #import <TencentOpenAPI/TencentOAuth.h>
        **/
        //连接QQ应用
        ShareSDK.connectQQWithQZoneAppKey("100371282", qqApiInterfaceCls: QQApiInterface.classForCoder(), tencentOAuthCls: TencentOAuth.classForCoder())
        //连接QQ空间应用
        ShareSDK.connectQZoneWithAppKey("100371282", appSecret: "aed9b0303e3ed1e27bae87c33761161d", qqApiInterfaceCls: QQApiInterface.classForCoder(), tencentOAuthCls: TencentOAuth.classForCoder())

/**---------------------------------------------------------**/
        
        return true
    }
    
    
    //添加两个回调方法,return的必须要ShareSDK的方法
    func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
        
        return ShareSDK.handleOpenURL(url, wxDelegate: self)
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject? ) -> Bool{
        
        return ShareSDK.handleOpenURL(url, sourceApplication: sourceApplication, annotation: annotation, wxDelegate: self)
    }
    
    

}

