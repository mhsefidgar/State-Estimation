
 clc
 clear all
 format long 
  %%---- Number of Sub-intervals and Total Time ----%%
 m = input('Enter the number of sub-intervals chosen:\n');
 T = input('Enter the total time period:\n');
 h = T/m;
 t=0:h:T;
 
  %%---- Function to be approximated ----%%
 syms x
 f = sin(pi*x);
 j = 0:0.01:T;
 plot(j,sin(pi*j),'--k','LineWidth',2)    % exact plot
 hold on
  %%---- BPF Based Representation ----%%
 C = zeros(1,m);
 for i=1:m
     C(i)=(m/T)*int(f,t(i),t(i+1)); % BPF Coefficients
 end

Coeff = [C C(m)];      % BPF Coefficients for plotting
  %%---- Function Plotting ----%%
 stairs(t,Coeff,'-k','LineWidth',2)
 ylim([0 1])
  %%---- Calculation of MISE ----%%
 for i=1:m
         Fd =(f-Coeff(i))^2;
         ise(i)=double(int(Fd,t(i),t(i+1)));
 end