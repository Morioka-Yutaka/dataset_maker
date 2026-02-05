/*** HELP START ***//*

Macro:    ds2datalines  
Purpose:  Export a SAS dataset into SAS code that recreates the dataset using  
          ATTRIB + DATALINES. The generated code is written to the output  
          window (PRINT) and can optionally be copied to the clipboard.  

Parameters:  
  inlib         Input library name (default: WORK)  
  inds          Input dataset name  (default: CLASS)  
  outlib        Output library name for the generated DATA step (default: WORK)  
  outds         Output dataset name for the generated DATA step  
                (default: same as INDS)  
  dlm           Delimiter character used in DATALINES and PROC EXPORT  
                (default: @)  
  clipbrd_copy  Copy generated code to clipboard (Y/N, default: N)  

Usage Example:  
  %ds2datalines(  
    inlib=SASHELP,  
    inds=CLASS,  
    outlib=WORK,  
    outds=CLASS,  
    dlm=@,  
    clipbrd_copy=N  
  );

*//*** HELP END ***/

%macro ds2datalines(
inlib=WORK,
inds=CLASS,
outlib=WORK,
outds= ,
dlm=@,
clipbrd_copy=N
);
%let inlib=%upcase(&inlib);
%let inds=%upcase(&inds);
%let clipbrd_copy=%upcase(&clipbrd_copy);
%if %length(&outds)=0 %then %do;
  %let outds = &inds;
%end;
%let workpath = %sysfunc(pathname(WORK));
%put &=workpath;
%let body = %sysfunc(catx(/,&workpath,_body.txt));
filename body "&body";
proc export data=&inlib..&inds.
    outfile=body
    dbms=dlm replace; 
    delimiter="&dlm";  
    putnames=no;
run;
proc sql noprint;
select name 
        , cats('%nrbquote(',catx(" ",name
               ,ifc(^missing(label),cats('label="',label,'"' ),"")
               ,ifc(^missing(format),cats('format=',format ),"")
               ,ifc(^missing(informat),cats('informat=',informat ),"")
               ,cats('length=', ifc(type="char","$","") ,length,"." )

 ),')')
        , varnum 
into: input_list separated by " "
         ,:attrib_list separated by " "
         ,:dummy
from dictionary.columns
where libname="&inlib" and memname="&inds"
order by varnum
;

select compress(memlabel,"'") into: memlabel trimmed
from dictionary.tables
where libname="&inlib" and memname="&inds"
;

quit;
data _null_;
%if &clipbrd_copy =Y %then %do;
file clip ;
%end;
file print ;
if _N_ = 1 then do;
  put "data &outlib..&outds";
  %if %length(&memlabel) > 0  %then %do;
  put "(label='" "&memlabel" "')";
  %end;
  put ";";
  put "attrib";
  put "&attrib_list";
  put ";";
  put 'infile datalines dsd missover dlm=' "'&dlm" "';";
  put "input &input_list. ;";
  put "datalines;";

end;
  infile body lrecl=32767  truncover end=eof;;
  input;
  line = _infile_;
  put line;
if eof then do;
put ";";
put "run;";
end;
run;

%if &clipbrd_copy =Y %then %do;
filename clip clipbrd;
data _null_;
file clip ;
if _N_ = 1 then do;
  put "data &outlib..&outds";
  %if %length(&memlabel) > 0  %then %do;
  put "(label='" "&memlabel" "')";
  %end;
  put ";";
  put "attrib";
  put "&attrib_list";
  put ";";
  put 'infile datalines dsd missover dlm=' "'&dlm" "';";
  put "input &input_list. ;";
  put "datalines;";

end;
  infile body lrecl=32767  truncover end=eof;;
  input;
  line = _infile_;
  put line;
if eof then do;
put ";";
put "run;";
end;
run;

%end;

filename body clear;

%mend ds2datalines;
