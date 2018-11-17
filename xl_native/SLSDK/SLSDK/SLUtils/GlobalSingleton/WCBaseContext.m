#import "WCPlistHelper.h"
#import "ASIConnectionProvider.h"
//#import "MKConnectionProvider.h"
//#import "AFConnectionProvider.h"

#import "WCBaseContext.h"
#import "WCBaseConfiguration.h"

#define ARC4RANDOM_MAX      0x100000000

static WCBaseContext *sharedInstance;
static BOOL _hasSetup;

@implementation WCBaseContext
{
    id <WCNetworkOperationProvider> _connectionProvider;
    NSString *_cacheRootPath;
    NSString *_dataBasePath;
}

+ (void)initialize{
    _hasSetup = NO;
    sharedInstance = [[WCBaseContext alloc] init];
}

+ (WCBaseContext *)sharedInstance{
    return sharedInstance;
}



- (void)setupCore
{
    [self checkCacheFolder:[self cacheRootFolder]];
    [self checkCacheFolder:[self resourceFolder]];
    [self checkCacheFolder:[self multimediaFolder]];
    [self checkCacheFolder:[self webPageFolder]];
    [self checkCacheFolder:[self downloadFolder]];
    //[self checkCacheFolder:[self logFolder]];
}

- (NSString *)databasePath{
    return _dataBasePath;
}

-(void)setDeviceToken:(NSString *)deviceToken{
    [[NSUserDefaults standardUserDefaults] setObject:deviceToken forKey:JR_APP_DEVICETOKEN];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSString *)getDeviceToken{
    return [[NSUserDefaults standardUserDefaults] objectForKey:JR_APP_DEVICETOKEN];
}

-(NSString *)getAppInterfaceServer{
    
    NSString *groupName = [WCBaseContext sharedInstance].configuration.group_name;
    groupName = groupName.trim;
    
    /*
     * adressType 为 1.是测试环境。 2.为生产环境。
     */
    
    NSString *appServerAdress = @"";
    
    if ([[WCBaseContext sharedInstance].configuration.adressType isEqualToString:@"1"]){
        appServerAdress = @"http://192.168.180.130:8081";
    }
    else if ([[WCBaseContext sharedInstance].configuration.adressType isEqualToString:@"2"]){
        appServerAdress = @"https://csp.zmsq.net";
    }
    else {
        appServerAdress = @"https://csp.zmsq.net";
    }
    return appServerAdress;
}

-(NSString *)getH5Server{
    /*
     * adressType 为 1.是测试环境。 2.为生产环境。3.为UAT环境
     */
    
    NSString *h5BaseAdress = @"";
    
    // adressType 接口地址类型 1.测试环境 2.生产环境
    if([[WCBaseContext sharedInstance].configuration.adressType isEqualToString:@"1"]){
        h5BaseAdress = @"http://221.122.75.84:443";
    }
    else if ([[WCBaseContext sharedInstance].configuration.adressType isEqualToString:@"2"]){
        h5BaseAdress = @"https://hshop.zmsq.net";
    }    else {
        h5BaseAdress = @"https://hshop.zmsq.net";
    }
    return h5BaseAdress;
}

-(NSString *)getGameServer{
    /*
     * adressType 为 1.是测试环境。 2.为生产环境。3.为UAT环境
     */
    
    NSString *h5BaseAdress = @"";
    
    // adressType 接口地址类型 1.测试环境 2.生产环境
    if([[WCBaseContext sharedInstance].configuration.adressType isEqualToString:@"1"]){
        h5BaseAdress = @"http://221.122.75.84:443";
    }
    else if ([[WCBaseContext sharedInstance].configuration.adressType isEqualToString:@"2"]){
        h5BaseAdress = @"https://hshop.zmsq.net";
    }    else {
        h5BaseAdress = @"https://hshop.zmsq.net";
    }
    return h5BaseAdress;
}


-(NSString *)getSinaAppKey{
    return @"2367230463";
}

-(NSString *)getSinaCallBackURl{
    return @"https://hshop.zmsq.net";
}

-(NSString *)getWxAppKey{
    return @"wx2dc4df89ef659f03";
}

-(NSString *)getSinaWgAppKey{
    return @"1171656667";
}

-(NSString *)getSinaWgCallBackURl{
    return @"https://hshop.zmsq.net";
}

