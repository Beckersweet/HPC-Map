//
//  RootViewController.m
//  HPCmap
//
//  Created by Barbara Collignon on 8/27/11.
//  Copyright 2012 Beckersweet Technology Inc. All rights reserved.

#define sectionCount 2
#define sect1Section 0
#define sect2Section 1
#define sect3Section 2

#import "RootViewController.h"
#import "DetailViewController.h"
#import "pue.h"
#import "gpue.h"
#import "ppw.h"
#import "energysavings.h"
#import "costreduction.h"
#import "impact.h"

@implementation RootViewController

-(void) createGloveData {
      
    gloveSections=[[NSMutableArray alloc] initWithObjects:@"Computing Power Consumption",@"Local vs Cloud Computing",nil];

    
    sect1Gloves=[[NSMutableArray alloc] init];
    sect2Gloves=[[NSMutableArray alloc] init];
  //sect3Gloves=[[NSMutableArray alloc] init];
    
    [sect1Gloves addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Power Usage Effectiveness",@"name",@"",@"picture",@"http://pimpgloves.com/products/bike-gloves",@"url",nil]] ;
   // [sect1Gloves release];
    [sect1Gloves addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Green PUE",@"name",@"",@"picture",@"http://pimpgloves.com/products/bike-gloves",@"url",nil]];
    [sect1Gloves addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Performance per Watt",@"name",@"",@"picture",@"http://pimpgloves.com/products/bike-gloves",@"url",nil]];
    [sect2Gloves addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Energy Savings",@"name",@"",@"picture",@"http://pimpgloves.com/products/bike-gloves",@"url",nil]];

    [sect2Gloves addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Cost Reduction",@"name",@"",@"picture",@"http://pimpgloves.com/products/bike-gloves",@"url",nil]];
    [sect2Gloves addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Environmental Impact",@"name",@"",@"picture",@"http://pimpgloves.com/products/bike-gloves",@"url",nil]];
    /*
    [sect3Gloves addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Islands",@"name",@"velvet2.jpg",@"picture",@"http://pimpgloves.com/products/bike-gloves",@"url",nil]];
    
    [sect3Gloves addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Artics",@"name",@"velvet1.jpg",@"picture",@"http://pimpgloves.com/products/bike-gloves",@"url",nil]];
    [sect3Gloves addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Groenland",@"name",@"velvet2.jpg",@"picture",@"http://pimpgloves.com/products/bike-gloves",@"url",nil]];

    */
    
    gloveData=[[NSMutableArray alloc] initWithObjects:sect1Gloves,sect2Gloves,nil];
    
    [sect1Gloves release];
    [sect2Gloves release];
 // [sect3Gloves release];
    
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return [gloveSections objectAtIndex:section];

}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section 
{
    UIView *headerView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)] autorelease];
    if (section == 0){
        UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(15, 5, tableView.bounds.size.width - 10, 18)] autorelease];
        label.text = @"Computing Power Consumption";
        label.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
        label.textColor = [UIColor blackColor];
        label.backgroundColor = [UIColor clearColor];
        [headerView addSubview:label];
    }else {
        UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(15, 5, tableView.bounds.size.width - 10, 18)] autorelease];
        label.text = @"Local vs Virtualization";
        label.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
        label.textColor = [UIColor blackColor];
        label.backgroundColor = [UIColor clearColor];
        [headerView addSubview:label];
    }
    
    return headerView;
}


- (void)viewDidLoad
{
  //  self.tableView.style=UITableViewStyleGrouped;
    
    [self.tableView initWithFrame:CGRectZero style:UITableViewStyleGrouped];
 
    self.navigationItem.title=@"Green Indices";
    UILabel * label = [[[UILabel alloc] initWithFrame:CGRectMake(0,0,45,45)] autorelease];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor]; 
    label.text = self.navigationItem.title;
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size: 22.0];
    self.navigationItem.titleView = label;
    [label sizeToFit];

    [self createGloveData];
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  //  return 1;
    return sectionCount;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   // return 0;
    return [[gloveData objectAtIndex:section] count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
   if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }

    // Configure the cell.
    switch (indexPath.section) {
      case sect1Section:
   
    [[cell textLabel] setText:[[[gloveData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"name"]];
    [[cell imageView] setImage:[UIImage imageNamed:[[[gloveData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"picture"]]]; 
    break;
    
      case sect2Section:
     
        [[cell textLabel] setText:[[[gloveData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"name"]];
        [[cell imageView] setImage:[UIImage imageNamed:[[[gloveData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"picture"]]]; 
       break;
            
      case sect3Section:
    
        [[cell textLabel] setText:[[[gloveData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"name"]];
        [[cell imageView] setImage:[UIImage imageNamed:[[[gloveData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"picture"]]]; 
        break;

    
     default:
       [[cell textLabel]setText:@"unknown"] ;
       break;
    }

    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
   return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
    // ...
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
	*/
    
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        
       pue *gloveDetail = [[[pue alloc] initWithNibName:@"pue" bundle:nil]autorelease];
       
        [self.navigationController pushViewController:gloveDetail animated:YES];
   // [pue release];
    
        
    } else if (indexPath.section == 0 & indexPath.row == 1) {    
         
        gpue *gloveDetail = [[[gpue alloc] initWithNibName:@"gpue" bundle:nil] autorelease];
        [self.navigationController pushViewController:gloveDetail animated:YES];
      //  [gpue release];
        
        
    } else if (indexPath.section == 0 & indexPath.row == 2) {    
        
        ppw *gloveDetail = [[[ppw alloc] initWithNibName:@"ppw" bundle:nil] autorelease];
        [self.navigationController pushViewController:gloveDetail animated:YES];
      
        
    } else if (indexPath.section == 1 && indexPath.row == 0) {
            
            energysavings *gloveDetail = [[[energysavings alloc] initWithNibName:@"energysavings" bundle:nil] autorelease];
           
            [self.navigationController pushViewController:gloveDetail animated:YES];
                     
        } else if (indexPath.section == 1 & indexPath.row == 1) {    
            
            costreduction *gloveDetail = [[[costreduction alloc] initWithNibName:@"costreduction" bundle:nil]autorelease];
            [self.navigationController pushViewController:gloveDetail animated:YES];
                    
        } else if (indexPath.section == 1 & indexPath.row == 2) {    
            
            impact *gloveDetail = [[[impact alloc] initWithNibName:@"impact" bundle:nil]autorelease];
            [self.navigationController pushViewController:gloveDetail animated:YES];
       
        
    } else {
    
     DetailViewController *gloveDetail = [[[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil] autorelease];
     gloveDetail.detailURL=[[[NSURL alloc] initWithString:[[[gloveData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"url"]]autorelease];
     gloveDetail.title=[[[gloveData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"name"];
     [self.navigationController pushViewController:gloveDetail animated:YES];
    // [DetailViewController release];
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)dealloc
{
    [gloveData release];
    [super dealloc];
}

@end
