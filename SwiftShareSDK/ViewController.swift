//
//  ViewController.swift
//  SwiftShareSDK
//
//  Created by lisk@uuzu.com on 15/5/12.
//  Copyright (c) 2015年 lisk@uuzu.com. All rights reserved.
//
//注意,本Demo只是列举ShareSDK的初步使用方法,适合刚刚学习使用ShareSDK的小伙伴，提供了多个最多人使用的平台，基本上可以满足大部分使用者的需求。另外更多的平台使用方法基本一致。更进阶更高级更完整的使用方法请参考ShareSDK.h顶层类，或者到ShareSDK官方http://mob.com下载官方的demo或者咨询官方技术支持。


import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var versionLabel: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //获取当前ShareSDK的版本号
        self.versionLabel.text = ShareSDK.version()
    }
    
    //弹出分享菜单并分享的方法
    @IBAction func ShowShareMenu(sender: UIButton) {
        //定制分享信息
        var pic = NSBundle.mainBundle().pathForResource("ShareSDK", ofType: "jpg")
        
        var publishContent : ISSContent =
        ShareSDK.content("swift调用分享文字",
            defaultContent:"默认分享内容，没内容时显示",
            image:ShareSDK.imageWithPath(pic),
            title:"提示",
            url:"http://www.mob.com",
            description:"这是一条测试信息",
            mediaType:SSPublishContentMediaTypeNews)
        
        ShareSDK.showShareActionSheet(nil, shareList: nil, content: publishContent, statusBarTips: false, authOptions: nil, shareOptions: nil) { (ShareType, state:SSResponseState, statusInfo :ISSPlatformShareInfo!, error:ICMErrorInfo!, end:Bool) -> Void in
            
            if (state.value == SSResponseStateSuccess.value){
                println("分享成功")
            }else if (state.value == SSResponseStateFail.value){
                println("分享失败,错误码:\(error.errorCode()),错误描述:\(error.errorDescription())")
            }else if (state.value == SSResponseStateCancel.value){
                println("分享取消")
            }

        }
        
    }

    //该方法举例微信，新浪，QQ(可以打开网页授权开关，以免被苹果拒绝)的授权登录方法
    @IBAction func Oauth(sender: AnyObject) {
        
        var shareType : ShareType = ShareTypeWeixiTimeline
        
        switch sender.tag {
            
        case 6:
            shareType = ShareTypeWeixiSession  // 微信好友类型
        case 7:
            shareType = ShareTypeSinaWeibo//新浪微博类型
        case 8:
            shareType = ShareTypeQQSpace // QQ空间类型   ／ 授权登录使用QQ空间来实现
     
        default:
            println("-----")
        }
        
        ShareSDK.getUserInfoWithType(shareType, authOptions: nil) { (BOOL result, userInfo : ISSPlatformUser!, error : ICMErrorInfo!) in
            if(result){
                
                println("授权成功,已经获取用户信息")
                
                var uid = userInfo.uid()
                var nickname = userInfo.nickname()
                var profilename = userInfo.profileImage()
                println(userInfo.sourceData())
                //弹框显示下
                var alertView = UIAlertView(title : "ShareSDK-Swift超简易demo", message : "用户id : \(uid) ,昵称: \(nickname),用户头像:\(profilename)", delegate : self, cancelButtonTitle : "取消")
                alertView.show()
                
            }else{
                println("授权失败，错误码:\(error.errorCode()),错误描述:\(error.errorDescription())")
            }
        }
    }
    
    //QQ打开授权开关方法
    @IBAction func QQWebOauth(sender: UISwitch) {
        var app : ISSQZoneApp = ShareSDK.getClientWithType(ShareTypeQQSpace) as! ISSQZoneApp
        if(sender.on){
            app.setIsAllowWebAuthorize(true)
        }else{
            app.setIsAllowWebAuthorize(false)
        }
       
    }
    
    //取消授权方法
    @IBAction func CancelAuthWithAll(sender: AnyObject) {
        ShareSDK.cancelAuthWithType(ShareTypeSinaWeibo)
        ShareSDK.cancelAuthWithType(ShareTypeWeixiSession)
        ShareSDK.cancelAuthWithType(ShareTypeQQSpace)
    }
    
    //显示编辑框编辑分享内容并分享的方法
    @IBAction func EditBoxToShare(sender: UIButton) {
        var shareType : ShareType = ShareTypeWeixiTimeline
        
        switch sender.tag {
            
        case 1:
            shareType = ShareTypeWeixiTimeline // 微信朋友圈类型
        case 2:
            shareType = ShareTypeWeixiSession  // 微信好友类型
        case 3:
            shareType = ShareTypeQQ // QQ类型
        case 4:
            shareType = ShareTypeQQSpace // QQ空间类型
        case 5:
            shareType = ShareTypeSinaWeibo//新浪微博类型
        default:
            println("-----")
        }
        
        //定制分享信息
        var pic = NSBundle.mainBundle().pathForResource("ShareSDK", ofType: "jpg")
        
        var publishContent : ISSContent =
        ShareSDK.content("swift调用分享文字",
            defaultContent:"默认分享内容，没内容时显示",
            image:ShareSDK.imageWithPath(pic),
            title:"提示",
            url:"http://www.mob.com",
            description:"这是一条测试信息",
            mediaType:SSPublishContentMediaTypeNews)
        
        ShareSDK.showShareViewWithType(shareType, container: nil, content: publishContent, statusBarTips: false, authOptions: nil, shareOptions: nil, result: {(type:ShareType,state:SSResponseState,statusInfo:ISSPlatformShareInfo!,error:ICMErrorInfo!,end:Bool) in
            
            if (state.value == SSResponseStateSuccess.value){
                println("分享成功")
            }else if (state.value == SSResponseStateFail.value){
                println("分享失败,错误码:\(error.errorCode()),错误描述:\(error.errorDescription())")
            }else if (state.value == SSResponseStateCancel.value){
                println("分享取消")
            }
        })
    }
}