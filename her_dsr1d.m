%% read data
[f, spec, params] = eprload('spectra/20181121/1403.DTA');

%% DSR 1D
Y = real(spec);
Y = max(Y) - Y;

plot(f, Y)
xlim([5 25])

print('~/git/uni-writing/res/dressed-spins-epr/her_dsr1d', '-dpng')