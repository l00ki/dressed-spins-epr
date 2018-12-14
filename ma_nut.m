%% read data
[t, spec, params] = eprload('spectra/20181129/1147.DTA');

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
Y = Y.^2 / length(spec);
Y = Y / max(Y);

plot(f, Y)
xlabel('\nu_{nut}/ MHz')
ylabel('signal / a.u.')
xlim([0 max(f)])

print('~/git/uni-writing/res/dressed-spins-epr/ma_nut', '-dpng')