clc
 clear all
 format long
  %%---- Number of Sub-intervals and Total Time ----%%
 m = input('Enter the number of sub-intervals chosen:\n');
 T = input('Enter the total time period:\n');
 h=T/m;
 t=0:h:T;
  %%---- For GBPF based approximation ----%%
  h1= randi([10 20],1,m)/100; % h1 elements must be between 0.1 & 0.2
 %h1=[0.1 0.1 0.12 0.18 0.18 0.12 0.1 0.1];
 T1=sum(h1,2);
 
  %%---- Exact Plot of Function ----%%
 syms x
 f=sin(pi*x);
 j=0:0.001:T;
 plot(j,sin(pi*j),'--k','LineWidth',2) % exact plot
 hold on
 
  %%---- Conventional BPF Based Representation ----%%
 C_BPF=zeros(1,m);
 for i=1:m
          C_BPF(i)=(m/T)*int(f,t(i),t(i+1)); % Coefficients
 end
 Coeff_BPF=[C_BPF C_BPF(m)];
  %%---- Function Plotting ----%%
 stairs(t,Coeff_BPF,'-m','LineWidth',2)
 ylim([0 1])
 
  %%---- Calculation of MISE ----%%
 for i=1:m
           Fd_BPF=(f-Coeff_BPF(i))^2;
           ise_BPF(i)=double(int(Fd_BPF,t(i),t(i+1)));
 end
 
 ise_BPF;
 ISE_BPF=sum(ise_BPF);   % Integral Square Error over m sub-intervals
  MISE_BPF=ISE_BPF/T ;    % MISE
  %%---- GBPF Based Representation ----%%
 C_GBPF=zeros(1,m);
 t1(1)=0;
 
 for i=1:m
          t1(i+1)=t1(i)+h1(i);
 end
 
 t1;
 
 
 for i=1:m
         t_Lower(i)=t1(i);
         t_Upper(i)=t1(i+1);
         T1(i)=h1(i);
         C_GBPF(i)=(1/h1(i))*int(f,x,t_Lower(i),t_Upper(i));% GBPF Coefficients 
 end
 
 Coeff_GBPF=[C_GBPF C_GBPF(m)];
  %%---- Function Plotting ----%%
 hold on
 stairs(t1,Coeff_GBPF,'-b','LineWidth',2)
 Coeff_GBPF;
ylim([0 1.001])
  %%-- Calculation of MISE for GBPF based Approximation --%%
 for i=1:m
         Fd_GBPF=(f-Coeff_GBPF(i))^2;
     ise_GBPF(i)=double(int(Fd_GBPF,x,t_Lower(i),t_Upper(i)));
 end
 
 ise_GBPF;
 ISE_GBPF=sum(ise_GBPF); % Integral Square Error (ISE) ;
 MISE_GBPF=ISE_GBPF/T; % Mean Integral Square Error (MISE);
 