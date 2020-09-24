* my-first-sas-program.sas
written by Steve Simon;

data simple_example;
 input x y;
 cards;
1 2
2 4
3 6
;
proc print
    data=simple_example(obs=1);
title "First row of data";
run;
