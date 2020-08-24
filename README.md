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

Also, download and install SPM12 at https://www.fil.ion.ucl.ac.uk/spm/software/download/



II. REPRODUCTION INSTRUCTIONS
------------------------------------------------------
- The symbol(@) indicates that it is reported or graphically showed in the paper
- Both the matlab files and the compiled files are available here.
- Expected run time: The longest (Individual GLM on fMRI data & model fitting scripts) are expected to take
	less than 2 days to run. Other scripts will take a couple seconds, minutes, or hours.


1.Behavioral results (Fig.2; Fig.S2)	
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
			- Odd columns are the "Controllable" condition.
			- Even columns are the "Uncontrollable" condition.
			- The labels for each pair of the columns are in "Mname".
			- Each row matches with each participant in the same order as in "ID".
		"M_mean" (@)
			- Mean of "M" across the participants
		"M_std" (@)
			- Standard deviation for "M" across the participants 
		"stat_ICvNC" (@)
			- statistical testing results to compare b/w C (Controllable) and U (Uncontrollable)
			- 'columns': column labels for 'f_var', 'pt_mean', 't_mean_uneqvar'
			- 'rows': row labels for 'f_var', 'pt_mean', 't_mean_uneqvar'			
			- 'f_var': Results of F-test for variance difference
			- 'pt_mean': Results of t-test for mean difference assuming equal variance
			- 't_mean_uneqvar': Results of t-test for mean difference assuming unequal variance
			
	
2.Model fitting (Fig.3b,d,e)
-----------------

	2.1. open "nRv_6models_cap2_t20_30trials_IC.m" (for Controllable; use "~ NC.m" for Uncontrollable)
		(These files are at https://github.com/SoojungNa/ug2_analysis_scripts/2.model)
	
	2.2. update input/output/function directories (line 5, 22, 26)
		- Input data("beh02_clean.mat") is at https://github.com/SoojungNa/ug2_analysis_scripts/0.data
	
	2.3. run it.
	
	2.4. "nRv_6models_cap2_t20_30trials_IC.mat" will be generated. Open the file and you will see:
		
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
		
	
3.Parameter recovery and accuracy (Fig.3c, Fig.S3)
------------
	3.1. run "recover_nRv_f3_cap2_t20_etaf_IC.m" after updating line 6 and 8. ("~ NC.m" for Uncontrollable)
		(These files are at https://github.com/SoojungNa/ug2_analysis_scripts/2.model)
	
	3.2. "recover_nRv_f3_cap2_t20_etaf_IC.mat" will be generated. Open the file and then you will see:
		"param_tru"
			- parameter estimated from the real data
			- this parameter estimates were used to generate a new set of simulated choice data
		"Rsim"
			- Simulated choice data generated assuming "param_tru"
		"param_est"
			- parameter estimates for the simulated data
		"R" and "P"
			- correlation coefficients and p-values between "param_tru" and "param_est"
			
	3.3. run "accuracy.m" after updating line 2.
	
	3.4. It will generate "accuracy.mat" file. in this file:
		"ic" represents Controllable
		"nc" represents Uncontrollable
		"accuracyRate" (@)
			- you can find it under ic or nc
			- it is the matching rates b/w actual data("RESP") and simulated data("Rsim")

4.Replication with an online sample (Fig.4)
------------




4.Neural signals for action values (Fig.5; Table.S1-4)
------------
Group-level contrast images are available at https://identifiers.org/neurovault.collection:6621.
Contact soojung.na@gmail.com for the raw/preprocessed individual fMRI images.

	4.1. event: run "event_v1.m" after updating the directories (line 3, 14, 17, 20)
		This will generate the individual event regressors for individual GLM.
	
	4.2. pmod: run "pmod_v1.m" after updating the directories (line 5, 18, 21, 24, 25, 29)
		This will generate the individual parametric modulators (values of chosen action) for individual GLM.
	
	4.3. indiv: run "run_UG2_indiv_v1_xV.m" after updating the directories (Line 3, 4, 5, 6)
		This will generate the individual GLM results on the whole brain.
	
	4.4. group: run "group_xV_IC_t1.m" for Controllable and group_xV_NC_t1.m for Uncontrollable.
		This will generate the one-sample t-test results for the chosen action value coefficients at the group level.(@)
	
	4.5. roi: run "xV_both_roi_contrast_peak.m" after updating the directories (line 3, 4, 6, 7, 14, 46) 
		This will generate the coefficients at each roi. (@)


5.Neural signals for norm prediction errors (Fig.6; Table.S5-8)
------------
	Same procedure as 4. Use these files instead:
	5.1. "event_v1.m" (same as 4)
	5.2. "pmod_v6.m"
	5.3. "run_UG2_indiv_v6_normPE.m"
	5.4. "group_v6_normPE_IC_t1.m" ("~ NC_t1.m" for Uncontrollable) (@)
	5.5. "normPE_both_roi_contrast_peak.m" (@)


6.Non-social task (Fig.S1)
------------

