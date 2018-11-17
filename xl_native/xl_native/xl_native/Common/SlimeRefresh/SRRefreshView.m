//
//  SRRefreshView.m
//  SlimeRefresh
//
//  Created by zrz on 12-6-15.
//  Copyright (c) 2012年 zrz. All rights reserved.
//

#import "SRRefreshView.h"
#import "SRSlimeView.h"
#import "SRDefine.h"
#import <QuartzCore/QuartzCore.h>

@interface SRRefreshView()

@property (nonatomic, assign)   BOOL    broken;
@property (nonatomic, strong)   UIScrollView    *scrollView;

@end

@implementation SRRefreshView {
    UIActivityIndicatorView *_activityIndicatorView;
    CGFloat     _oldLength;
    BOOL        _unmissSlime;
    CGFloat     _dragingHeight;
}

@synthesize labelState = _labelState;
@synthesize delegate = _delegate, broken = _broken;
@synthesize loading = _loading, scrollView = _scrollView;
@synthesize slime = _slime, refleshView = _refleshView;
@synthesize block = _block, upInset = _upInset;
@synthesize slimeMissWhenGoingBack = _slimeMissWhenGoingBack;
@synthesize activityIndicationView = _activityIndicatorView;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _slime = [[SRSlimeView alloc] initWithFrame:
                  CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height)];
        _slime.startPoint = CGPointMake(frame.size.width / 2, frame.size.height / 2);
        [self addSubview:_slime];
        
        _labelState = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, frame.size.width, 21)];
        _labelState.backgroundColor = [UIColor clearColor];
        _labelState.textAlignment = NSTextAlignmentCenter;
        _labelState.textColor = [UIColor colorWithRed:128/225.0 green:128/225.0 blue:128/225.0 alpha:1];
        _labelState.font = [UIFont defaultFontWithSize:13];
//        _labelState.text = @"刷新成功";
        _labelState.text = @"";

        _labelState.hidden = YES;
        [self addSubview:_labelState];
        
        _refleshView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sr_refresh"]];
        _refleshView.center = _slime.startPoint;
        _refleshView.bounds = CGRectMake(0.0f, 0.0f, kRefreshImageWidth, kRefreshImageWidth);
        [self addSubview:_refleshView];
        
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//        _activityIndicatorView.color = [GlobalFunc colorWithHex:@"#0F99E1" alpha:1];
        [_activityIndicatorView stopAnimating];
        _activityIndicatorView.center = _slime.startPoint;
        [self addSubview:_activityIndicatorView];
        
        [_slime setPullApartTarget:self action:@selector(pullApart:)];
        _dragingHeight = frame.size.height;
    }
    return self;
}

#pragma mark - setters

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    if (_slime.state == SRSlimeStateNormal) {
        _slime.frame = CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height);
        _slime.startPoint = CGPointMake(frame.size.width / 2, _dragingHeight / 2);
    }
    _refleshView.center = _slime.startPoint;
    _activityIndicatorView.center = _slime.startPoint;
}

- (void)setUpInset:(CGFloat)upInset
{
    _upInset = upInset;
    UIEdgeInsets inset = _scrollView.contentInset;
    inset.top = _upInset;
    _scrollView.contentInset = inset;
    
}

- (void)setSlimeMissWhenGoingBack:(BOOL)slimeMissWhenGoingBack
{
    _slimeMissWhenGoingBack = slimeMissWhenGoingBack;
    if (!slimeMissWhenGoingBack) {
        _slime.alpha = 1;
    }else {
        //oyxc 注释
//        CGPoint p = _scrollView.contentOffset;
//        self.alpha = -(p.y + _upInset) / _dragingHeight;
    }
}

- (void)setLoading:(BOOL)loading
{
    if (_loading == loading) {
        return;
    }
    _loading = loading;
    if (_loading) {
        [_activityIndicatorView startAnimating];
        CAKeyframeAnimation *aniamtion = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        
        aniamtion.values = [NSArray arrayWithObjects:
                            [NSValue valueWithCATransform3D:
                             CATransform3DRotate(CATransform3DMakeScale(0.01, 0.01, 0.1),
                             -M_PI, 0, 0, 1)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.6, 1.6, 1)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity],nil];
        aniamtion.keyTimes = [NSArray arrayWithObjects:
                              [NSNumber numberWithFloat:0],
                              [NSNumber numberWithFloat:0.6],
                              [NSNumber numberWithFloat:1], nil];
        aniamtion.timingFunctions = [NSArray arrayWithObjects:
                                     [CAMediaTimingFunction functionWithName:
                                      kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:
                                      kCAMediaTimingFunctionEaseInEaseOut],
                                      nil];
        aniamtion.duration = 0.7;
        _activityIndicatorView.layer.transform = CATransform3DIdentity;
        [_activityIndicatorView.layer addAnimation:aniamtion
                                            forKey:@""];
        //_slime.hidden = YES;
        _refleshView.hidden = YES;
        if (!_scrollView.isDragging) {
            UIEdgeInsets inset = _scrollView.contentInset;
            inset.top = _upInset + _dragingHeight;
            _scrollView.contentInset = inset;
        }
        if (!_unmissSlime){
            _slime.state = SRSlimeStateMiss;
        }else {
            _unmissSlime = NO;
        }
    }else {
        
        [_activityIndicatorView stopAnimating];
        _slime.hidden = NO;
        _refleshView.hidden = NO;
        _refleshView.layer.transform = CATransform3DIdentity;
        [UIView transitionWithView:_scrollView
                          duration:0.3f
                           options:UIViewAnimationOptionCurveEaseOut
                        animations:^{
                            UIEdgeInsets inset = _scrollView.contentInset;
                            inset.top = _upInset;
                            _scrollView.contentInset = inset;
                            //oyxc 注释
//                            if (_scrollView.contentOffset.y == -_upInset &&
//                                _slimeMissWhenGoingBack) {
//                                self.alpha = 0.0f;
//                            }
                        } completion:^(BOOL finished) {
                            //_notSetFrame = NO;
                        }];
        
    }
}

