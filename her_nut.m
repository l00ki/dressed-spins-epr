%% read data
[t, spec, params] = eprload('spectra/20181121/1046.DTA');

%% time domain
t    = t / 1000;

spec = real(spec);
spec = basecorr(spec, 1, 2);
spec = spec .* apowin('ham+', length(spec));
spec = spec(5:end);
t    = t(5:end);

plot(t, spec)
xlabel('t / ns')

%% frequency domain
fs = 1 / (t(2) - t(1));
f  = (-length(spec)/2 : length(spec)/2-1) * (fs / length(spec));

Y = real(fftshift(fft(spec)));

plot(f, Y)
xlabel('\nu_1/ MHz')
xlim([5 25])

print('~/git/uni-writing/res/dressed-spins-epr/her_nut', '-dpng')