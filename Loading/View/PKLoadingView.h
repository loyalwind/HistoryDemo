//
//  PKLoadingView.h
//  Texas_Cocos-mobile
//
//  Created by pengweijian on 2019/12/17.
//

#import <UIKit/UIKit.h>
#import "Singleton.h"

NS_ASSUME_NONNULL_BEGIN

@interface PKLoadingView : UIView
SingleInterface(Loading)
- (void)show;
- (void)dismiss;
@end

NS_ASSUME_NONNULL_END
