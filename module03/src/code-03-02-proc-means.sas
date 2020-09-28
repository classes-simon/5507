* code-03-02-proc-means.sas
  written by Steve Simon
  2020-09-28;

options papersize=(8in 4in) nodate;

libname intro
  "q:/5507/module03/data";

ods printer printer=png
  file="q:/5507/module03/results/code-03-02.png";

********* ********* ********* ********* *********

  This data set shows data various body 
  measurements. A brief description of this 
  file is available at

  http://www.amstat.org/publications/jse/datasets/fat.txt

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

********* ********* ********* ********* *********;

proc means
    n mean std min max
    data=intro.fat;
  var ht;
  title1 "Simple descriptive statistics for ht";
  title2 "Notice the unusual minimum value";
run;

********* ********* ********* ********* *********

  There is an unusual data value for ht, 29.5 inches.
  While this is not totally outside the realm of
  possibility, you should always ask when you
  see something unusual like this.

********* ********* ********* ********* *********;
   code 01 below this line
   don't include this code

ods printer printer=png
  file="q:/5507/module03/results/code-03-03.png";

proc sort
    data=intro.fat;
  by ht;
run;

proc print
    data=intro.fat(obs=1);
  title1 "The row with the smallest ht";
run;

* Clearly something is wrong. There's no way that a
  person with such a small height would have such a
  big weight.