-(NSString *)getWxWgAppKey{
    return @"wxa0b3e9320f7d9f54";
}


+ (double)randomDoubleStart:(double)a end:(double)b
{
    double random = ((double) arc4random()) / (double) ARC4RANDOM_MAX;
    double diff = b - a;
    double r = random * diff;
    return a + r;
}

/*
 @property (strong, nonatomic,getter=getLatitude,setter=setLatitude:) NSString *latitude;   //当前用户经度
 @property (strong, nonatomic,getter=getLongitude,setter=setLongitude:) NSString *longitude; //当前用户纬度
 */

-(void)setLatitude:(NSString*)latitude{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:latitude forKey:JR_APP_USER_APP_USER_LATITUDE];
    [prefs synchronize];
}

-(NSString*)getLatitude{
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *latitude = [prefs objectForKey:JR_APP_USER_APP_USER_LATITUDE];
    //        NSString *latitude =@"39.980507";
    
    if(latitude){
        //        latitude = @"39.980507";
    }
    
    return latitude;
}

-(void)setLongitude:(NSString*)longitude{
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:longitude forKey:JR_APP_USER_APP_USER_LONGITUDE];
    [prefs synchronize];
}

-(NSString*)getLongitude{
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *longitude = [prefs objectForKey:JR_APP_USER_APP_USER_LONGITUDE];
    //    NSString *longitude =@"116.353556";
    
    if(longitude){
        //        longitude = @"116.353556";
    }
    
    return longitude;
}


/*
 *中民居家Token，project_id和Url， user_phone
 */

-(void)setSourceUrl:(NSString*)sourceUrl{
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:sourceUrl forKey:ZJ_APP_USER_APP_SOURCE_URL];
    [prefs synchronize];
    
    NSString *sourceUrlTemp = [prefs objectForKey:ZJ_APP_USER_APP_SOURCE_URL];
    
    NSLog(@"----------%@",sourceUrlTemp);
    
}

-(NSString*)getSourceUrl{
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *sourceUrl = [prefs objectForKey:ZJ_APP_USER_APP_SOURCE_URL];
    
    return sourceUrl;
}

-(void)setSourceToken:(NSString*)sourceToken{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:sourceToken forKey:ZJ_APP_USER_APP_SOURCE_TOKEN];
    [prefs synchronize];
}

-(NSString*)getSourceToken{
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *sourceToken = [prefs objectForKey:ZJ_APP_USER_APP_SOURCE_TOKEN];
    
    return sourceToken;
}

-(void)setProject_id:(NSString*)project_id{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:project_id forKey:ZJ_APP_USER_APP_PROJECT_ID];
    [prefs synchronize];
}

-(NSString*)getProject_id{
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *project_id = [prefs objectForKey:ZJ_APP_USER_APP_PROJECT_ID];
    
    return project_id;
}

-(void)setProject_id_owner:(NSString *)project_id_owner{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:project_id_owner forKey:ZJ_APP_USER_APP_PROJECT_ID_OWNER];
    [prefs synchronize];
}

-(NSString*)getProject_id_owmer{
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *project_id_owner = [prefs objectForKey:ZJ_APP_USER_APP_PROJECT_ID_OWNER];
    
    return project_id_owner;
}

-(void)setUser_phone:(NSString*)user_phone{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:user_phone forKey:ZJ_APP_USER_APP_USER_PHONE];
    [prefs synchronize];
}

-(NSString*)getUser_phone{
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *user_phone = [prefs objectForKey:ZJ_APP_USER_APP_USER_PHONE];
    
    return user_phone;
}








- (WCPlistHelper *)plistHelper{
    if (!_plistHelper){
        _plistHelper = [[WCPlistHelper alloc] initWithPlistNamed:@"onbConfiguration"];
    }
    return _plistHelper;
}

- (WCBaseConfiguration *)configuration{
    if (_configuration == nil){
        _configuration = [[WCBaseConfiguration alloc] initWithDictionary:self.plistHelper.allProperties];
    }
    return _configuration;
}

-(void)saveConfiguration{
    [self.plistHelper saveplistWithPath:[_configuration generateJsonDict]];
}

- (id <WCNetworkOperationProvider>)connectionProvider{
    return _connectionProvider;
}

- (id <WCNetworkOperationProvider>)loadDefaultConnectionProvider{
    return [[ASIConnectionProvider alloc] init];
}

