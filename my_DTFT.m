function [X,omega]=my_DTFT(x,n,Nw)
   n_siz=size(n);
   if n_siz(1)==1
       n=n.';
   end
   x_siz=size(x);
   if x_siz(2)==1
       x=x.';
   end
   if mod(Nw,2)==0
       omega=-Nw/2:1:(Nw/2)-1;
   else
       omega=-(Nw-1)/2:1:(Nw-1)/2;
   end
   omega=omega*2*pi/Nw;
   X=x*exp(-1i*n*omega);
end
