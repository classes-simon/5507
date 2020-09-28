* code-03-01-read-fat-data.sas
  written by Steve Simon
  2020-09-28;

* Note: The options statement below insures that 
  my output will fit easily on a PowerPont slide.
  You should not use this option for your work;
  
options papersize=(8in 4in) nodate;

********* ********* ********* ********* *********

  Before you start any serious SAS programming,
  tell SAS where everything belongs
  
  The filename statement tells SAS where you 
  have placed your raw data file.                     

  The libname statement tells SAS where you want
  it to place any permanent SAS data files            ;
  
  The ods statement tells SAS where to store your
  output and in what format.  
  
  I am printing to a png file to make it easier
  to include the output in my Powerpoint
  presentation. You should print to a pdf file.
  
  VERY IMPORTANT! You need to turn off ODS at the 
  completion of your program or none of the 
  output gets saved.
  
  You can view the output on the screen and then
  save the output manually, but it is good form
  to explicity specify the location of output in 
  your program                                    

********* ********* ********* ********* *********;

filename fat
  "q:/5507/module03/data/fat.txt";

libname intro
  "q:/5507/module03/data";

* You should use "ods pdf file="your-name.pdf";

ods printer printer=png
  file="q:/5507/module03/results/code-03-01.png";

********* ********* ********* ********* *********

  The data statement creates a new data set. If 
  you want a permanent data set, specify a two part
  name. The part before the period is the libname
  and tells SAS where to store your file. The part
  after the period gives the name of the file. By
  default, all SAS files use the extension .sas7bdat  
  
  This data set did not have a header, a line
  at the very top of the file that lists 
  variable names. For files with a header, you
  should consider using the import procedure.

  The infile statement tells SAS where to find the
  raw data. The delimiter option tells SAS how to
  tell when one number stops and when another
  begins. In this example, spaces are delimiters.     
  
  The input statement tells SAS what the names are
  for the variables you are reading in.
  
  I'm using the variable names provided but if
  you create your own names, use brief (but 
  descriptive) name for EVERY variable in your
  data set. There's no precise rule, but names
  should be around 8 characters long. Longer 
  variable names make your typing tedious and 
  much shorter variable names makes your code 
  terse and cryptic.

  I'm a bit more terse with these variable names
  than I normally would be just to reduce the 
  amount of typing you have to do.

  You should avoid special symbols in your 
  variable names especially symbols that are 
  likely to cause confusion (the dash symbol,
  for example, which is also the symbol for 
  subtraction). You should also avoid blanks.
  These rules are pretty much universal across
  most statistical software packages.

  There are times when you'd like to have a 
  blank in your variable name and you can use
  two special symbols in SAS (and most other 
  statistical pacakges):

  * the underscore symbol (above the minus key
    on most keyboards) and
  * the dot (period).

  These symbols create some artificial spacing
  that mimics the blanks. Another approach is 
  "CamelCase" which is the mixture of upper and
  lower case within a variable name with each 
  uppercase designating the beginning of a new "word".

  The label statement provides descriptive labels
  for your variables. You can use special characters
  like parentheses, slashes, and dashes that would
  not be allowed in a variable name. The variable
  label provides you with the opportunity to give
  a more detailed description of your variable,
  including the units of measurement. The variable
  labels will appear on some of the SAS output,
  which helps you clarify what the tables and
  graphs are representing.  
  
  The run statement tells SAS that you are ready
  to go and there is nothing more to input or 
  manipulate.                                         

********* ********* ********* ********* *********;

data intro.fat;
  infile fat delimiter=' ';
  input 
    case
    fat_b
    fat_s
    dens
    age
    wt
    ht
    bmi
    ffw
    neck
    chest
    abdomen
    hip
    thigh
    knee
    ankle
    biceps
    forearm
    wrist;

********* ********* ********* ********* *********

The label statemet is optional, but strongly
recommended. It attaches descrptive labels to
your variables. These labels are used in some 
(but not all) of the SAS output.

********* ********* ********* ********* *********;

  label
    case="Case number"
    fat_b="Percent body fat, Brozek's equation"
    fat_s="Percent body fat, Siri's equation"
    dens="Density"
    age="Age (yrs)"
    wt="Weight (lbs)"
    ht="Height (inches)"
    bmi="Adiposity index (kg/m^2)"
    ffw="Fat Free Weight"
    neck="Neck circumference (cm)"
    chest="Chest circumference (cm)"
    abdomen="Abdomen circumference (cm)"
    hip="Hip circumference (cm)"
    thigh="Thigh circumference (cm)"
    knee="Knee circumference (cm)"
    ankle="Ankle circumference (cm)"
    biceps="Extended biceps circumference (cm)"
    forearm="Forearm circumference (cm)"
    wrist="Wrist circumference (cm)"  
  ;
run;

********* ********* ********* ********* *********

  It's always a good idea to print out a small 
  piece of your data to make sure everything
  is okay.
  
  The data option tells SAS what data set you
  want to print. If you omit this, SAS will
  print the most recently created data set.
  
  The obs=10 option limits the number of rows 
  printed to the first 10. For large data sets,
  you should always take advantage of this 
  option.
  
  The var statement limits the variables that
  you print to those that you specify. Again,
  
  The title statement tells SAS to provide
  a descriptive title at the top of the page
  of output.
  
  The run statement says you're done with the
  procedure.
  
********* ********* ********* ********* *********;
  
proc print
    data=intro.fat(obs=10);
  var case fat_b fat_s dens age;
  title1 "The first ten rows and five columns";
  title2 "of the fat data set";
run;

********* ********* ********* ********* *********

  The output from this procedure shows the first
  ten rows and five columns of the fat data.

********* ********* ********* ********* *********;
