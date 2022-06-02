//
//  main.m
//  MDOTimeTableTool
//
//  Created by Taikhoom Attar on 6/2/22.
//

#import <Foundation/Foundation.h>
@import MDOLib;

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        if (argc != 9){
            NSLog(@"Usage: MDOTimeTableTool <start date yyyy-mm-dd> <number of days> <lat> <lon> <alt> <timezone> <round?> <output filename>");
            NSLog(@"Example: MDOTimeTableTool 2021-10-07 30 22.8408 74.2482 330 Asia/Kolkata yes output.csv");
            return -1;
        }
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        NSDate *date =[dateFormatter dateFromString:[NSString stringWithUTF8String:argv[1]]];
        
        int nDays = strtol(argv[2], NULL, 10);
        
        double lat = strtod(argv[3], NULL);
        double lon = strtod(argv[4], NULL);
        double alt = strtod(argv[5], NULL);
        
        NSTimeZone *tz = [NSTimeZone timeZoneWithName:[NSString stringWithUTF8String:argv[6]]];
        
        bool round = [[NSString stringWithUTF8String:argv[7]] isEqualToString:@"yes"];
        
        NSString *fileName = [NSString stringWithUTF8String:argv[8]];
        [[NSFileManager defaultManager] createFileAtPath:fileName contents:nil attributes:nil];
        
        NSMutableString* output = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"%f\n%f\n%fm\n%@\nDate,Sihori,Fajr Start,Sunrise,Zawaal,Zohr End,Asr End,Maghrib,Nisful Layl,Nisful Layl End\n", lat, lon, alt, [tz name] ]];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"h:mm:ss"];
        [formatter setTimeZone:tz];
        
        for (int lcv = 0; lcv < nDays; lcv++){
            
            NSDictionary *salaatDict = round ?
                [MDOLib roundedSalaatArrayForDate:[date dateByAddingTimeInterval:86400*lcv] lat:lat lon:lon altitude:alt] :
                [MDOLib salaatArrayForDate:[date dateByAddingTimeInterval:86400*lcv] lat:lat lon:lon altitude:alt];
            
            [output appendFormat:@"%@,%@,%@,%@,%@,%@,%@,%@,%@,%@\n",\
                     [dateFormatter stringFromDate:[date dateByAddingTimeInterval:86400*lcv]],
                     [formatter stringFromDate:[salaatDict objectForKey:@"sihori"]],
                     [formatter stringFromDate:[salaatDict objectForKey:@"fajr"]],
                     [formatter stringFromDate:[salaatDict objectForKey:@"sunrise"]],
                     [formatter stringFromDate:[salaatDict objectForKey:@"zawaal"]],
                     [formatter stringFromDate:[salaatDict objectForKey:@"zohr_end"]],
                     [formatter stringFromDate:[salaatDict objectForKey:@"asr_end"]],
                     [formatter stringFromDate:[salaatDict objectForKey:@"maghrib"]],
                     [formatter stringFromDate:[salaatDict objectForKey:@"nisful_layl"]],
                     [formatter stringFromDate:[salaatDict objectForKey:@"nisful_layl_end"]]
            ];
 
        }
        
        [output writeToFile:fileName atomically:YES encoding:NSUTF8StringEncoding error:nil];
        
        
    }
    return 0;
}
