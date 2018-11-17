//
//  NetWork_ activityCommentList.h
//  CMPLjhMobile
//
//  Created by iOS开发 on 16/5/31.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//






/*
 
 
 
 
 */








#import "WCServiceBase_Zjsh.h"


//@interface ZjAdminLoginBaseEmployeeModel : IObjcJsonBase
//
//@property(nonatomic,copy) NSString * idcard;
//@property(nonatomic,copy) NSString * age;
//@property(nonatomic,copy) NSString * birthTime;
//@property(nonatomic,copy) NSString * post;
//@property(nonatomic,copy) NSString * employeeType;
//
//@end
//
//
//
//@interface ZjAdminLoginDataListModel : IObjcJsonBase
//
//@property(nonatomic,copy) NSString * id;
//@property(nonatomic,copy) NSString * communityname;
//@property(nonatomic,copy) NSString * companyid;
//@property(nonatomic,copy) NSString * officeName;
//@property(nonatomic,copy) NSString * sourceSystem;
//@property(nonatomic,copy) NSString * sourceSystemId;
//@property(nonatomic,copy) NSString * serverUrl;
//
//
//@end
//
@interface ZjFindUserCommunityListModel : IObjcJsonBase

/*
 id	主键	string	@mock=2f3b3633e1f64b17a85b0fe629cf516d
 createTime	创建时间	string	@mock=2016-10-21
 city	所属城市名称	string	@mock=北京市
 partitionl	自定义区域	string	@mock=20160107051515885
 communityname	小区名称	string	@mock=测试项目同步_小区
 officeId		string	@mock=
 area	占地面积	string	@mock=1000
 usearea	使用面积	string	@mock=1000
 securityunit	安保单位	string	@mock=
 greenarea	绿化面积	string	@mock=300
 floornum	栋数	string	@mock=
 constructionunit	建筑单位	string	@mock=
 cityid	所属城市id	string	@mock=3924
 partitionlid		string	@mock=
 companyid	物业公司id	string	@mock=7191344d5f6547b4833e785464540a62
 company		string	@mock=
 latitude	经度	number	@mock=39.973872
 longitude	纬度	number	@mock=116.319636
 phone		string	@mock=
 officeName	物业公司名称	string	@mock=测试项目同步_物业公司
 cityName		string	@mock=
 workingTime	服务时间	string	@mock=08:00~22:00
 mobile		string	@mock=
 propertyManagementArea	物管面积	string	@mock=1000
 checkinTime	入驻时间	number	@mock=1475251200000
 address	详细地址	string	@mock=北京市海淀区北三环西路47号-43号楼
 twoCode	二维码图片地址	string	@mock=communityCode/2f3b3633e1f64b17a85b0fe629cf516d\3e657e0304b64f97897e8f39ec3cd3aa.png
 groupPhone	集团客服	string	@mock=
 communityid		string	@mock=
 sourceSystem	源系统代码	string	@mock=zhongjia
 sourceSystemId	源系统小区id	string	@mock=34ed7472b43c4adaa6f2f10c162f411d
 serverUrl	物管云服
 */


@property(nonatomic,strong) NSString * id;
@property(nonatomic,strong) NSString * communityName;
@property(nonatomic,strong) NSString * communityid;
@property(nonatomic,strong) NSString * serverUrl;
@property(nonatomic,strong) NSString * sourceSystemId;




@end

@interface ZjFindUserCommunityListRespone : IObjcJsonBase

@property(nonatomic,copy) NSString * status;
@property(nonatomic,copy) NSString * message;
@property(nonatomic,strong) NSArray * data;

@end

@interface NetWork_ZJ_findUserCommunityList : WCServiceBase_Zjsh

@property(nonatomic,copy) NSString *token;

@end