- (void)startup{
    [self startupWithConnectionProviderType:EASINetworkProvider andCacheRootPath:nil andConfiguration:nil];
}

- (void)startupWithConfiguration:(WCBaseConfiguration *)configuration andDatabaseStorePath:(NSString *)dataBasePath{
    [self startupWithConnectionProvider:nil andCacheRootPath:nil andConfiguration:nil andDatabaseStorePath:dataBasePath];
}

- (void)startupWithConfiguration:(WCBaseConfiguration *)configuration{
    [self startupWithConnectionProviderType:EASINetworkProvider andCacheRootPath:nil andConfiguration:configuration];
}

- (void)startupWithConnectionProvider:(id <WCNetworkOperationProvider>)provider andConfiguration:(WCBaseConfiguration *)configuration{
    [self startupWithConnectionProvider:provider andCacheRootPath:nil andConfiguration:configuration andDatabaseStorePath:nil];
}

- (void)startupWithCacheRootPath:(NSString *)cacheRootPath andConfiguration:(WCBaseConfiguration *)configuration{
    [self startupWithConnectionProviderType:EASINetworkProvider andCacheRootPath:cacheRootPath andConfiguration:configuration];
}

- (void)startupWithConnectionProviderType:(ENetworkProviderType)providerType andCacheRootPath:(NSString *)cacheRootPath
                         andConfiguration:(WCBaseConfiguration *)configuration{
    switch (providerType)
    {
        case EASINetworkProvider:
            [self startupWithConnectionProvider:[[ASIConnectionProvider alloc]init] andCacheRootPath:cacheRootPath andConfiguration:configuration andDatabaseStorePath:nil];
            break;
            //        case EMKNetworkProvider:
            //            [self startupWithConnectionProvider:[[MKConnectionProvider alloc]init] andCacheRootPath:cacheRootPath andConfiguration:configuration andDatabaseStorePath:nil];
            //            break;
            //        case EAFNetworkProvider:
            //            [self startupWithConnectionProvider:[[AFConnectionProvider alloc]init] andCacheRootPath:cacheRootPath andConfiguration:configuration andDatabaseStorePath:nil];
            //            break;
        default:
            break;
    }
}

- (void)startupWithConnectionProvider:(id <WCNetworkOperationProvider>)provider andCacheRootPath:(NSString *)cacheRootPath
                     andConfiguration:(WCBaseConfiguration *)configuration andDatabaseStorePath:(NSString *)dataBasePath{
    if (_hasSetup == YES)
        return;
    
    _hasSetup = YES;
    
    
    if ([[cacheRootPath stringWithTrimWhiteSpcace] length])
        _cacheRootPath = cacheRootPath;
    else
        _cacheRootPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    
    
    _cacheRootPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    
    _dataBasePath = dataBasePath;
    if (_dataBasePath == nil)
    {
        NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentPath = [searchPaths lastObject];
        _dataBasePath= [documentPath stringByAppendingPathComponent:@"WCS.sqlite"];
    }
    
    [self setupCore];
    
    if (configuration){
        _configuration = configuration;
    }
    
    if (!_connectionProvider){
        _connectionProvider = provider;
    }
    if (!_connectionProvider){
        _connectionProvider = [self loadDefaultConnectionProvider];
    }
}

- (NSString *)cacheRootFolder{
    return [_cacheRootPath stringByAppendingPathComponent:CACHE_ROOT_FOLDER];
}

- (NSString *)resourceFolder{
    return [[self cacheRootFolder] stringByAppendingPathComponent:CACHE_RESOURCE_FOLDER];
}

- (NSString *)multimediaFolder{
    return [[self cacheRootFolder] stringByAppendingPathComponent:CACHE_MULTIMEDIA_FOLDER];
}

- (NSString *)webPageFolder{
    return [[self multimediaFolder] stringByAppendingPathComponent:CACHE_MULTIMEDIA_WEBPAGE_FOLDER];
}

- (NSString *)downloadFolder{
    return [[self cacheRootFolder] stringByAppendingPathComponent:CACHE_DOWNLOAD_TMP_FOLDER];
}


- (void)checkCacheFolder:(NSString *)folderPath{
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:folderPath isDirectory:&isDir];
    if (!(isDir && existed))
    {
        [fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

@end
