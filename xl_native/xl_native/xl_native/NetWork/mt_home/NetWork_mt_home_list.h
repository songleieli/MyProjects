//
//  NetWork_topicPraise.h
//  CMPLjhMobile
//
//  Created by songlei on 16/5/31.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "WCServiceBase.h"


/*
 {
 "noodleVideoId": 987654321087654326,
 "noodleId": "123456789012345673",
 "noodleVideoName": "我会火的5",
 "noodleVideoCover": "http://192.168.180.130/miantiao/cover/20181115/987654321087654326.jpg",
 "videoUrl": "http://192.168.180.130/miantiao/video/20181115/987654321087654326.mp4",
 "size": "100",
 "stealshowNoodleId": null,
 "matchshowNoodleId": null,
 "musicUrl": "http://192.168.180.130/miantiao/music/20181115/987654321087654326.mp3",
 "title": "我会火的5",
 "topic": "#万圣节",
 "addr": "天安门广场",
 "iswholook": 1,
 "likeSum": 3237,
 "dslikeSum": 0,
 "forwardWechatFriendSum": 2,
 "forwardCircleofFriendSum": 25,
 "forwardQQFriendSum": 2,
 "forwardQQzoneSum": 2,
 "generateNvQrcodeSum": 0,
 "saveAlbumSum": 0,
 "copyLinkSum": 0,
 "stealshowSum": 1,
 "matchshowSum": 1,
 "status": 1,
 "head": "http://192.168.180.130/miantiao/head/20181115/123456789012345673.jpg",
 "nickname": "火车飞侠5",
 "forwardSum": 31,
 "commentSum": 0,
 "createTime": "2018-11-15 11:11:46"
 }
 */

@interface HomeListModel : IObjcJsonBase

@property (copy, nonatomic) NSString *noodleVideoId;
@property (copy, nonatomic) NSString *noodleId;
@property (copy, nonatomic) NSString *noodleVideoName;
@property (copy, nonatomic) NSString *noodleVideoCover;
@property (copy, nonatomic) NSString *videoUrl;
@property (copy, nonatomic) NSString *size;
@property (copy, nonatomic) NSString *stealshowNoodleId;
@property (copy, nonatomic) NSString *matchshowNoodleId;
@property (copy, nonatomic) NSString *musicUrl;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *topic;
@property (copy, nonatomic) NSString *addr;
@property (copy, nonatomic) NSString *iswholook;
@property (strong, nonatomic) NSNumber *likeSum;
@property (copy, nonatomic) NSString *dslikeSum;
@property (copy, nonatomic) NSString *forwardWechatFriendSum;
@property (copy, nonatomic) NSString *forwardCircleofFriendSum;
@property (copy, nonatomic) NSString *forwardQQFriendSum;
@property (copy, nonatomic) NSString *forwardQQzoneSum;
@property (copy, nonatomic) NSString *generateNvQrcodeSum;
@property (copy, nonatomic) NSString *saveAlbumSum;
//@property (copy, nonatomic) NSString *copyLinkSum;
@property (copy, nonatomic) NSString *stealshowSum;
@property (copy, nonatomic) NSString *matchshowSum;
@property (copy, nonatomic) NSString *status;
@property (copy, nonatomic) NSString *head;
@property (copy, nonatomic) NSString *nickname;
@property (copy, nonatomic) NSString *forwardSum;
@property (copy, nonatomic) NSString *commentSum;
//@property (copy, nonatomic) NSString *forwardSum;
@property (copy, nonatomic) NSString *createTime;
@end



@interface HomeListResponse : IObjcJsonBase

@property(nonatomic,copy) NSString * status;
@property(nonatomic,copy) NSString * message;
@property(nonatomic,strong) NSArray * obj;

@end

@interface NetWork_mt_home_list : WCServiceBase

@property (nonatomic,strong) NSString * pageNo;
@property (nonatomic,strong) NSString * pageSize;

@end
