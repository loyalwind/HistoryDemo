//
//  PKLoadingView.m
//  Texas_Cocos-mobile
//
//  Created by pengweijian on 2019/12/17.
//

#import "PKLoadingView.h"
#import "UIView+Extension.h"

@interface PKLoadingView ()
/** description */
@property (nonatomic, weak) UIImageView *innerImageView;
@property (nonatomic, weak) UIImageView *rotateImageView;
@end

@implementation PKLoadingView
SingleImplementation(Loading)

- (void)show
{
    if (self.superview) {
        [self.superview bringSubviewToFront:self];
        self.frame = self.superview.bounds;
    }else {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        self.frame = window.bounds;
        [window addSubview:self];
    }
    self.hidden = NO;

    [self startAnimating];
}

- (void)startAnimating
{
    CABasicAnimation *rotate = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotate.toValue = @(M_PI*2.0);
    rotate.duration = 1.0;
    rotate.repeatCount = HUGE_VALF;
    rotate.removedOnCompletion = NO;
    [self.rotateImageView.layer addAnimation:rotate forKey:@"rotationAnimation"];
}

- (void)dismiss
{
    self.hidden = YES;
    [_rotateImageView.layer removeAllAnimations];
}

- (UIImageView *)innerImageView
{
    if (!_innerImageView) {
        UIImageView *innerImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading_fixed_img.png"]];
        //按照原始比例缩放图片，保持宽高比
        innerImgV.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:innerImgV];
        _innerImageView = innerImgV;
    }
    return _innerImageView;
}

- (UIImageView *)rotateImageView
{
    if (!_rotateImageView) {
        UIImageView *rotateImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading_rotate_img.png"]];
        rotateImgV.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:rotateImgV];
        _rotateImageView = rotateImgV;
    }
    return _rotateImageView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    self.innerImageView.size = CGSizeMake(22, 22);
    self.rotateImageView.size = CGSizeMake(33, 33);
    self.innerImageView.center = self.center;
    self.rotateImageView.center = CGPointMake(self.center.x+0.2, self.center.y+0.2);
}

- (void)dealloc
{
    [self dismiss];
}

@end
