//
//  ViewController.m
//  HPCmap
//
//  Created by Barbara Collignon on 1/12/12.
//  Copyright 2012 Beckersweet Technology Inc. All rights reserved.
//

#import "QuizzViewController.h"

@implementation QuizzViewController

@synthesize Question,AnswerA,AnswerB,AnswerC,AnswerD;
@synthesize buttonA,buttonB,buttonC,buttonD;
@synthesize xofy,score,result;
@synthesize next,startover,ask;
@synthesize toolbar;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    iquizz=0;
    iscore=0;
    
    self.xofy.text= [NSString stringWithFormat:@"%d of 50",iquizz+1];
    self.score.text= [NSString stringWithFormat:@"Score: %d",iscore];
    
    UIFont *locationFont = [UIFont fontWithName:@"CourierNewPS-BoldMT" size:18];
    //UIFont *locationFont2 = [UIFont fontWithName:@"Arial" size:8];
    
    Question=[[UILabel alloc] initWithFrame:CGRectMake(0, 38, 320, 100)];
    //tweetLabel.font=[UIFont systemFontSize:14];
    Question.font=locationFont;
    Question.numberOfLines=6;
    Question.textAlignment=UITextAlignmentCenter;
    Question.backgroundColor=[UIColor clearColor];
       
    AnswerA=[[UILabel alloc] initWithFrame:CGRectMake(113, 183, 320, 21)];
    AnswerB=[[UILabel alloc] initWithFrame:CGRectMake(113, 228, 320, 21)];
    AnswerC=[[UILabel alloc] initWithFrame:CGRectMake(113, 273, 320, 21)];
    AnswerD=[[UILabel alloc] initWithFrame:CGRectMake(113, 317, 320, 21)];
    
    AnswerA.backgroundColor=[UIColor clearColor];
    AnswerB.backgroundColor=[UIColor clearColor];
    AnswerC.backgroundColor=[UIColor clearColor];
    AnswerD.backgroundColor=[UIColor clearColor];
    
    AnswerA.font=locationFont;
    AnswerB.font=locationFont;
    AnswerC.font=locationFont;
    AnswerD.font=locationFont;
      
    Question.text=@"What was the name of the first supercomputer ?";
    AnswerA.text=@"CDC 6600";
    AnswerB.text=@"Bull";
    AnswerC.text=@"Univac";
    AnswerD.text=@"DataPlex";
    
    [self.view addSubview:Question];
    [self.view addSubview:AnswerA];
    [self.view addSubview:AnswerB];
    [self.view addSubview:AnswerC];
    [self.view addSubview:AnswerD];
    
  //  score = [[UILabel alloc] init];
   //Question = [[UILabel alloc] init];
    
       
    self.next.enabled=NO;
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

}

-(IBAction) sendEmail:(id)sender {
    
    MFMailComposeViewController *mailComposer;
    // NSArray *emailAddresses;
    // emailAddresses=[[NSArray alloc] initWithObjects:@"david@pimpgloves.com",nil];
    
    mailComposer=[[MFMailComposeViewController alloc] init];
    mailComposer.mailComposeDelegate=self;
    //  mailComposer.title=@"HPC News";
    [mailComposer setMessageBody:[NSString stringWithFormat:@"%@\n\nA:%@\nB:%@\nC:%@\nD:%@\n",Question.text,AnswerA.text,AnswerB.text,AnswerC.text,AnswerD.text] isHTML:NO];
    [mailComposer setSubject:@"Question from HPC Map"];
    
    // [mailComposer setToRecipients:emailAddresses];
    [self presentModalViewController:mailComposer animated:YES];
    // [self resignFirstResponder] ;
    // [emailAddresses release];
    [mailComposer release];
    
}

-(void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    
    [self dismissModalViewControllerAnimated:YES];
}


