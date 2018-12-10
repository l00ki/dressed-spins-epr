% simulate a nutation spectrum

%% parameters
sys  =  [1/2 1/2];
fwhm =  10.000;
A    =   0.000;
B    =   0.000;
nuI  =   0.000;

dt   =   0.005;
nT   =     100;
nS   =     100;

nu1  =  15.000;
nu2  =   1.000;

tp   =   0.005;
tau  =   0.500;
T    =    5000;

%% setup
Sx = sop(sys, 'xe');
Sy = sop(sys, 'ye');
Sz = sop(sys, 'ze');
Ix = sop(sys, 'ex');
Iy = sop(sys, 'ey');
Iz = sop(sys, 'ez');

nuS = fwhm * linspace(-1, 1, nS);
weights = gaussian(nuS, 0, fwhm);
nt = floor(tau * 2 / dt);
signal = zeros(nT, nt);
T = linspace(T / nT, T, nT);

%% simulation
for iT = 1 : nT
    for iS = 1 : nS
        H0 = nuS(iS) * Sz + nuI * Iz + A * Sz * Iz + B * Sz * Ix;
        s = Sz;

        Ha = H0 + nu1 * Sx;
        Ua = expm(-2i * pi * Ha * tp);
        Hb = H0 - nu1 * Sy;
        Ub = expm(-2i * pi * Hb * tp);
        s = (Ua * s * Ua' - Ub * s * Ub') / 2;

        H = H0;
        U = expm(-2i * pi * H * tau);
        s = U * s * U';

        H = H0 + nu1 * Sy;
        U = expm(-2i * pi * H * T(iT));
        s = U * s * U';

        H = H0;
        U = expm(-2i * pi * H * dt);
        for it = 1 : nt
            s = U * s * U';
            signal(iT, it) = signal(iT, it) + weights(iS) * trace(Sy * s);
        end
    end
end

%% processing
signal = real(signal)

%% plotting
plot(T, signal(:, floor(nt/2)))