**** comments below **** **** **** **** **** ****

  This program shows how to analyze data with 
  mostly continuous variables. It uses a dataset
  with measurements of body fat. You can measure
  body fat accurately using hydrostatic weighing,
  a complex process where you weigh someone will
  submersed in a tank of water. In addition, you
  have measures of circumference at various body
  locations. Measuring circumference is a lot 
  faster and easier. Can these easy measures
  predict body fat as measured by hydrostatic
  weighing?
  
  A brief description of this file is available
  at

www.amstat.org/publications/jse/datasets/fat.txt

  Here is the program header and an option that
  is only needed for me so that my SAS output
  will fit easily on a PowerPoint slide.

**** comments above **** **** sas code below ****;

* code-03-01-read-fat-data.sas
  written by Steve Simon
  2020-09-28;

**** sas code above **** **** **** **** **** ****;

options papersize=(8in 4in) nodate;

ods printer printer=png
  file="q:/5507/module03/results/code-03-01.png";

**** comments below **** **** **** **** **** ****

  Before you start any serious SAS programming,
  tell SAS where everything belongs
  
  The filename statement tells SAS where you 
  have placed your raw data file.                     

  The libname statement tells SAS where you want
  it to place any permanent SAS data files.
  
  You should also include an ods statement to
  store your output as a pdf file.
  
  VERY IMPORTANT! You need to turn off ODS at the 
  completion of your program or none of the 
  output gets saved.
  
**** comments above **** **** sas code below ****;

filename fat
  "q:/5507/module03/data/fat.txt";

libname intro
  "q:/5507/module03/data";

**** sas code above **** **** comments below ****

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

**** comments above **** **** sas code below ****;

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

**** sas code above **** **** comments below ****

The label statemet is optional, but strongly
recommended. It attaches descrptive labels to
your variables. These labels are used in some 
(but not all) of the SAS output.

**** comments above **** **** sas code below ****;

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

**** sas code above **** **** comments below ****

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
  
**** comments above **** **** sas code below ****;

proc print
    data=intro.fat(obs=10);
  var case fat_b fat_s dens age;
  title1 "The first ten rows and five columns";
  title2 "of the fat data set";
run;

**** sas code above **** **** footnote below ****

  The output from this procedure shows the first
  ten rows and five columns of the fat data.

**** footnote above **** **** comments below ****

  The means procedure will produce descriptive 
  statistics for your data. By default, it will
  produce the count of non-missing values, the 
  mean, the standard deviation, and the minimum
  and maximum values, but I am listing them
  explicitly here, just for show.
  
  The data option tells SAS which data set you
  want descriptive statistics on, and the var
  statement tells SAS which variable(s) you
  want descriptive statistics on.

  This data set did not have a header, a line
  at the very top of the file that lists 
  variable names. For files with a header, you
  should consider using the import procedure,
  which I will describe later.

**** comments above **** **** **** **** **** ****;

* Note: This ods statement below is needed for my
  PowerPoint slides. You should not include this
  in your work.;

ods printer printer=png
  file="q:/5507/module03/results/code-03-03.png";

**** **** **** **** **** **** sas code below ****;

proc means
    n mean std min max
    data=intro.fat;
  var ht;
  title1 "Simple descriptive statistics for ht";
  title2 "Notice the unusual minimum value";
run;

**** sas code above **** **** footnote below ****

  There is an unusual data value for ht, 29.5
  inches. While this is not totally outside the
  realm of possibility, you should always ask
  when you see something unusual like this.

**** footnote above **** **** **** **** **** ****;

* Note: This odcs statement below is needed for my
  PowerPoint slides. You should not include this
  in your work.;

ods printer printer=png
  file="q:/5507/module03/results/code-03-03.png";

**** **** **** **** **** **** comments below ****

  To investigate further, sort the data and print
  the first observation.

**** comments above **** **** sas code below ****;

proc sort
    data=intro.fat;
  by ht;
run;

proc print
    data=intro.fat(obs=1);
  title1 "The row with the smallest ht";
run;

**** sas code above **** **** footnote below ****

  Clearly something is wrong. There's no way that a
  person with such a small height would have such a
  big weight.


**** footnote above **** **** comments below ****