-(IBAction)startover:(id)sender{
    
    iquizz=0;
    iscore=0;
    
    self.xofy.text= [NSString stringWithFormat:@"%d of 50",iquizz];
    self.score.text= [NSString stringWithFormat:@"Score: %d",iscore];
    
    self.AnswerA.textColor=[UIColor blackColor];
    self.AnswerB.textColor=[UIColor blackColor];
    self.AnswerC.textColor=[UIColor blackColor];
    self.AnswerD.textColor=[UIColor blackColor];
      
    Question.text=@"What was the name of the first supercomputer ?";
    AnswerA.text=@"CDC 6600";
    AnswerB.text=@"Bull";
    AnswerC.text=@"Univac";
    AnswerD.text=@"DataPlex";
    
     
    self.next.enabled=NO;

}

-(IBAction)newQuestion{
    
    iquizz++;
    
    self.xofy.text= [NSString stringWithFormat:@"%d of 50",iquizz+1];
       
    self.next.enabled=NO;
    AnswerA.textColor=[UIColor blackColor];
    AnswerB.textColor=[UIColor blackColor];
    AnswerC.textColor=[UIColor blackColor];
    AnswerD.textColor=[UIColor blackColor];
    
    if (iquizz == 1) {
        
        Question.text=@"When was the first supercomputer released ?";
        AnswerA.text=@"1956";
        AnswerB.text=@"1964";
        AnswerC.text=@"1976";
        AnswerD.text=@"1981";
        
    } else if (iquizz == 2) {
       
        Question.text=@"Where was the first supercomputer built ?";
        AnswerA.text=@"France";
        AnswerB.text=@"Spain";
        AnswerC.text=@"USA";
        AnswerD.text=@"Japan";
   
    } else if (iquizz == 3) {
            
        
        Question.text=@"Who designed the first supercomputer ?";
        AnswerA.text=@"Seymour IBM";
        AnswerB.text=@"Seymour Cray";
        AnswerC.text=@"Seymour Bull";
        AnswerD.text=@"Seymour Intel";
        
    } else if (iquizz == 4) {
        
         Question.text=@"Serial vs parallel calculations: How much power per operation may a CPU consume compared to a GPU (latest technologies) ?";
        AnswerA.text=@"7 times more";
        AnswerB.text=@"7 times less";
        AnswerC.text=@"70 times more";
        AnswerD.text=@"70 times less";
    
    }  else if (iquizz == 5) {
        
        Question.text=@"Which company marketed \"the world's first GPU\" in 1999 ?";
        AnswerA.text=@"Intel";
        AnswerB.text=@"IBM";
        AnswerC.text=@"MVIDIA";
        AnswerD.text=@"AMD";
               
        
    } else if (iquizz == 6) {
        
        Question.text=@"The name of the new Intel chip built to leverage parallel computing is:";
        AnswerA.text=@"Intel CPU";
        AnswerB.text=@"Intel GPU";
        AnswerC.text=@"Intel GIT";
        AnswerD.text=@"Intel MIC";
             
    } else if (iquizz == 7) {
        
        Question.text=@"Which one of the following supercomputers uses GPUs ?";
        AnswerA.text=@"Jaguar, USA";
        AnswerB.text=@"K Computer, Japan";
        AnswerC.text=@"Tianhe-1A, China";
        AnswerD.text=@"Kraken, USA";
             
    }  else if (iquizz == 8) {
        
        Question.text=@"What kind of chips does the second most powerful supercomputer in the world (K computer) contain ?";
        AnswerA.text=@"CPUs+GPUs";
        AnswerB.text=@"CPUs+MICs";
        AnswerC.text=@"CPUs only";
        AnswerD.text=@"GPUs only";
            
    } else if (iquizz == 9) {
        
        Question.text=@"By 2012-2013, which supercomputer is going to be upgraded with GPUs ?";
        AnswerB.text=@"K Computer, Japan";
        AnswerA.text=@"Jaguar, USA";
        AnswerC.text=@"Kraken, USA";
        AnswerD.text=@"Tianhe-1A, China";
        
    } else if (iquizz == 10) {
        
        Question.text=@"In Spain, the Barcelona supercomputing center recently developped a hybrid architecture: GPU + ..";
        AnswerA.text=@"Smartphone chip";
        AnswerB.text=@"CPU";
        AnswerC.text=@"MIC";
        AnswerD.text=@"GPU";
        
        /*
        Question.text=@"By 2018, supercomputers are expected to be able to process information on a level similar to a ..";
        AnswerA.text=@"human brain";
        AnswerB.text=@"dog brain";
        AnswerC.text=@"cat brain";
        AnswerD.text=@"wale brain";
        */
         
    } else if (iquizz == 11) {
        
        Question.text=@"Researchers have recently built computer chips that use .. instead of electricity (electrons) to transmit the information.";
        AnswerA.text=@"Light";
        AnswerB.text=@"Photons";
        AnswerC.text=@"Water";
        AnswerD.text=@"Air";
        
        /*
        Question.text=@"Which projects use distributed Desktops & Laptops that communicate through the network to resolve scientific questions ?";
        AnswerA.text=@"SETI@HOME";
        AnswerB.text=@"Folding@HOME";
        AnswerC.text=@"Docking@HOME";
        AnswerD.text=@"Africa@HOME";
         */
          
    
    } else if (iquizz == 12) {
        
        
        Question.text=@"Which country recently developed its first own computer chip ? ";
        AnswerA.text=@"Japan";
        AnswerB.text=@"Australia";
        AnswerC.text=@"China";
        AnswerD.text=@"Brazil";

        
        /*
        Question.text=@"Grid computing is a distributed system from multiple and .. administrative domains to achieve a common goal (i.e., scientific research).";
        AnswerA.text=@"interactive";
        AnswerB.text=@"dependent";
        AnswerC.text=@"independent";
        AnswerD.text=@"communicating";
         */
        
        
    } else if (iquizz == 13) {
        
        
        Question.text=@"Which language(s) can be used to develop on GPUs ? ";
        AnswerA.text=@"CUDA";
        AnswerB.text=@"OpenACC";
        AnswerC.text=@"C/C++";
        AnswerD.text=@"Fortran";
        
        /*
        Question.text=@"Recent findings says that biogas-powered cells would allow to pump up to .. into the grid.";
        AnswerA.text=@"5 MW";
        AnswerB.text=@"10 MW";
        AnswerC.text=@"50 MW";
        AnswerD.text=@"150 MW";
          */    
        
    } else if (iquizz == 14) {
             
        Question.text=@"In which journal appeared this quote : \"The processor is going through a bit of a schizophrenic mid-life crisis\" ?";
        AnswerA.text=@"EE times";
        AnswerB.text=@"NY times";
        AnswerC.text=@"LA times";
        AnswerD.text=@"Vancouver Sun";
        
        /*
        Question.text=@"The annual International Consumer Electronics Show (CES) in Las Vegas is a major technology-related ..";
        AnswerA.text=@"Trade show";
        AnswerB.text=@"Design show";
        AnswerC.text=@"Mum show";
        AnswerD.text=@"Academic show";
         */
            
    } else if (iquizz == 15) {
        
        Question.text=@"In what year the world's first hacker ruined a public demonstration of a wireless telegraph by sending Morse code insults via wire ?";
        
        AnswerA.text=@"1789";
        AnswerB.text=@"1804";
        AnswerC.text=@"1903";
        AnswerD.text=@"1945";
        
        
        /*
        Question.text=@"What happened at CES 2012 ?";
        AnswerA.text=@"iPhone 5 unveiled";
        AnswerB.text=@"Eminem was there";
        AnswerC.text=@"50 Cents was there";
        AnswerD.text=@"Obama was there";
        */
        
                
    } else if (iquizz == 16) {
        
        Question.text=@"The telegraph hacker was known as a ..";
        
        AnswerA.text=@"civil engineer";
        AnswerB.text=@"cook";
        AnswerC.text=@"school teacher";
        AnswerD.text=@"magician";        
        
    } else if (iquizz == 17) {
        
        Question.text=@"The Koomey’s Law says that the amount of power needed to perform a computing task falls by half every ..";
        AnswerA.text=@"1.5 months";
        AnswerB.text=@"1.5 years";
        AnswerC.text=@"2.5 months";
        AnswerD.text=@"2.5 years";
        
    } else if (iquizz == 18) {
        
        Question.text=@"By 2023, supercomputers are expected to be able to simulate a complete ..";
        AnswerA.text=@"rat brain";
        AnswerB.text=@"dog brain";
        AnswerC.text=@"human brain";
        AnswerD.text=@"ET brain";
        
        /*
        Question.text=@"In Spain, the Barcelona supercomputing center recently developped a hybrid chip architecture: GPU + ..";
        AnswerA.text=@"MIC";
        AnswerB.text=@"CPU";
        AnswerC.text=@"Smartphone chip";
        AnswerD.text=@"GPU";
         */
       
        
    } else if (iquizz == 19) {
        
        Question.text=@"The power that a supercomputer needs is similar to the power needed by a ..";
        AnswerA.text=@"high-speed train";
        AnswerB.text=@"plane";
        AnswerC.text=@"ship";
        AnswerD.text=@"car";
        
    } else if (iquizz == 20) {
        
        Question.text=@"How much power does that (roughly) correspond to ?";
        AnswerA.text=@"7 MW";
        AnswerB.text=@"14 MW";
        AnswerC.text=@"21 MW";
        AnswerD.text=@"28 MW";
        
    } else if (iquizz == 21) {
        
        Question.text=@"Which one of the following locations is ideal to build green computing centers and save cooling energy ?";
        AnswerA.text=@"Tennessee";
        AnswerB.text=@"Iceland";
        AnswerC.text=@"France";
        AnswerD.text=@"Brazil";
        
    } else if (iquizz == 22) {
        
        Question.text=@"Which is the #1 most greenest supercomputer in the world?";
        AnswerA.text=@"Tianhe-1A, China";
        AnswerB.text=@"K Computer, Japan";
        AnswerC.text=@"rzuseq, BG/Q, USA";
        AnswerD.text=@"Jaguar, USA";
        
       
        
    } else if (iquizz == 23) {
        
        Question.text=@"Which is the #1 most powerful supercomputer in the world?";
        AnswerA.text=@"Jaguar, USA";
        AnswerD.text=@"K Computer, Japan";
        AnswerC.text=@"Tsanhe-1A, China";
        AnswerB.text=@"Sequoia, BG/Q, USA";
        
    } else if (iquizz == 24) {
        
        Question.text=@"Which is the #2 most powerful supercomputer in the world?";
        AnswerB.text=@"Tianhe-1A, China";
        AnswerA.text=@"K Computer, Japan";
        AnswerC.text=@"Jaguar, USA";
        AnswerD.text=@"IBM BlueGene/Q, USA";
        
    } else if (iquizz == 25) {
        
        Question.text=@"Which is the #3 most powerful supercomputer in the world?";
        AnswerA.text=@"Tianhe-1A, China";
        AnswerB.text=@"K Computer, Japan";
        AnswerC.text=@"Mira, BG/Q, USA";
        AnswerD.text=@"Jaguar, USA";
        
    } else if (iquizz == 26) {
        
        Question.text=@"Which \"measures\" can be used to assess how green is a computing center ? ";
        
        AnswerA.text=@"Perf. Per Watt";
        AnswerB.text=@"GPUE";
        AnswerC.text=@"Hardware cost";
        AnswerD.text=@"Energy cost";
        
    } else if (iquizz == 27) {
        
              
        Question.text=@"Which of the following energy sources could be used to power the battery of your cell phones ?";
        AnswerA.text=@"Solar panels";
        AnswerB.text=@"Human movements";
        AnswerC.text=@"Hydrogen cells";
        AnswerD.text=@"Biogas cells";
        
    }  else if (iquizz == 28) {
        
        Question.text=@"Which projects use distributed computers that communicate through the network to resolve scientific questions ?";
        AnswerA.text=@"SETI@HOME";
        AnswerB.text=@"Folding@HOME";
        AnswerC.text=@"Docking@HOME";
        AnswerD.text=@"Africa@HOME";
               
        /*
        Question.text=@"Researchers have recently built computer chips that use light (photons) instead of electricity (electrons) to transmit the information.";
        AnswerA.text=@"";
        AnswerB.text=@"NO";
        AnswerC.text=@"YES";
        AnswerD.text=@"";
         */
               
    } else if (iquizz == 29) {
        
        Question.text=@"Which platform is known as the social supecomputing platform for providing ready-to-use programs that would answer a single question ?";
        
        AnswerA.text=@"Opani";
        AnswerB.text=@"CharityEngine";
        AnswerC.text=@"Amazing EC2";
        AnswerD.text=@"Jaguar";
        
        /*
        Question.text=@"Which country recently developed its first own computer chip ? ";
        AnswerA.text=@"China";
        AnswerB.text=@"Australia";
        AnswerC.text=@"Japan";  
        AnswerD.text=@"Brazil";
         */
        
        
    } else if (iquizz == 30) {
        
        Question.text=@"Supercomputing simulations can be used to predict the impact of a marine power generation installation on the environment.";
        AnswerA.text=@"YES";
        AnswerB.text=@"NO";
        AnswerC.text=@"";
        AnswerD.text=@"";
        
    }  else if (iquizz == 31) {
        
        Question.text=@"In 2012, how many IBM data centers have been honored by  the European Commission for their energy efficiency ?";
        AnswerA.text=@"21";
        AnswerB.text=@"27";
        AnswerC.text=@"35";
        AnswerD.text=@"42";
        
    } else if (iquizz == 32) {
        
        Question.text=@"Individuals can pay for using computing resources from .. platforms in order to launch their own computer simulations. ";
        AnswerA.text=@"Amazon EC2 Cluster";
        AnswerB.text=@"Opani";
        AnswerC.text=@"CharityEngine";
        AnswerD.text=@"Jaguar";
        
    } else if (iquizz == 33) {
        
        Question.text=@"In 2012, which country might become the world's #1 cloud computing market.";
        AnswerA.text=@"Japan";
        AnswerB.text=@"China";
        AnswerC.text=@"USA";
        AnswerD.text=@"France";
        
    } else if (iquizz == 34) {
        
        Question.text=@"By 2020, U.S. organizations could save $12.3 billion in energy cost by moving to the Cloud: this corresponds to .. million barrels of oil";
        AnswerA.text=@"200";
        AnswerB.text=@"150";
        AnswerC.text=@"100";
        AnswerD.text=@"50";
              
    } else if (iquizz == 35) {
       
        Question.text=@"Which of the following techniques are used to reduce energy costs and hardware failures ?";
        AnswerA.text=@"Umbrella cooling";
        AnswerB.text=@"Water cooling";
        AnswerC.text=@"Air cooling";
        AnswerD.text=@"Quantum cooling";
              
    } else if (iquizz == 36) {
        
        Question.text=@"The K Computer, second most powerful supercomputer in the world uses ..";
        AnswerA.text=@"Water cooling";
        AnswerB.text=@"Air cooling";
        AnswerC.text=@"Water & air cooling";
        AnswerD.text=@"Nitrogen cooling";
        
    } else if (iquizz == 37) {
        
        Question.text=@"Recent findings says that biogas-powered cells would allow to pump up to .. into a system of distributed computational resources.";
        AnswerA.text=@"5 MW";
        AnswerB.text=@"10 MW";
        AnswerC.text=@"50 MW";
        AnswerD.text=@"150 MW";
        
        /*
        Question.text=@"Which language(s) can be used to develop on GPUs ? ";
        AnswerA.text=@"CUDA";
        AnswerB.text=@"OpenACC";
        AnswerC.text=@"C/C++";
        AnswerD.text=@"Fortran";
        */
    
    } else if (iquizz == 38) {
        
        /*
        Question.text=@"The annual International Consumer Electronics Show (CES) in Las Vegas is a major technology-related ..";
        AnswerA.text=@"Trade show";
        AnswerB.text=@"Design show";
        AnswerC.text=@"Mum show";
        AnswerD.text=@"Academic show";
         */
        
    
         Question.text=@"What happened at the annual International Consumer Electronics Show (CES 2012) ?";
         AnswerC.text=@"50 Cent was there";
         AnswerB.text=@"Eminem was there";
         AnswerA.text=@"iPhone5 unveiled"; 
         AnswerD.text=@"Obama was there";
                
        /*
        Question.text=@"Which journal this quote is attributed to: \"The processor is going through a bit of a schizophrenic mid-life crisis\"";
        AnswerA.text=@"LA times";
        AnswerB.text=@"NY times";
        AnswerC.text=@"EE times";
        AnswerD.text=@"Vancouver Sun";
         */
        
    } else if (iquizz == 39) {
        
        Question.text=@"Whos this quote is attributed to: \"Try not to become a man of success but a man of value.\"";
        AnswerA.text=@"Albert Einstein";
        AnswerB.text=@"Barack Obama";
        AnswerC.text=@"Nicolas Sarkozy";
        AnswerD.text=@"Angela Merkel";
        
    } else if (iquizz == 40) {
        
        Question.text=@"By 2020, we are going to reach the era of supercomputing at the .. ";
         AnswerA.text=@"Exascale";
         AnswerB.text=@"Petascale";
        AnswerC.text=@"Terascale";
         AnswerD.text=@"Bugscale";
        
    } else if (iquizz == 41) {
        
        Question.text=@"In Spain, the e-learning platform for virtual classrooms in the supercomputing center of Galicia has .. users.";
        AnswerA.text=@"10,000";
        AnswerB.text=@"20,000";
        AnswerC.text=@"30,000";
        AnswerD.text=@"50,000";
        
    } else if (iquizz == 42) {
        
        Question.text=@"The official list that ranks the world's most powerful supercomputers according to their performance (flop) is named:";
        AnswerA.text=@"T0P10";
        AnswerB.text=@"TOP100";
        AnswerC.text=@"TOP500";
        AnswerD.text=@"TOP1000";
        
    } else if (iquizz == 43) {
        
        Question.text=@"The official list that ranks the world's most powerful supercomputers according to their energy consumption per flop is named:";
        AnswerA.text=@"GREEN1000";
        AnswerB.text=@"GREEN500";
        AnswerC.text=@"GREEN100";
        AnswerD.text=@"GREEN50";
        
    } else if (iquizz == 44) {
        
        Question.text=@"The name of logarithmic scale that combines Green500+Top500 to look at \"performance vs energy efficiency\" through a single scalar:";
        AnswerA.text=@"Exascalar";
        AnswerB.text=@"Petascalar";
        AnswerC.text=@"Terascalar";
        AnswerD.text=@"Bugscalar";
        
    } else if (iquizz == 45) {
        
        Question.text=@"The name of the NVIDIA exascale supercomputer that should be released by 2018 is .. ";
        AnswerA.text=@"Achille";
        AnswerB.text=@"Echelle";
        AnswerC.text=@"Echelon";
        AnswerD.text=@"Achete";
        
    } else if (iquizz == 46) {
        
        Question.text=@"Intel’s 2018 Exascale Goal is: delivering one Exaflops in a power envelope of .. ";
        AnswerA.text=@"1 MW";
        AnswerB.text=@"5 MW";
        AnswerC.text=@"10 MW";
        AnswerD.text=@"20 MW";
        
        /*
        Question.text=@"In January 2012, what new technology for the developing world was unveiled by a Cambridge nonprofit organization ? ";
        AnswerA.text=@"10$ smartphone";
        AnswerB.text=@"100$ smartphone";
        AnswerC.text=@"10$ tablet";
        AnswerD.text=@"100$ tablet";
         */
        
    } else if (iquizz == 47) {
                    
        Question.text=@"In January 2012, which company announced the creation of the world's smallest storage device (12-atom size) ?";
        AnswerA.text=@"Cray";
        AnswerB.text=@"IBM";
        AnswerC.text=@"Intel";
        AnswerD.text=@"Nvidia";
        
        /*
        Question.text=@"How many barrels of oil per year equals to the excess consumption of water & fossil fuels due to food waste ? ";
        AnswerA.text=@"30 million";
        AnswerB.text=@"300 million";
        AnswerC.text=@"30 billion";
        AnswerD.text=@"300 billion";
         */

        
    } else if (iquizz == 48) {
        
        Question.text=@"Which countries are leading the supercomputing race ?";
        AnswerA.text=@"China & USA";
        AnswerC.text=@"Japan & USA";
        AnswerB.text=@"China & Japan";
        AnswerD.text=@"France & Germany";
        
    } else if (iquizz == 49) {
        
        Question.text=@"Which country is leading the green supercomputing race ?";
        AnswerA.text=@"USA";
        AnswerB.text=@"China";
        AnswerC.text=@"Japan";
        AnswerD.text=@"France";
                
        
    } else if (iquizz == 50) {
        
        Question.text=@"Which company is leading the green supercomputing race ?";
        AnswerA.text=@"IBM";
        AnswerB.text=@"Cray";
        AnswerC.text=@"Intel";
        AnswerD.text=@"Bull";   
        
    }  
    
    
     /*
       The European Commission has honored 27 IBM data centers for 
      their energy efficiency
     */

}

