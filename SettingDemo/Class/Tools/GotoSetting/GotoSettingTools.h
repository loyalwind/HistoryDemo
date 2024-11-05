//
//  GotoSettingTools.h
//  ToolsDemo
//
//  Created by pengweijian on 2017/8/29.
//  Copyright © 2017年 pengweijian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

typedef NS_ENUM(NSInteger,SettingType) {
    SettingTypeAbout                = 0 ,/**< 通用->关于本机 */
    SettingTypeGeneralACCESSIBILITY     ,/**< 通用->辅助功能 */
    SettingTypeGeneralCELLULAR_USAGE    ,/**< 通用 */
    SettingTypeBluetooth                ,/**< 蓝牙 */
    SettingTypeGeneralDATE_AND_TIME     ,/**< 日期和时间 */
    SettingTypeFACETIME                 ,/**< FACETIME */
    SettingTypeGeneral                  ,/**< 通用 */
    SettingTypeGeneralKeyboard          ,/**< 通用->键盘 */
    SettingTypeCASTLE                   ,/**< iCloud */
    SettingTypeCASTLESTORAGE_AND_BACKUP ,/**< iCloud->存储空间 */
    SettingTypeGeneralINTERNATIONAL     ,/**< 语言地区 */
    SettingTypeLOCATION_SERVICES        ,/**<   */
    SettingTypeACCOUNT_SETTINGS         ,/**< 邮件 */
    SettingTypeMUSIC                    ,/**< 音乐 */
    SettingTypeNOTES                    ,/**< 备忘录 */
    SettingTypeNOTIFICATIONS_ID         ,/**< 通知 */
    SettingTypePhone                    ,/**< 电话 */
    SettingTypePhotos                   ,/**< 照片与相机 */
    SettingTypeGeneralManagedConfigurationList ,/**< 通用->描述文件与设备管理 */
    SettingTypeGeneralReset     ,/**< 通用->还原 */
    SettingTypeSoundsRingtone   ,/**< 声音->电话铃声 */
    SettingTypeSafari           ,/**<  */
    SettingTypeSIRI             ,/**<  SIRI*/
    SettingTypeSounds           ,/**< 声音 */
    SettingTypeGeneralSOFTWARE_UPDATE_LINK ,/**< 软件更新 */
    SettingTypeSTORE             ,/**< iTunes Store */
    SettingTypeTWITTER           ,/**< Twitter */
    SettingTypeFACEBOOK          ,/**< FaceBook */
    SettingTypeGeneralUSAGE      ,/**< 通用 */
    SettingTypeVIDEO             ,/**< 视频 */
    SettingTypeGeneralVPN        ,/**< VPN */
    SettingTypeWallpaper         ,/**< 墙纸 */
    SettingTypeWIFI              ,/**< WIFI */
    SettingTypeNTERNET_TETHERING ,/**< 个人热点 */
    SettingTypeMOBILE_DATA_SETTINGS_ID  ,/**< 蜂窝移动网络 */
    SettingTypeSettings          ,/**< 设置 */
    SettingTypeCarrier          ,/**< 运营商 */
    SettingTypePrivacy          ,/**< 隐私 */
    SettingTypeMusic_EQ         ,/**< 音乐-均衡器  */
};


@interface GotoSettingTools : NSObject
SingleInterface(Tools);

@property (nonatomic, strong, readonly) NSArray<NSString *> *settings;

- (void)jumpToSettingType:(SettingType)type;

@end
