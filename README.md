# Matlab-Pure-Tone-Removal
Signal and systems noise detection and removal project. In collaboration with Noa Reina.
<br /><br />
Assuming a noise disturbance of cos(w_0*n), we must remove it from the signal, by finding the frequency w_0.
We can do that by using the DTFT, which will give us two main impulses, exacly at w_0 and -w_0.
<br />
![image](https://github.com/user-attachments/assets/0b4eceef-764a-4831-bf62-61b7a61a4b40)
So, after obtaining the DTFT, we can find w_0 using the code:
<br /><br />
[M,I] = max(X); %determines where the upside down picks are<br />
% M is the X-omega value at the upside down pick<br />
% I is the index of M place in the vector X<br />
w0 = omega(I); 
<br /><br />
Then, we made three different filters to remove noise using the w_0 frequency. 

