# Analysis Scripts for "Humans Use Forward Thinking to Exert Social Control (Na et al., 2020)"


I. SYSTEM REQUIREMENTS AND INSTALLATION GUIDE
--------------------------------------------------
Verify that version 9.5 (R2018b) of the MATLAB Runtime is installed.   
If not, you can run the MATLAB Runtime installer.
To find its location, enter
  
    >>mcrinstaller
      
at the MATLAB prompt.
NOTE: You will need administrator rights to run the MATLAB Runtime installer. 

Alternatively, download and install the Windows version of the MATLAB Runtime for R2018b 
from the following link on the MathWorks website:

    http://www.mathworks.com/products/compiler/mcr/index.html
   
For more information about the MATLAB Runtime and the MATLAB Runtime installer, see 
"Distribute Applications" in the MATLAB Compiler documentation  
in the MathWorks Documentation Center.



II. REPRODUCTION INSTRUCTIONS
------------------------------------------------------
- The symbol(@) indicates that it is reported or graphically showed in the paper

1.Behavioral results (Fig2)	
-----------------------------

	1.1. open "run.m" ("run.m" is at https://github.com/SoojungNa/ug2_analysis_scripts/1.beh)
	
	1.2. update input/output directories (line 17, 23)
		- Input data("beh02_clean.mat") is at https://github.com/SoojungNa/ug2_analysis_scripts/0.data

	1.3. run it.

	1.4. "results.mat" will be generated. This file has the variables as below.
		"ID" - participants' ids
		"Mname"
			- Eight strings represents the labels for each pair of the columns of "M"
			- 'offer': Mean offer throughout 40 trials
			- 'rejR': Mean rejection rate
			- 'rejR_L': Mean rejection rate for low offers ($1-3)
			- 'rejR_M': Mean rejection rate for medium offers ($4-6)
			- 'rejR_H': Mean rejection rate for high offers ($7-9)
			- 'reward': Mean reward
			- 'emo': Mean self-reported emotion ratings
			- 'pc': Self-reported perceived control ratings
		"M" (@)
			- Odd columns are the "In Control" condition.
			- Even columns are the "No Control" condition.
			- The labels for each pair of the columns are in "Mname".
			- Each row matches with each participant in the same order as in "ID".
		"M_mean" (@)
			- Mean of "M" across the participants
		"M_std" (@)
			- Standard deviation for "M" across the participants 
		"stat_ICvNC" (@)
			- statistical testing results to compare b/w IC and NC
			- 'columns': column labels for 'f_var', 'pt_mean', 't_mean_uneqvar'
			- 'rows': row labels for 'f_var', 'pt_mean', 't_mean_uneqvar'			
			- 'f_var': Results of F-test for variance difference
			- 'pt_mean': Results of t-test for mean difference assuming equal variance
			- 't_mean_uneqvar': Results of t-test for mean difference assuming unequal variance
			
	
2.Model fitting (Fig3.b-c, delta in Fig4)
-----------------

	2.1. open nRv_6models_cap2_t20_30trials_IC.m
		This script is used for In Control. See 2.5 for No Control.
	
	2.2. update input/output directories (line 5, 22, 26)
		- Input data("beh02_clean.mat") is at https://github.com/SoojungNa/ug2_analysis_scripts/0.data
	
	2.3. run it.
	
	2.4. "nRv_6models_cap2_t20_30trials_IC.mat" will be generated. Open the file and then you will see:
		
		"Model"
			- The model list
			- MF=model-free; f0=0step; fD=1step; f3=2step; f4=3step; f5=4step
		"BIC" (@)
			- BIC scores for each model (columns; corresponds to "Model") and each particiant (rows)		
		"freeName"
			- parameter names
		"freeID"
			- rows correspond to "Model"
			- columns correspond to "freeName"
			- 1=set free; 0=not used or fixed.		
		"param" (@)
			- parameter estimates
			- rows correspond to participants
			- columns correspond to freeName(parameters)
			- the 3rd dimension correspond to Model
		
	2.5. Use the same codes for No Control after replacing "IC" with "NC" at line 15:18, and 27.
	
3.Parameter recovery (SI) and accuracy (Fig3.d-e)
------------


4.Neural signals for action values (Fig5)
------------

5.Neural signals for norm prediction errors (Fig6)
------------

