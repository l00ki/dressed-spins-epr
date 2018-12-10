%% read data
[t, spec, params] = eprload('spectra/20181129/1128.DTA');

%% time domain
t    = t / 1000;

spec = real(spec);
spec = basecorr(spec, 1, 2);
spec = spec .* apowin('ham+', length(spec));

plot(t, spec)
xlabel('t / ns')

%% frequency domain
fs = 1 / (t(2) - t(1));
f  = (-length(spec)/2 : length(spec)/2-1) * (fs / length(spec));

Y = fftshift(fft(spec));
Y = abs(Y).^2 / length(spec);
Y = Y / max(Y);

plot(f, Y)
xlabel('\nu_1/ MHz')
xlim([0 max(f)])