//
//  ViewController.m
//  Diet
//
//  Created by 藤浦ゆず on 2014/05/03.
//  Copyright (c) 2014年 藤浦ゆず. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "ALAssetsLibrary+PhotoLibraryUtility.h"

@implementation CameraOverlayView

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.pickerController takePicture];
}

@end

@interface ViewController()
{
    BOOL cameraFlag;
    AppDelegate *delegate;
    ALAssetsLibrary *library;
}
@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //非同期で保存している間にALAssetsLibraryのインスタンスは破棄したくない
    

    [imageview setContentMode:UIViewContentModeScaleAspectFit];
    
    
    imageview.image = self.image;
    imageview.contentMode = UIViewContentModeScaleAspectFit;
    
//    UIImageView* newImageView;
//    newImageView = [[UIImageView alloc] init];
//    newImageView.frame = self.view.bounds;
//    newImageView.contentMode = UIViewContentModeScaleAspectFit;
//    //newImageView.autoresizingMask =
//    //UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    [self.view addSubview:imageview];
    
    //[self takePhoto];
    //[self performSelector:@selector(takePhoto) withObject:nil afterDelay:0.4];
    
    delegate = [UIApplication sharedApplication].delegate;
    delegate.cameraFlag = NO;
    
    
   
}



/*-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (!delegate.cameraFlag) {
        [self takePhoto];//takePhotoを呼び出し
        
    }
    
}*/

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*-(IBAction)takePhoto{
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]){
        
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        
        picker.sourceType = sourceType;
        
        picker.delegate = self;
        
        UIImage *image = [UIImage imageNamed:@"wakutate2.gif"];
        
//        // じゅんろー試し書き
//        UIImage *image_after;
//        
//        CGFloat width = 320;
//        CGFloat height = 435 - 64;
//        
//        UIGraphicsBeginImageContext(CGSizeMake(width, height));
//        [image drawInRect:CGRectMake(0, 0, width, height)];
//        image_after = UIGraphicsGetImageFromCurrentImageContext();
//        
//        UIGraphicsEndImageContext();
//        // じゅんろーここまで
        
        //CameraOverlayView *overlayView = [[CameraOverlayView alloc] initWithImage:image];
        CameraOverlayView *overlayView = [[CameraOverlayView alloc] initWithImage:image];
       
        overlayView.pickerController = picker;
        //UIImageViewの生成
        
        overlayView.frame = CGRectMake(0, 64, 320, 435);//大きさと座標を決める
        overlayView.contentMode = UIViewContentModeScaleAspectFit;//AspectFill
        overlayView.backgroundColor = [UIColor clearColor];
        //overlayView.autoresizingMask =
        //UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        overlayView.alpha = 1.0;
        overlayView.userInteractionEnabled = NO;
        
        picker.cameraOverlayView = overlayView;
        
        
       
        
        delegate = [UIApplication sharedApplication].delegate;
        delegate.cameraFlag = YES;
        [self presentViewController:picker animated:YES completion:nil];
        
    }
}*/

-(IBAction)openLibrary{

    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]){
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        
        picker.sourceType = sourceType;
        
        picker.delegate = self;
        

        
        [self presentViewController:picker animated:YES completion:nil];
        
    }
   
}


-(void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    
    
    
    [[picker presentingViewController] dismissViewControllerAnimated:YES completion:nil];
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        // カメラ
        imageview.alpha = 0.6;
        [imageview setImage:image];
        
        
        
   UIImageWriteToSavedPhotosAlbum(
                                       image,
                                       self,
                                       @selector(targetImage:didFinishSavingWithError:contextInfo:),
                                       NULL);//←←アルバム保存
        library = [[ALAssetsLibrary alloc] init];
        [library saveImageToPhotoLibrary:image groupName:@"KUBIRE美人" completion:^(NSError *error) {
            if (error) {
                NSLog(@"失敗 : %@", error);
            }else {
                 NSLog(@"成功");
            }
        }];
        
        
    }else{
        // ライブラリ
        imageview2.contentMode = UIViewContentModeScaleAspectFit;
        imageview2.alpha = 0.3;
        
        
        [imageview2 setImage:image];
    //by濃さ
        
    }
}



/*-(void)targetImage:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)context{
    
    
    if(error){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"保存できませんでした"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"保存を完了しました"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}*/

-(void)imagePickerContrrollerDidCancel:(UIImagePickerController *)picker {
    UIViewController *vc = [picker presentingViewController];
    [vc dismissViewControllerAnimated:YES completion:nil];
    
}

-(IBAction)postToFacebook{
    
    NSString *serviceType = SLServiceTypeFacebook;
    
    if ([SLComposeViewController isAvailableForServiceType:serviceType]) {
        SLComposeViewController *facebookPostVC = [[SLComposeViewController alloc] init];
        
        facebookPostVC = [SLComposeViewController composeViewControllerForServiceType:serviceType];
        
        [facebookPostVC setInitialText:@"#KUBIRE美人"];
        
        //[facebookPostVC addImage:imageview.image];
        
        [facebookPostVC setCompletionHandler:^(SLComposeViewControllerResult result){
            if (result == SLComposeViewControllerResultDone) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@""
                                                               message:@"投稿を完了しました"
                                      　　　　　　　　　　　　　　 delegate:nil
                                                     cancelButtonTitle:@"OK"
                                                     otherButtonTitles:nil];
                                      [alert show];
                                      }else{
                                     
                                          UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                                                          message:@"投稿できませんでした"
                                                                　　　　　　　　　　　　　　delegate:nil
                                                                                cancelButtonTitle:@"OK"
                                                                                otherButtonTitles:nil];

                                                                [alert show];
                               
    　　　　　　　　}
　　　　　}];
                
        [self presentViewController:facebookPostVC animated:YES completion:nil];
    }else {
        
    }
}



-(IBAction)postTotwitter{
    
    NSString *serviceType = SLServiceTypeTwitter;
    
    if ([SLComposeViewController isAvailableForServiceType:serviceType]) {
        SLComposeViewController *twitterPostVC = [[SLComposeViewController alloc] init];
        
        twitterPostVC = [SLComposeViewController composeViewControllerForServiceType:serviceType];
        
        [twitterPostVC setInitialText:@"#KUBIRE美人"];
        
        //[facebookPostVC addImage:imageview.image];
        
        [twitterPostVC setCompletionHandler:^(SLComposeViewControllerResult result){
            if (result == SLComposeViewControllerResultDone) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@""
                                                               message:@"投稿を完了しました"
                                      　　　　　　　　　　　　　　 delegate:nil
                                                     cancelButtonTitle:@"OK"
                                                     otherButtonTitles:nil];
                [alert show];
            }else{
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                                message:@"投稿できませんでした"
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                
                [alert show];
            }}];
        
        [self presentViewController:twitterPostVC animated:YES completion:nil];
    }else {
        
    }
}



@end
