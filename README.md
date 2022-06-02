# MDOTimeTableTool

This is a simple macOS Command Line application that utilizes Mumineen.org's salaat time algorithm to generate tables (in CSV format) of salaat times.  Given a start date, 
coordinates, and  the desired number of days, it will generate a CSV file containing the full set of times for that number of days, beginning at the start date.  A flag can be used 
to select if properly rounded times are desired rather than exact times.

## Usage
A pre-built binary is provided in the Build folder.  To use, the DYLD_LIBRARY_PATH and DYLD_FRAMEWORK_PATH environment variables must contain the location of MDOLib.framework.  For 
example:

    $ DYLD_LIBRARY_PATH=. DYLD_FRAMEWORK_PATH=. ./MDOTimeTableTool

    2022-06-02 01:01:58.199 MDOTimeTableTool[46671:52390668] Usage: MDOTimeTableTool <start date yyyy-mm-dd> <number of days> <lat> <lon> <alt> <timezone> <round?> <output filename>

## Parameters
* \<start date yyyy-mm-dd\> : The date to begin calculating times from, in yyyy-mm-dd format.
* \<number of days\> : The number of days to calculate times for.
* \<lat\> : Latitude of the desired location
* \<lon\> : Longitude of the desired location
* \<alt\> : Altitude of the desired location, from sea level
* \<timezone\> : The name of the time zone to display the times in.  For example, "America/New_York" or "Asia/Kolkata"
* \<round?> : "yes" if rounding is desired, any other value results in no rounding being applied.
* \<output filename\> : The path and filename of the desired output file.  Recommended to end in .csv.