-(IBAction)buttonA:(id)sender{
    
    if (iquizz == 0 || iquizz == 10 || iquizz == 20 || iquizz == 30 || iquizz == 40 || iquizz == 50 || iquizz == 27 || iquizz==32 || iquizz==26 || iquizz==28 || iquizz==13) {
       
        AnswerA.textColor=[UIColor greenColor];
        self.next.enabled=YES;
   
                
    } else if (iquizz == 4 || iquizz == 14 || iquizz == 24 || iquizz == 34 || iquizz == 44 || iquizz== 11 || iquizz==28) {
        
     // iscore++;
   //   result.text=@"You are right";
        AnswerA.textColor=[UIColor greenColor];
     ;
        self.next.enabled=YES;
      //[self newQuestion];
    
        
    } else if (iquizz == 9 || iquizz == 19 || iquizz == 29 || iquizz == 39 || iquizz == 49 ) {
        
     
         AnswerA.textColor=[UIColor greenColor];
       //  iquizz++;
        self.next.enabled=YES;
      //  [self newQuestion];
          
    } else {
    //    iscore--;
     //   result.text=@"Try again";
        AnswerA.textColor=[UIColor redColor];
   /// self.score.text= [NSString stringWithFormat:@"Score: %d",iscore];
        
    }
    
    
    if(AnswerA.textColor == [UIColor redColor]){
        iscore--;
         self.score.text= [NSString stringWithFormat:@"Score: %d",iscore];
    } else {
        iscore++;
         self.score.text= [NSString stringWithFormat:@"Score: %d",iscore];
       
        
    }
    
}

