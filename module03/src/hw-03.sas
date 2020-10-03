**** sas_code_p1         **** **** **** **** ****;

* hw-03.sas
  written by Steve Simon
  2020-10-03;

libname binary 
  "q:/5507/module02/data";

**** comments_p1         **** **** **** **** ****

  This program shows how I answered the homework 
  questions for module03. There are other 
  approaches that may also be valid.

  This program produces SAS output in individual
  graphic images (png format) rather than as a
  single pdf file. This makes it easier for me
  to prepara a Powerpoint presentation. You, 
  however, should not use this approach. Ignore
  all the "ods printer" statements and use a
  single "ods pdf" at the beginning of your
  program and remember to put an "ods pdf close"
  at the end of your program.

**** comments_p2         **** **** **** **** ****

  This code presumes that you have read in the
  sleep data already and stored it using a two
  part name.

  You may need to convert some variables stored
  as strings to variables stored as numeric.

  This is a simple approach. You can also use the
  input function.

**** sas_code_p2         **** **** **** **** ****;

data xfer;
  set binary.sleep;
  nondreaming1=nondreaming+0;
  dreaming1=dreaming+0;
  totalsleep=totalsleep+0;
  lifespan1=lifespan+0;
  gestation1=gestation+0;
  drop nondreaming--gestation;
run;

**** comments_p3         **** **** **** **** ****

  This step is optional, but I like having the
  original variable names.

**** sas_code_p3         **** **** **** **** ****;

data xfer;
  set xfer(
    rename=(
	  nondreaming1=nondreaming
	  dreaming1=dreaming
	  totalsleep1=totalsleep
	  lifespan1=lifespan
	  gestation1=gestation
    )
  );
  drop nondreaming1--gestation1;
run;

**** comments_p4         **** **** **** **** ****

  Print the first few rows as a quality check.

**** ignore_this         **** **** **** **** ****;

options papersize=(8in 4in) nodate;

ods printer printer=png
  file="q:/5507/module03/results/hw-03-p4.png";

**** sas_code_p4         **** **** **** **** ****;

proc print
    data=xfer(obs=10);
  var species bodywt;
  title1 "First ten observations";
run;

**** comments_q1a        **** **** **** **** ****

  1. Notice that there is a huge range in body
  weight. Display the information for the
  smallest and the largest mammals.

**** ignore_this         **** **** **** **** ****;

ods printer printer=png
  file="q:/5507/module03/results/hw-03-q1a.png";

**** sas_code_q1a        **** **** **** **** ****;

proc sort
    data=xfer;
  by bodywt;
run;

proc print
    data=xfer(obs=1);
  title1 "The smallest body weight";
run;

**** comments_q1b        **** **** **** **** ****

  Use the descending keyword to place the largest
  value at the top.

**** ignore_this         **** **** **** **** ****;

ods printer printer=png
  file="q:/5507/module03/results/hw-03-q1b.png";

**** sas_code_q1b        **** **** **** **** ****;

proc sort
    data=xfer;
  by descending bodywt;
run;

proc print
    data=xfer(obs=1);
  title1 "The largest body weight";
run;

**** comments_q2         **** **** **** **** ****

  2. Which variables have missing data?

**** ignore_this         **** **** **** **** ****;

ods printer printer=png
  file="q:/5507/module03/results/hw-03-q2.png";

**** sas_code_q2        **** **** **** **** ****;

proc means
  nmiss
    data=xfer;
  var
    bodywt
    brainwt
    nondreaming
    dreaming
    totalsleep
    lifespan
	gestation
	predation
	exposure
	danger;
  title1 "Missing value count for all continuous variables";
run;

**** comments_q3         **** **** **** **** ****

  3. Calculate the mean and standard deviation
  for TotalSleep.

**** ignore_this         **** **** **** **** ****;

ods printer printer=png
  file="q:/5507/module03/results/hw-03-q3.png";

**** sas_code_q3        **** **** **** **** ****;

proc means
    mean std data=xfer;
  var totalsleep;
  title1 "Mean and standard deviation for totalsleep";
