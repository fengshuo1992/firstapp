//
//  ViewController.m
//  初步学习GCD
//
//  Created by 冯硕 on 2017/6/15.
//  Copyright © 2017年 冯硕. All rights reserved.
//

#import "ViewController.h"
#import "NetworkHelper.h"




@interface ViewController ()
@property (nonatomic, strong)dispatch_source_t time;

@property (nonatomic, strong) UIImage * iamge;
@property (nonatomic, strong) UIImage * iamge1;
@property (nonatomic, strong) UIImageView * iamgeView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
  
    
    dispatch_async_f(dispatch_get_global_queue(0, 0), NULL, task);
    
    self.iamgeView  = [[UIImageView alloc] init];
    
    self.iamgeView.frame = CGRectMake(0, 100, 500, 500);
    
//    imageView.backgroundColor = [UIColor yellowColor];
//    imageView.clipsToBounds = NO;
//    imageView.layer.shadowColor = [UIColor redColor].CGColor;
//    imageView.layer.shadowOpacity = 0.6;
//    imageView.layer.shadowOffset = CGSizeMake(5, 13);
//    imageView.layer.shadowRadius = 5;
    [self.view addSubview:self.iamgeView];
    [self GCDGroup];
//    [self GCDOthre];
    
}

void task(void * param)
{

    NSLog(@"%@", [NSThread currentThread]);
}

- (void)GCDOnce{
    
    NetworkHelper * helper = [NetworkHelper mianHelper];
}


- (void)grouopS
{
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    dispatch_group_async(group, queue, ^{
        NSURL * url = [NSURL URLWithString:@"http://o82rnrl9s.bkt.clouddn.com/c808a22b-3519-4790-9b71-a2759d3c4e8c.jpg"];
        NSData * date  = [NSData dataWithContentsOfURL:url];
        self.iamge = [UIImage imageWithData:date];
    });
    
    dispatch_group_async(group, queue, ^{
        NSURL * url = [NSURL URLWithString:@"http://o82rnrl9s.bkt.clouddn.com/ea63df8e-6864-47e0-b3c2-d8638be60a9c.jpg"];
        NSData * date = [NSData dataWithContentsOfURL:url];
        self.iamge1 = [UIImage imageWithData:date];
    });
    
    dispatch_group_notify(group, queue, ^{
        UIGraphicsBeginImageContext(CGSizeMake(500, 500));
       [self.iamge drawInRect:CGRectMake(0, 0, 500, 250)];
        self.iamge = nil;
        [self.iamge1 drawInRect:CGRectMake(0, 250, 500, 250)];
        self.iamge1 = nil;
         UIImage * iamges = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        dispatch_async(dispatch_get_main_queue(), ^{
             self.iamgeView.image = iamges;
        });
       
        
        
    });
    



}

//gcd的栅栏操作
- (void)gcdZhalan
{
    
    //如果队列是串行的话 则每个任务完成的顺序是一致的 一个一个的完成 如果是并发的话 则异步完成
    dispatch_queue_t queue = dispatch_queue_create("", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_sync(queue, ^{
       
        NSLog(@"这是同步的第一个 %@**********",  [NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        NSLog(@"这是同步的第二个 %@**********",  [NSThread currentThread]);
    });
    
   dispatch_barrier_async(queue, ^{
       NSLog(@"这是异步的阻碍 %@**********",  [NSThread currentThread]);
   });
    
    dispatch_sync(queue, ^{
        NSLog(@"这是同步的第三个 %@**********",  [NSThread currentThread]);
    });
    
    
    
    dispatch_sync(queue, ^{
        NSLog(@"这是同步的第四个 %@**********",  [NSThread currentThread]);
    });
    
    
    
    dispatch_async(queue, ^{
        sleep(3);
        NSLog(@"这是第一个 %@**********",  [NSThread currentThread]);
    });

    dispatch_async(queue, ^{
        NSLog(@"这是第二个 %@**********",  [NSThread currentThread]);
    });
    
    dispatch_barrier_async(queue, ^{
        NSLog(@"这是中间的栅栏 %@**********",  [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"这是第三个 %@**********",  [NSThread currentThread]);
    });
    
    
    dispatch_async(queue, ^{
        NSLog(@"这是第四个 %@**********",  [NSThread currentThread]);
    });

}


- (void)otherGCD
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(9 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"这个地方会在九秒之后执行");
    });
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"这个地方只会执行一次的");
    });

}


- (void)GCDGroup
{
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
    
         NSLog(@"这是队列组里面的第一个");
       
        
    });
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
         dispatch_group_wait(group, 1000);
        
        NSLog(@"这是队列组里面的第3个");

        
    });
    
    dispatch_async(dispatch_get_main_queue(), ^{
        dispatch_group_wait(group, 1000);
          NSLog(@"回到主线程刷新数据0");
    });
    
