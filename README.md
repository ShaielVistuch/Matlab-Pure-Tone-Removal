# Matlab-Pure-Tone-Removal
Noise frequency detection

Assuming a noise disturbance of cos(w_0*n), we must remove it from the signal, by find the frequency w_0.
We can do that by using the DTFT, which will give us two main impulses, exacly at w_0 and -w_0.
The DTFT is defined by:
$X(e^(jΩ) )=∑x[n]e^(-(jΩn))$
The inverse transform:
$x[n]=1/(2π) ∫_ϵ ^(2π+ϵ) X(e^jΩ)e^(jΩt) dΩ$
