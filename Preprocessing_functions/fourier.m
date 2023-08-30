% Group delay

% Generate simulated flow curves x(t) and y(t)
t = ...;  % Time vector for flow curves
x = ...;  % Flow curve x(t)
y = ...;  % Flow curve y(t)

% Compute Fourier transform of x(t)
X = fft(x);

% Compute magnitude of Fourier coefficients
magX = abs(X);

% Compute phase array (group delay)
phaseX = angle(X);
gdX = -gradient(phaseX);

% Calculate TT-F (Energy-weighted sum of harmonic phases)
TTF = sum(magX.^2 .* gdX) / sum(magX.^2);

% Display the calculated TT-F
disp(['Estimated TT-F (Group Delay): ', num2str(TTF)]);