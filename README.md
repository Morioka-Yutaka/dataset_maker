# dataset_maker
The dataset_maker package is intended to consolidate functions related to generating SAS datasets. As its first feature, the ds2datalines macro converts a SAS dataset back into dataset creation code.　　

<img width="360" height="360" alt="dataset_maker_small" src="https://github.com/user-attachments/assets/edf31be4-2dda-47bb-b1ac-072f05319ff1" />　　

## `%ds2datalines()` macro <a name="ds2datalines-macro-1"></a> ######

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

  
---
