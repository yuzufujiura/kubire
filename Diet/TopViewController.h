//
//  TopViewController.h
//  Diet
//
//  Created by 藤浦ゆず on 2014/08/15.
//  Copyright (c) 2014年 藤浦ゆず. All rights reserved.
//

#import <UIKit/UIKit.h>

//@interface CameraOverlayView : UIImageView
//@property UIImagePickerController *pickerController;
//
//@end
@interface TopViewController : UIViewController<UIPageViewControllerDelegate> {
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo;

-(IBAction)takePhoto;
-(IBAction)setumei;
@end
