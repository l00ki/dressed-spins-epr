%% read data
[t, spec, params] = eprload('spectra/20181107/1034.DTA');

%% time domain
t    = t / 1000;

spec = real(spec);
spec = basecorr(spec, 1, 2);
spec = spec .* apowin('ham+', length(spec));
spec = spec(3:end);
t    = t(3:end);

plot(t, spec)
xlabel('t / ns')

%% frequency domain
fs = 1 / (t(2) - t(1));
f  = (-length(spec)/2 : length(spec)/2-1) * (fs / length(spec));

Y = real(fftshift(fft(spec)));
Y = Y / max(Y);

plot(f, Y, 'LineWidth', 1)
xlabel('\nu_{nut}/ MHz')
ylabel('signal / a.u.')
xlim([30 70])

print('~/git/uni-writing/res/dressed-spins-epr/her_nut', '-dpng')