-(IBAction)buttonB:(id)sender{
    
    
    if (iquizz == 1 || iquizz == 11 || iquizz == 21 || iquizz == 31 || iquizz == 41 || iquizz==32 || iquizz==35 || iquizz==26 || iquizz==28) {
        
      //  iscore++;
     //   result.text=@"You are right";
     //  self.score.text= [NSString stringWithFormat:@"Score: %d",iscore];
         AnswerB.textColor=[UIColor greenColor];
       //  iquizz++;
        self.next.enabled=YES;
       // [self newQuestion];
        
        
    } else if (iquizz == 3 || iquizz == 23 || iquizz == 33 || iquizz == 43 || iquizz==13) {
        
      //  iscore++;
     //   result.text=@"You are right";
     //  self.score.text= [NSString stringWithFormat:@"Score: %d",iscore];
         AnswerB.textColor=[UIColor greenColor];
       //  iquizz++;
        self.next.enabled=YES;
      //  [self newQuestion];
        
        
    } else if (iquizz == 17 || iquizz == 27 || iquizz == 47 ) {
        
     //   iscore++;
      //  result.text=@"You are right";
     //  self.score.text= [NSString stringWithFormat:@"Score: %d",iscore];
         AnswerB.textColor=[UIColor greenColor];
       //  iquizz++;
        self.next.enabled=YES;
     //   [self newQuestion];
        
        
    } else {
        
      //  result.text=@"Try again";
        AnswerB.textColor=[UIColor redColor];
       // self.score.text= [NSString stringWithFormat:@"Score: %d",iscore-1];
        
    }

    if(AnswerB.textColor == [UIColor redColor]){
        iscore--;
        self.score.text= [NSString stringWithFormat:@"Score: %d",iscore];
    } else {
        iscore++;
        self.score.text= [NSString stringWithFormat:@"Score: %d",iscore];
        
        
    }
    
    
}

