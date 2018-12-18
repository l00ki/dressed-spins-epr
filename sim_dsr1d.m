%% parameters
% Hamiltonian
sys = [1/2 1/2]; % spin system
fwhm = 10.000; % line width [MHz]
A = -35.4; % secular HF coupling constant [MHz]
B = -12.8; % pseudosecular HF coupling constant [MHz]
nuI = -8.84 ; % nuclear resonance frequency [MHz]

eta_a = atan(-B/(A+2*nuI));
eta_b = atan(-B/(A-2*nuI));
eta=(eta_a - eta_b)/2;
Ia=cos(eta)^2;

% pulsing
nu1 = 6.8;  % channel 1 power [MHz]
nu2 =  0.2000; % channel 2 power [MHz]
nuRF0 = 0.000; % sweep from this rf frequency [MHz]
nuRF = 10.000; % sweep to this rf frequency [MHz]
tp  = 0.25/nu1; % prep pulse length [us]
tau =  0.6;  % interpulse evolution time [us]
T   =  22 * tp; % HTA pulse + rf irradiation length [us]

% sampling
nRF = 51; % rf frequencies probed
nOffset = 50; % spin packages

%% setup
Sx = sop(sys, 'xe');
Sy = sop(sys, 'ye');
Sz = sop(sys, 'ze');
Ix = sop(sys, 'ex');
Iy = sop(sys, 'ey');
Iz = sop(sys, 'ez');
M  = Sy;

nuOffset = 1.2 * fwhm * linspace(-1.0, 1.0, nOffset)+2;
weights  = gaussian(nuOffset, 0, fwhm);
nuRF = linspace(nuRF0, nuRF, nRF);
signal = zeros(1, nRF);
dT=1e-3;
nT = round(T / dT);

% tic
% parfor iRF = 1 : nRF
%     disp(iRF)
%     for iOffset = 1 : nOffset
%         H0 = nuOffset(iOffset) * Sz + A * Sz * Iz + B * Sz * Ix + nuI * Iz;
%         s = Sz;
%         
%         H1 = H0 + nu1 * Sx;
%         H2 = H0 - nu1 * Sx;
%         U1 = expm(-2i * pi * tp * H1);
%         U2 = expm(-2i * pi * tp * H2);
%         s = (U1 * s * U1' - U2 * s * U2') / 2;
%         
%         H = H0;
%         U = expm(-2i * pi * tau * H);
%         s = U * s * U';
%         
%         t = 0;
%         for iT = 1 : nT
%             H = H0 + nu1 * Sy + 2 * nu2 * cos(2 * pi * nuRF(iRF) * t) * (Sz);
%             U = expm(-2i * pi * H * dT);
%             s = U * s * U';
%             t = t + dT;
%         end
%         
%         H = H0;
%         U = expm(-2i * pi * tau * H);
%         s = U * s * U';
%         
%         signal(iRF) = signal(iRF) + weights(iOffset) * trace(M * s);
%    end
% end
% toc

%% plot
figure(2)
signal = real(signal / max(signal));
plot(nuRF, signal, 'b')
title('Dressed spin EPR spectrum')
xlabel('\nu_{rf} / MHz')
ylabel('normalized signal')
hold on

signal = zeros(1, nRF);

tic
parfor iRF = 1 : nRF
    disp(iRF)
    for iOffset = 1 : nOffset
        H0 = nuOffset(iOffset) * Sz;
        s = Sz;
        
        H1 = H0 + nu1 * Sx;
        H2 = H0 - nu1 * Sx;
        U1 = expm(-2i * pi * tp * H1);
        U2 = expm(-2i * pi * tp * H2);
        s = (U1 * s * U1' - U2 * s * U2') / 2;
        
        H = H0;
        U = expm(-2i * pi * tau * H);
        s = U * s * U';
        
        t = 0;
        for iT = 1 : nT
            H = H0 + nu1 * Sy + 2 * nu2 * cos(2 * pi * nuRF(iRF) * t) * Sz;
            U = expm(-2i * pi * H * dT);
            s = U * s * U';
            t = t + dT;
        end
        
        H = H0;
        U = expm(-2i * pi * tau * H);
        s = U * s * U';
        
        signal(iRF) = signal(iRF) + weights(iOffset) * trace(M * s);
   end
end
toc

%% plot
signal = real(signal / max(signal));
signalsmooth = datasmooth(signal, 10);
plot(nuRF, signalsmooth, 'r')
ylim([0.5 1])

print('~/git/uni-writing/res/dressed-spins-epr/sim_dsr1d', '-dpng')