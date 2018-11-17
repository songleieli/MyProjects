//
//  SamPlayerScrollView.m
//  inke
//
//  Created by Sam on 2/7/17.
//  Copyright © 2017 Zhejiang University of Tech. All rights reserved.
//

#import "SwitchPlayerScrollView.h"

@interface SwitchPlayerScrollView () <UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray * videoList;
@property (nonatomic, strong) HomeListModel *live;
@property (nonatomic, strong) UIImageView *upperImageView, *middleImageView, *downImageView;
@property (nonatomic, strong) HomeListModel *upperLive, *middleLive, *downLive;
@property (nonatomic, assign) NSInteger currentIndex, previousIndex;

@end

@implementation SwitchPlayerScrollView

- (NSMutableArray *)videoList
{
    if (!_videoList) {
        _videoList = [NSMutableArray array];
    }
    return _videoList;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.contentSize = CGSizeMake(0, frame.size.height * 3);
        self.contentOffset = CGPointMake(0, frame.size.height);
        self.pagingEnabled = YES;
        self.opaque = YES;
        self.backgroundColor = [UIColor yellowColor];
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.delegate = self;
        
        if (@available(iOS 11.0, *)) { //20px
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
        // image views
        // blur effect 模糊效果
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        // blur view
        UIVisualEffectView *visualEffectViewUpper = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        UIVisualEffectView *visualEffectViewMiddle = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        UIVisualEffectView *visualEffectViewDown = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        self.upperImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.middleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, frame.size.height, frame.size.width, frame.size.height)];
        self.downImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, frame.size.height*2, frame.size.width, frame.size.height)];
        // add image views
        [self addSubview:self.upperImageView];
        [self addSubview:self.middleImageView];
        [self addSubview:self.downImageView];
        
        self.upperImageView.backgroundColor = [UIColor redColor];
        self.middleImageView.backgroundColor = [UIColor orangeColor];
        self.downImageView.backgroundColor = [UIColor greenColor];
        
        //暂时先屏蔽模糊效果
        visualEffectViewUpper.frame = self.upperImageView.frame;
        [self addSubview:visualEffectViewUpper];
        visualEffectViewMiddle.frame = self.middleImageView.frame;
        [self addSubview:visualEffectViewMiddle];
        visualEffectViewDown.frame = self.downImageView.frame;
        [self addSubview:visualEffectViewDown];
    }
    return self;
}

- (void)updateForLives:(NSMutableArray *)livesArray withCurrentIndex:(NSInteger)index{
    
    //如果视频小于3条，则无需滚动。add by songleilei 2018.11.09
    if(livesArray.count < 3){
        self.scrollEnabled = NO;
    }
    else{
        self.scrollEnabled = YES;
    }
    
    if (livesArray.count && [livesArray firstObject]) {
        [self.videoList removeAllObjects];
        [self.videoList addObjectsFromArray:livesArray];
        self.currentIndex = index;
        self.previousIndex = index;
        
        _upperLive = [[HomeListModel alloc] init];
        _middleLive = (HomeListModel *)_videoList[_currentIndex];
        _downLive = [[HomeListModel alloc] init];
        
        if (_currentIndex == 0) {
            _upperLive = (HomeListModel *)[_videoList lastObject];
        } else {
            _upperLive = (HomeListModel *)_videoList[_currentIndex - 1];
        }
        if (_currentIndex == _videoList.count - 1) {
            _downLive = (HomeListModel *)[_videoList firstObject];
        } else {
            _downLive = (HomeListModel *)_videoList[_currentIndex + 1];
        }
        
        [self prepareForImageView:self.upperImageView withLive:_upperLive];
        [self prepareForImageView:self.middleImageView withLive:_middleLive];
        [self prepareForImageView:self.downImageView withLive:_downLive];
    }
}

- (void) prepareForImageView: (UIImageView *)imageView withLive:(HomeListModel *)live{
    
    if(live.videoUrl > 0){
//        HomeListModel *imageModel = [live.medias objectAtIndex:0];
//        NSString *breviaryUrl = [NSString stringWithFormat:@"%@@thumb.jpg",imageModel.breviaryUrl];
        [imageView sd_setImageWithURL:[NSURL URLWithString:live.noodleVideoCover] placeholderImage:[UIImage imageNamed:@"neighborhood_defuot"]];
    }
}

- (void)switchPlayer:(UIScrollView*)scrollView
{
    CGFloat offset = scrollView.contentOffset.y;
    
    NSLog(@"offset ===== %f",offset);
    
    
    if (self.videoList.count) {
        if (offset >= 2*self.frame.size.height)
        {
            // slides to the down player
            scrollView.contentOffset = CGPointMake(0, self.frame.size.height);
            _currentIndex++;
            self.upperImageView.image = self.middleImageView.image;
            self.middleImageView.image = self.downImageView.image;
            if (_currentIndex == self.videoList.count - 1)
            {
                _downLive = [self.videoList firstObject];
            } else if (_currentIndex == self.videoList.count)
            {
                _downLive = self.videoList[1];
                _currentIndex = 0;
                
            } else
            {
                _downLive = self.videoList[_currentIndex+1];
            }
            [self prepareForImageView:self.downImageView withLive:_downLive];
            if (_previousIndex == _currentIndex) {
                return;
            }
            if ([self.playerDelegate respondsToSelector:@selector(playerScrollView:currentPlayerIndex:)]) {
                [self.playerDelegate playerScrollView:self currentPlayerIndex:_currentIndex];
                _previousIndex = _currentIndex;
                NSLog(@"current index in delegate: %ld -%s",_currentIndex,__FUNCTION__);
            }
        }
        else if (offset <= 0)
        {
            // slides to the upper player
            scrollView.contentOffset = CGPointMake(0, self.frame.size.height);
            _currentIndex--;
            self.downImageView.image = self.middleImageView.image;
            self.middleImageView.image = self.upperImageView.image;
            if (_currentIndex == 0)
            {
                _upperLive = [self.videoList lastObject];
                
            } else if (_currentIndex == -1)
            {
                _upperLive = self.videoList[self.videoList.count - 2];
                _currentIndex = self.videoList.count-1;
                
            } else
            {
                _upperLive = self.videoList[_currentIndex - 1];
            }
            [self prepareForImageView:self.upperImageView withLive:_upperLive];
            if (_previousIndex == _currentIndex) {
                return;
            }
            if ([self.playerDelegate respondsToSelector:@selector(playerScrollView:currentPlayerIndex:)]) {
                [self.playerDelegate playerScrollView:self currentPlayerIndex:_currentIndex];
                _previousIndex = _currentIndex;
                NSLog(@"current index in delegate: %ld -%s",_currentIndex,__FUNCTION__);
            }
        }
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self switchPlayer:scrollView];
}

@end