run;

**** comments_q4a        **** **** **** **** ****

  4. Draw a histogram for the BodyWt variable.
  Note that this variable is highly skewed.
  Re-draw the histogram on the log scale.
  For exta credit, relabel the axes with values
  at 0.001, 0.01, etc.

**** ignore_this         **** **** **** **** ****;

ods printer printer=png
  file="q:/5507/module03/results/hw-03-q4a.png";

**** sas_code_q4a        **** **** **** **** ****;

proc sgplot
    data=xfer;
  histogram bodywt;
  title1 "Histogram of body weight";
run;

**** comments_q4b        **** **** **** **** ****

  There are two ways to get a log scale. The
  approach shown here is simple but does not use
  nice labels on the X axis.

**** ignore_this         **** **** **** **** ****;

ods printer printer=png
  file="q:/5507/module03/results/hw-03-q4b.png";

**** sas_code_q4b        **** **** **** **** ****;

data log_weight;
  set xfer;
  log_w = log10(bodywt);
run;

proc sgplot
    data=log_weight;
  histogram log_w;
  title1 "Histogram of log body weight";
run;

**** comments_q4c        **** **** **** **** ****

  Here's a better way.

**** ignore_this         **** **** **** **** ****;

ods printer printer=png
  file="q:/5507/module03/results/hw-03-q4c.png";

**** sas_code_q4c        **** **** **** **** ****;

proc sgplot
    data=log_weight;
  histogram log_w;
  xaxis
    values=(-3, -2, -1, 0, 1, 2, 3, 4)
    valuesdisplay=("0.001" "0.01" "0.1" "1" "10" "100" "1000" "10000");
  title1 "Histogram of log body weight";
run;

**** comments_q5a        **** **** **** **** ****

  5. Calculate the ratio of BrainWt to BodyWt
  and express it as a percentage. Be sure to
  convert grams to kilograms (or vice versa)
  before computing the ratio. What animal has
  the smallest/largest ratio?

**** ignore_this         **** **** **** **** ****;

ods printer printer=png
  file="q:/5507/module03/results/hw-03-q5a.png";

**** sas_code_q5a        **** **** **** **** ****;

data ratio;
  set xfer;
  brain_body_ratio = 100 * (brainwt/1000) / bodywt;
run;

proc sort
    data=ratio;
  by brain_body_ratio;
run;

proc print
    data=ratio(obs=1);
  title1 "Lowest brain to body ratio";
run;

**** comments_q5b        **** **** **** **** ****

  Use the descending keyword to place the largest
  percentage at the top.
**** ignore_this         **** **** **** **** ****;

ods printer printer=png
  file="q:/5507/module03/results/hw-03-q5b.png";

**** sas_code_q5b        **** **** **** **** ****;

proc sort
    data=ratio;
  by descending brain_body_ratio;
run;

proc print
    data=ratio(obs=1);
  title1 "Highest brain to body ratio";
run;

**** comments_q6         **** **** **** **** ****

  6. Do bigger animals sleep longer or live
  longer? Show your results using a correlation
  coefficient.

**** ignore_this         **** **** **** **** ****;

ods printer printer=png
  file="q:/5507/module03/results/hw-03-q6.png";

**** sas_code_q6         **** **** **** **** ****;

proc corr
    data=xfer;
  var bodywt;
  with totalsleep lifespan;
  title1 "Correlation";
run;

**** comments_q7a        **** **** **** **** ****

7. Do animals who have high degrees of
Predation, Exposure, or Danger sleep less?
Show your results using a plot and a trendline.

**** ignore_this         **** **** **** **** ****;

ods printer printer=png
  file="q:/5507/module03/results/hw-03-q7a.png";

**** sas_code_q7a         **** **** **** **** ****;

proc sgplot
    data=xfer;
  scatter x=totalsleep y=predation;
  reg x=totalsleep y=predation;
  title1 "Scatterplot";
run;

**** end of program      **** **** **** **** ****;
