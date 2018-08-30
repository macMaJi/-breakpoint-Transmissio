//
//  MJDownLoadManager.h
//  test1
//
//  Created by Bean on 2018/8/16.
//  Copyright © 2018年 Mia. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^successBlock) (NSString *fileStorePath);
typedef void (^faileBlock) (NSError *error);
typedef void (^progressBlock) (float progress);

@interface MJDownLoadManager : NSObject <NSURLSessionDataDelegate>


@property (copy) successBlock  successBlock;
@property (copy) faileBlock      failedBlock;
@property (copy) progressBlock    progressBlock;


-(void)downLoadWithURL:(NSString *)URL
              progress:(progressBlock)progressBlock
               success:(successBlock)successBlock
                 faile:(faileBlock)faileBlock;

+ (instancetype)sharedInstance;

-(void)stopTask;

-(BOOL)deleteTaskAndFile;
@end
