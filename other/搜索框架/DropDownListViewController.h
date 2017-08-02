//
//  DropDownListViewController.h
//  DropDownList
//
//  Created by kingyee on 11-9-19.
//  Copyright 2011 Kingyee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDList.h"
#import "PassValueDelegate.h"
#import "TPLChooseItemsView.h"
#import "ParentsViewController.h"
@interface DropDownListViewController : ParentsViewController <UISearchBarDelegate, PassValueDelegate,UITableViewDataSource,UITableViewDelegate>{
	IBOutlet UISearchBar *_searchBar;
	IBOutlet UITableView *_tableView;
 
	DDList				 *_ddList;
	NSMutableArray		 *_resultArray;
	NSString			 *_searchStr;
    TPLChooseItemsView   *_chooseItemsView;
    UIView               *partview;
    NSMutableArray              *Hotarray;
}
@property (nonatomic,retain)UITableView *tableView;
@property(nonatomic,retain)NSMutableArray  *historySearchStrArr;
@property (nonatomic, copy)NSString *_searchStr;

- (void)setDDListHidden:(BOOL)hidden;

@end

