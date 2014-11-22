//
//  TopViewController.m
//  Diet
//
//  Created by 藤浦ゆず on 2014/08/15.
//  Copyright (c) 2014年 藤浦ゆず. All rights reserved.
//

#import "TopViewController.h"
#import "AppDelegate.h"
#import "ALAssetsLibrary+PhotoLibraryUtility.h"
#import "ViewController.h"

@interface TopViewController (){
    BOOL cameraFlag;
    AppDelegate *delegate;
    ALAssetsLibrary *library;

}

@end

@implementation TopViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(IBAction)takePhoto{//←ViewControllerのみで
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
        
        //撮影画面をモーダルビューとして表示する
        [self presentViewController:picker animated:YES completion:nil];
        
        //[self presentViewController:ViewController animated:YES completion:nil];
        
        NSLog(@"通ったよ！");

    }
    
    NSLog(@"22222通ったよ！");
    
}





/// 撮影した画像を選択後に呼ばれる
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo
{
    
    NSLog(@"撮影後ごごごごごごごごご");
//    [self performSegueWithIdentifier:@"hikaku" sender:nil];

//    self.navigationController.modalPresentationStyle = UIModalPresentationCurrentContext;
    
    
    // モーダルで表示
    //UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    // Storyboard ID を指定して画面遷
    
    library = [[ALAssetsLibrary alloc] init];
    [library saveImageToPhotoLibrary:image groupName:@"KUBIRE美人" completion:^(NSError *error) {
        if (error) {
            NSLog(@"失敗 : %@", error);
        }else {
            NSLog(@"成功");
        }
    }];//画像保存

    

    ViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    controller.image = image;
    // 画面遷移のアニメーションを設定
//    controller.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    // UINavigationControllerに向けてモーダルで画面遷移
    [picker  presentViewController:controller animated:NO completion:nil];
//    [self.navigationController pushViewController:controller animated:YES];
    
//    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)targetImage:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)context{
    
    
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
}



//画像保存完了時のセレクタ
- (void)onCompleteCapture:(UIImage *)screenImage
 didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSString *message = @"画像を保存しました";
    if (error) message = @"画像の保存に失敗しました";
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @""
                                                    message: message
                                                   delegate: nil
                                          cancelButtonTitle: @"OK"
                                          otherButtonTitles: nil];
    [alert show];
}




//撮影後にイメージを表示
//- (void)imagePickerController:(UIImagePickerController *)picker disFinishPickingMediaWithInfo:(NSDictionary *)info
//{
//    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
//    [self dismissViewControllerAnimated:YES completion:^{
//      //  self.imageView.image =image;
//        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
//    }];
//    
//    NSLog(@"撮影後");
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
