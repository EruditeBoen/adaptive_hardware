**What is your hypothesis about when your adaptive predictor will outperform:**



**1. Static prediction**



**2. Last-value prediction**



*Under shifting bias (e.g., long run of 0s followed by 1s), the adaptive predictor significantly outperforms static policies. This is because static prediction always predicts only a 0 or 1. Last-value prediction already adapts instantly to shifts after a single misprediction. So an adaptive design must justify itself beyond that.*



<b>What variable are you isolating in this experiment, and what variables must remain controlled?</b>



*What is changing is the prediction mechanism. The input sequency, simulation length, and scoring rules remain the same.*



**For each of the three workloads, write one sentence predicting which predictor will win and why.**



***Stationary 80% zeros***<i>: Static-0 predictor would win because it is immediatly correct 80% of the time due to the pattern being 80% zeros. However, it could tie with last value because it becaumes 0 one cycle later without having a confidence shift. </i>



<i>**Regime shift**: 2bit predictor wins because it takes 1 mistake to weaken and 1 more mistake to flip, so a bit change for one pos edge would not faze this predictor.</i>



<i>**Oscillatory**: If the pattern is one 1 then one 0, then last value would be 0% accuracy, however for higher order oscillatory patterns, last-value would win because it would adapt immediatly on next cycle to constant ones, then constant zeros and so forth.</i>



<b>“What result would surprise me the most?”</b>



*It would be surprising if accuracy varies significantly between repeated seeds for the same workload and same predictor.*



<b>Accuracies:</b>



***Stationary**:* 

	*Static: ~81%*

	*Last-Value: ~71%*

	*2-bit: ~77%*



***Regime shift**:*

	*Static:	~50%*

	*Last-Value: ~71%*

	*2-bit: ~78%*



***Oscillatory**:*

	*Static: exactly 50%*

	*Last-Value: ~60%*

	*2-bit: ~60%*



<b>Write 3 short bullets summarizing key findings from your table, including where adaptive shines and where it fails.</b>



* *Adaptive wins for unpredictable regime shifts* 
* *Adaptive and last-value nearly tie for higher order oscillatory patterns* 
* *Adaptive loses for lower order oscillatory patterns*

