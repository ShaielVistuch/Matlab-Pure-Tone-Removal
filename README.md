# Matlab-Pure-Tone-Removal
Noise frequency detection.
<br /><br />
Assuming a noise disturbance of cos(w_0*n), we must remove it from the signal, by find the frequency w_0.
We can do that by using the DTFT, which will give us two main impulses, exacly at w_0 and -w_0.
So, after obtaining the DTFT, we can find w0 using the code:
<br /><br />
[M,I] = max(X); %determines where the upside down picks are<br />
% M is the X-omega value at the upside down pick<br />
% I is the index of M place in the vector X<br />
w0 = omega(I); 
<br /><br />
Then, we made three different filters to remove the w0 frequency. 
In collaboration with Noa Reina.
