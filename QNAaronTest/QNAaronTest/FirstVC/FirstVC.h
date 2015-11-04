//
//  FirstVC.h
//  QNAaronTest
//
//  Created by   何舒 on 15/10/13.
//  Copyright © 2015年   何舒. All rights reserved.
//

#import "BaseVC.h"

@interface FirstVC : BaseVC <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *fistTableView;

@end
