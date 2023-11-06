mu stands for monthly update. it means it should be done like my inexist aunt coming by monthly. 

---

## mu SOP (example of 2311 to 2312)

1) Ready to archive the spreadsheet of the current month:
   - **Make a copy** of the fxR file *fluxRec210104, ss2311* and rename it as *fluxRec210104, ss2311 - ARC*. This should be done before the coming month (i.e., December 2023);
   - for the ARC file, **Select all** in the filter of column AU;
   - for the ARC file, **Delete** any rows if they belongs to the coming month;
2) Ready the spreadsheet for the coming month
   - **Rename** the current file for the next month (i.e., *fluxRec210104, ss2312*);
   - **Rename** the sheet's name for the next month (i.e., *2312*,) (it is at the southwest corner);
   - run the [two functions](https://github.com/treesess/fluxRec/blob/main/mu/Google%20Sheet%20Apps%20Script%20for%20mu.md#clean-up-everything-in-your-sheet) in the Apps Script (i.e., clean all content in current file and update column AU dates for the next month);
   - update the code for the next mu manually (recommended).
3) Keep finishing the spreadsheet for this month (i.e., *fluxRec210104, ss2311 - ARC*) and download it as Excel after done; 
4) For data analysis, see [mea](https://github.com/treesess/fluxRec/tree/main/mea) for codes based on MATLAB.

---

Well, i don't know how i stood such a boring procedure every month. Welcome to automate it. 



