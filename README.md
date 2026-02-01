# dataset_maker
The dataset_maker package is intended to consolidate functions related to generating SAS datasets. As its first feature, the ds2datalines macro converts a SAS dataset back into dataset creation code.　　

<img width="360" height="360" alt="dataset_maker_small" src="https://github.com/user-attachments/assets/edf31be4-2dda-47bb-b1ac-072f05319ff1" />　　

## `%ds2datalines()` macro <a name="ds2datalines-macro-1"></a> ######
  
Purpose:  Export a SAS dataset into SAS code that recreates the dataset using  
          ATTRIB + DATALINES. The generated code is written to the output  
          window (PRINT) and can optionally be copied to the clipboard.  

### Parameters:  
~~~text
  inlib         Input library name (default: WORK)  
  inds          Input dataset name  (default: CLASS)  
  outlib        Output library name for the generated DATA step (default: WORK)  
  outds         Output dataset name for the generated DATA step  
                (default: same as INDS)  
  dlm           Delimiter character used in DATALINES and PROC EXPORT  
                (default: @)  
  clipbrd_copy  Copy generated code to clipboard (Y/N, default: N)  
~~~
### Usage Example:  
~~~sas
  %ds2datalines(  
    inlib=SASHELP,  
    inds=CLASS,  
    outlib=WORK,  
    outds=CLASS,  
    dlm=@,  
    clipbrd_copy=N  
  );
~~~
<img width="299" height="179" alt="image" src="https://github.com/user-attachments/assets/57f96968-4f75-46c7-972f-f89f92c7893e" />  　

⇩　　　

<img width="496" height="456" alt="image" src="https://github.com/user-attachments/assets/8565625d-5527-4770-9da2-ec4943970534" />　　



---
