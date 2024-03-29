# Analysis Scripts for "Humans Use Forward Thinking to Exploit Social Controllability"
Soojung Na, Dongil Chung, Andreas Hula, Ofer Perl, Jennifer Jung, Matthew Heflin, Sylvia Blackmore, Vincenzo G. Fiore, Peter Dayan, and Xiaosi Gu.
eLife2021;10:e64983 DOI: https://doi.org/10.7554/eLife.64983

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
- Group-level tmaps for the fMRI images are available here.

1.Behavioral results (Figure 2)	
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
			
	
2.Model fitting (Figure 3)
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
		
	
3.Parameter recovery and accuracy (Figure 3)
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
	
	3.5. Model recovery: run "run_ic.m" and "run_nc.m" to simulate and estimate the models. Run "results_all.m" for the confusion matrix.


**4. Replication with an online sample (Figure 4)**
---------
See the online sample data (0.data/beh_noFlat_1342.mat). Run the same scripts for the behavioral analysis and modeling.


5.Neural signals for action values (Figure 5)
------------
Group-level contrast images are available at https://identifiers.org/neurovault.collection:6621.
Contact soojung.na@gmail.com for the raw/preprocessed individual fMRI images.

	4.1. event: run "event_v1.m" after updating the directories (line 3, 14, 17, 20)
		This will generate the individual event regressors for individual GLM.
	
	4.2. pmod: run "pmod_v26_f2_nxV.m"  for 2-step and "pmod_v28_f0_normalized.m" for the 0-step model.
		This will generate the individual parametric modulators (values of chosen action) for individual GLM.
	
	4.3. indiv: run "run_UG2_indiv_v26_f2_nxV_2blocks.m" (2-step model) or "run_UG2_indiv_v28_f0_nxV_2blocks" (0-step model) after updating the directories.
		This will generate the individual GLM results on the whole brain.
	
	4.4. group: run "group_v26_f2_nxV_2blocks_both_t1.m" (2-step model) or "group_v28_f0_nxV_2blocks_both_t1.m"
		This will generate the one-sample t-test results for the chosen action value coefficients at the group level.(@)
	
	4.5. roi: run "makeROI_Feng" to creat a vmPFC ROI mask, run "f2_v26.m" and "f0_v28.m" to extract the ROI coefficients. 
		Then run "f2_f0_nxV_2blocks_sem.m" This will generate the roi plot. (@)
		Update the directories in each script before run.



