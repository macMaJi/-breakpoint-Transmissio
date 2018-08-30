#import "ViewController.h"
#import "NSString+Hash.h"
#import "MJDownLoadManager.h"


@interface ViewController ()
@property(nonatomic,assign)NSInteger requestCount;
@property(nonatomic,strong)NSTimer *timer;
@property (weak, nonatomic) IBOutlet UILabel *label;
@end

@implementation ViewController
/**
 * 开始下载
 */

- (IBAction)start:(id)sender {
    [self downLoad];
}

- (void)downLoad{
    if (_timer != nil) {
        [_timer invalidate];
        _timer = nil;
    }
    // 启动任务
    NSString * downLoadUrl =  @"http://118.145.5.141:4080/shell/gamePackages/iOS/%E5%A4%A7%E6%8E%8C%E9%97%A82.ipa";
//    __weak typeof(self) weakSelf = self;
    [[MJDownLoadManager sharedInstance] downLoadWithURL:downLoadUrl progress:^(float progress) {
        NSLog(@"已下载%f",progress);
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.label.text = [NSString stringWithFormat:@"%f",progress];
        });
    } success:^(NSString *fileStorePath) {
        NSLog(@"储存位置%@",fileStorePath);
        
    } faile:^(NSError *error) {
        _requestCount++;
        NSLog(@"下载失败%ld:%@",(long)_requestCount,error.userInfo[NSLocalizedDescriptionKey]);
        dispatch_async(dispatch_get_main_queue(), ^{
            _timer = [NSTimer timerWithTimeInterval:10.0f target:self selector:@selector(downLoad) userInfo:nil repeats:NO];
            [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
        });
        
    }];
}
//dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

//});

/**
 * 暂停下载
 */
- (IBAction)pause:(id)sender {
    [[MJDownLoadManager sharedInstance] stopTask];
}
/**
 * 删除已下载的文件、以及plist存值
 */
- (IBAction)delete:(UIButton *)sender {
    [[MJDownLoadManager sharedInstance] deleteTaskAndFile];
}

@end