//    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
//        
//        NSLog(@"这是队列组里面的第一个");
//    });
//    
//    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
//        NSLog(@"这是队列组里面的第二个");
//    });
//    
//    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
//        NSLog(@"回到主线程刷新数据0");
//    });

}

#pragma mark - 多图上传

- (void)GCDDuotushagnchuan
{
    
    dispatch_group_t group = dispatch_group_create();
    
    for (int i = 0 ; i < 100; i++) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
         dispatch_group_enter(group);
            NSLog(@"%d", i);
           dispatch_group_leave(group);
        });
    }

    
    
 
    for (int i = 0 ; i < 50; i++) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
                dispatch_group_enter(group);
            NSLog(@"%d", i);
            dispatch_group_leave(group);
        });
    }
    
  //  这个不是主线程的
dispatch_async(dispatch_get_global_queue(0, 0), ^{
    dispatch_group_wait(group, dispatch_time(DISPATCH_TIME_NOW, 1000));
  
    NSLog(@"所有的东西都完成了%@",  [NSThread currentThread]);
});
    
       //这个是在主线程完成的
//    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
//        NSLog(@"所有的都进行完了%@",  [NSThread currentThread]);
//    });
//    
    //信号量进行多图上传
//    dispatch_semaphore是GCD用来同步的一种方式，与他相关的共有三个函数，分别是
//    
//    dispatch_semaphore_create，dispatch_semaphore_signal剩余车位就增加一个，dispatch_semaphore_wait 剩余车位就减少一个
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_semaphore_t sempert = dispatch_semaphore_create(1);
    for (int i = 0; i < 9; i++) {
        dispatch_async(queue, ^{
//            dispatch_semaphore_wait(sempert, DISPATCH_TIME_FOREVER);
//            NSLog(@"%d", i);
//            dispatch_semaphore_signal(sempert);
    
        });
    }
}

#pragma mark - 线程复用

- (void)GCDXinchegnfuyong
{
    
    
    dispatch_queue_t firstQueue = dispatch_queue_create("first.com", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t secondQueue = dispatch_queue_create("second.com", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t thirdQueue = dispatch_queue_create("third.com", DISPATCH_QUEUE_SERIAL);
    
    dispatch_queue_t target = dispatch_queue_create("target.com", DISPATCH_QUEUE_SERIAL);
    dispatch_set_target_queue(firstQueue, target);
    dispatch_set_target_queue(secondQueue, target);
     dispatch_set_target_queue(thirdQueue, target);
    dispatch_async(firstQueue, ^{
        for (NSInteger i = 0; i < 5; i++) {
            sleep(0.5);
            NSLog(@" 运行在 firstQueue 中 %ld thread:%@",i,[NSThread currentThread]);
        }
    });
    
    
    dispatch_async(secondQueue, ^{
        for (NSInteger i = 0; i < 5; i++) {
            sleep(0.5);
            NSLog(@" 运行在 firstQueue 中 %ld thread:%@",i,[NSThread currentThread]);
        }
    });
    
    
    
    dispatch_async(thirdQueue, ^{
        for (NSInteger i = 0; i < 5; i++) {
            sleep(0.5);
            NSLog(@" 运行在 firstQueue 中 %ld thread:%@",i,[NSThread currentThread]);
        }
    });
    //打印的结果是都是一个线程

}

- (void)GCDOthre
{
    
//    dispatch_queue_t mainqueue = dispatch_get_main_queue();
//    dispatch_source_t time = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, mainqueue);
//    dispatch_time_t inveral = dispatch_time(DISPATCH_TIME_NOW, 0 *NSEC_PER_SEC);
//    uint64_t interval = 2 * NSEC_PER_SEC;
//    dispatch_source_set_timer(time, inveral, interval, 0);
//    dispatch_source_set_event_handler(time, ^{
//        NSLog(@"这个是没两秒重复一次");
//    });
//
//    dispatch_resume(time);

    


    
    
    
    
    self.time = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
   __block int  timeout = 10;
    dispatch_source_set_timer(self.time, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(self.time, ^{
        if (timeout == 0) {
            dispatch_source_cancel(_time);
        }
        NSLog(@"%d", timeout);
        timeout--;
        
        NSLog(@"ahahahhahahh");
    });
    dispatch_resume(self.time);
    
    //比如我们要task1 task2 task3 都运行完成后才能异步运行task4 task5 task6我们该怎么做呢？这里我们可以引入group的概念
    /*
    dispatch_group_t group = dispatch_group_create();

    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_group_async(group, queue, ^{
        NSLog(@"这个是任务一");
    });
    
    dispatch_group_async(group, queue, ^{
       NSLog(@"这个是任务2");
    });
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"这个是任务3");
    });
    
    
    dispatch_barrier_async(queue, ^{
        NSLog(@"你猜能不能实现");
    });
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"这个是任务4");
    });
    
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"这个是任务5");
    });
    
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"这个是任务6");
    });
     */

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
