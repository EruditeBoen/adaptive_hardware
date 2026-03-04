**What is the purpose of Phase 1, and what kind of mistakes are we explicitly trying to avoid by using only simulators?**



*Phase 1 exists for users to test ideas safely before implementing them in real hardware. By using simulators, we are avoiding debugging confusion, irreversible physical mistakes, and slow iteration cycles*



**What is observed (“y stuck at X/red”), the exact cause, and which fix is best (init vs reset) and why.**



*I observed that the y register was stuck on red. This was because it was never initialized (no set value), and since the negation of a unknown value is still unknown (~X is still X), y stays unknown forever. The fix I chose is to add a reset. This solution is more hardware-like and is key for adaptive logic in the future.*



**Write the Phase 1 research question. Be concrete and testable (something a simulation can falsify).**



Can a finite state machine built with minimal hardware learn from a binary input stream, and can that change be observed and improves prediction accuracy?



**What observable change over time would convince you the block is learning, and what would falsify it?**



*The FSM observes inputs, makes a prediction, then updates itself based on whether it was right or wrong. It sees x\[N], outputs pred\[N] based on current state, then updates its internal state using x\[N]; this is when learning happens. We can then check whether the prediction was right.*



**Write a precise definition of the predictor’s interface: what x means, what pred means, and when learning occurs relative to those signals.**



*The input, x, is the current observed bit, and the output, pred, is the prediction of the next bit. Learning occurs when the hardware updates its internal state based on the current observed input, and correctness is evaluated by comparing past predictions to future inputs.*



**List the exact signals you expect to see in GTKWave for the predictor (inputs, outputs, and internal state).**



*For inputs, there should be the current observed bit, clock, and reset. The outputs should include the prediction of the next bit. The registers inside the DUT are the counter and possibly a registered copy of the previous prediction. Signals that are only available to the observer are correct (whether the hardware made the correct prediction) and error (if the hardware was wrong).*

