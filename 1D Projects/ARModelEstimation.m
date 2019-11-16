clear
close
clc
% Construct the estimator.
       X = recursiveAR(6); % na=6
       X.EstimationMethod='ForgettingFactor';
%       Options for Estimation X.EstimationMethod='Gradient'

%       'ForgettingFactor' — Algorithm used for parameter estimation
%       'KalmanFilter' — Algorithm used for parameter estimation
%       'NormalizedGradient' — Algorithm used for parameter estimation
%       'Gradient' — Unnormalized gradient algorithm used for parameter estimation

       % Provide initial parameter guesses (optional).
       X.InitialA = [1 -0.6 -0.4 -0.1 0.1 0.1 0.1];
       % Provide variances of initial parameter guesses (optional).
%       X.InitialParameterCovariance = 0.1;
       % Load the estimation data.
       load iddata9 z9;
       % Call the estimator's step command with the output data one piece at a
       % time to update parameters. This illustrates online operation of the
       % estimator.
       for kk=1:numel(z9.y)
           [A,yHat] = step(X,z9.y(kk));
       end
       
       % Take a snapshot of the current model parameters.
       sysX = idpoly(X);
       % Set the sample time of the model snapshot from the data.
       sysX.Ts = z9.Ts;
       % Compare 
       compare(z9,sysX);
 