-(IBAction)buttonC:(id)sender{
    
    if (iquizz == 2 || iquizz == 12 || iquizz == 22 || iquizz == 32 || iquizz == 42 || iquizz==7 || iquizz==26 || iquizz==36 || iquizz==37) {
        
    
         AnswerC.textColor=[UIColor greenColor];
      //   iquizz++;
        self.next.enabled=YES;
      //  [self newQuestion];
        
        
    } else if (iquizz == 5 || iquizz == 15 || iquizz == 25 || iquizz == 35 || iquizz == 45 ) {
        
      //  iscore++;
      //  result.text=@"You are right";
      //  self.score.text= [NSString stringWithFormat:@"Score: %d",iscore];
         AnswerC.textColor=[UIColor greenColor];
     //    iquizz++;
        self.next.enabled=YES;
   //     [self newQuestion];
        
        
    } else if (iquizz == 8 || iquizz == 18 || iquizz == 28 || iquizz == 38 || iquizz == 48 || iquizz==27) {
        
     //   iscore++;
     //   result.text=@"You are right";
     //   self.score.text= [NSString stringWithFormat:@"Score: %d",iscore];
         AnswerC.textColor=[UIColor greenColor];
      //   iquizz++;
        self.next.enabled=YES;
      //  [self newQuestion];
        
        
    } else {
        
      //  result.text=@"Try again";
        AnswerC.textColor=[UIColor redColor];
      //  self.score.text= [NSString stringWithFormat:@"Score: %d",iscore-1];
        
    }
    
    if(AnswerC.textColor == [UIColor redColor]){
        iscore--;
        self.score.text= [NSString stringWithFormat:@"Score: %d",iscore];
    } else {
        iscore++;
        self.score.text= [NSString stringWithFormat:@"Score: %d",iscore];
               
    }

}