- (void)setLoadingWithexpansion
{
    self.loading = YES;
    [_scrollView setContentOffset:CGPointMake(_scrollView.contentOffset.x, -_scrollView.contentInset.top)
                         animated:YES];
}

- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    if ([self.superview isKindOfClass:[UIScrollView class]]) {
        self.scrollView = (id)[self superview];
        CGRect rect = self.frame;
        rect.origin.y = rect.size.height?-rect.size.height:-_dragingHeight;
        rect.size.width = _scrollView.frame.size.width;
        self.frame = rect;
        self.slime.toPoint = self.slime.startPoint;
        
        UIEdgeInsets inset = self.scrollView.contentInset;
        inset.top = _upInset;
        self.scrollView.contentInset = inset;
    }else if (!self.superview) {
        self.scrollView = nil;
    }
}

#pragma mark - action

- (void)pullApart:(SRRefreshView*)refreshView
{
    //拉断了
    self.broken = YES;
    _unmissSlime = YES;
    self.loading = YES;
    if ([_delegate respondsToSelector:@selector(slimeRefreshStartRefresh:)]) {
        [(id)_delegate performSelector:@selector(slimeRefreshStartRefresh:)
                            withObject:self
                            afterDelay:0.0];
    }
    if (_block) {
        _block(self);
    }
}

- (void)scrollViewDidScroll
{
    CGPoint p = _scrollView.contentOffset;
    CGRect rect = self.frame;
    if (p.y <= - _dragingHeight - _upInset) {
        rect.origin.y = p.y + _upInset;
        rect.size.height = -p.y;
        rect.size.height = ceilf(rect.size.height);
        self.frame = rect;
        if (!self.loading) {
            [_slime setNeedsDisplay];
        }
        if (!_broken) {
            float l = -(p.y + _dragingHeight + _upInset);
            if (l <= _oldLength) {
                l = MIN(distansBetween(_slime.startPoint, _slime.toPoint), l);
                CGPoint ssp = _slime.startPoint;
                _slime.toPoint = CGPointMake(ssp.x, ssp.y + l);
                CGFloat pf = (1.0f-l/_slime.viscous) * (1.0f-kStartTo) + kStartTo;
                _refleshView.layer.transform = CATransform3DMakeScale(pf, pf, 1);
            }else if (self.scrollView.isDragging) {
                CGPoint ssp = _slime.startPoint;
                _slime.toPoint = CGPointMake(ssp.x, ssp.y + l);
                CGFloat pf = (1.0f-l/_slime.viscous) * (1.0f-kStartTo) + kStartTo;
                _refleshView.layer.transform = CATransform3DMakeScale(pf, pf, 1);
            }
            _oldLength = l;
        }
        if (self.alpha != 1.0f) self.alpha = 1.0f;
    }else if (p.y < -_upInset) {
        rect.origin.y = -_dragingHeight;
        rect.size.height = _dragingHeight;
        self.frame = rect;
        [_slime setNeedsDisplay];
        _slime.toPoint = _slime.startPoint;
        //oyxc 注释
//        if (_slimeMissWhenGoingBack) self.alpha = -(p.y + _upInset) / _dragingHeight;
    }
}

- (void)scrollViewDidEndDraging
{
    if (_broken) {
        if (self.loading) {
            [UIView transitionWithView:_scrollView
                              duration:0.2
                               options:UIViewAnimationOptionCurveEaseOut
                            animations:^{
                                UIEdgeInsets inset = _scrollView.contentInset;
                                inset.top = _upInset + _dragingHeight;
                                _scrollView.contentInset = inset;
                            } completion:^(BOOL finished) {
                                self.broken = NO;
                            }];
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.2f];
            [UIView commitAnimations];
        }else {
            [self performSelector:@selector(setBroken:)
                       withObject:nil afterDelay:0.2];
            self.loading = NO;
        }
    }
}

- (void)endRefresh
{
    if (self.loading) {
        //_notSetFrame = YES;
        [self performSelector:@selector(restore)
                   withObject:nil
                   afterDelay:0.4];
    }
    _oldLength = 0;
}

- (void)restore
{
    _slime.toPoint = _slime.startPoint;
    [UIView transitionWithView:_activityIndicatorView
                      duration:0.4f
                       options:UIViewAnimationOptionCurveEaseIn
                    animations:^
     {
         _activityIndicatorView.layer.transform = CATransform3DRotate(CATransform3DMakeScale(0.01f, 0.01f, 0.1f), -M_PI, 0, 0, 1);
     } completion:^(BOOL finished)
     {
         _labelState.hidden = NO;
         [self performSelector:@selector(stopFresh) withObject:nil afterDelay:0.3f];
     }];
    
    
}

- (void)stopFresh
{
    _labelState.hidden = YES;
    self.loading = NO;
    _slime.state = SRSlimeStateNormal;
}

@end