-(IBAction)buttonD:(id)sender{
    
    
    if (iquizz == 6 || iquizz == 16 || iquizz == 26 || iquizz == 46 || iquizz==27 || iquizz==28) {
        
     //   iscore++;
     //   result.text=@"You are right";
     //   self.score.text= [NSString stringWithFormat:@"Score: %d",iscore];
         AnswerD.textColor=[UIColor greenColor];
    //   iquizz++;
        self.next.enabled=YES;
        
      //  [self newQuestion];
        
        
    } else {
        
      //  result.text=@"Try again";
        AnswerD.textColor=[UIColor redColor];
      //  self.score.text= [NSString stringWithFormat:@"Score: %d",iscore-1];
        
    }
    
    if(AnswerD.textColor == [UIColor redColor]){
        iscore--;
        self.score.text= [NSString stringWithFormat:@"Score: %d",iscore];
    } else {
        iscore++;
        self.score.text= [NSString stringWithFormat:@"Score: %d",iscore];
        
        
    }
}

-(void) dealloc{
    
    [Question release];
    [AnswerA release];
    [AnswerB release];
    [AnswerC release];
    [AnswerD release];
    [buttonA release];
    [buttonB release];
    [buttonC release];
    [buttonD release];
    [xofy release];
    [score release];
    [result release];
    [toolbar release];
    [result release];
    [next release];
    [startover release];
    [super dealloc];
  
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
