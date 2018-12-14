%% read data
[f, spec, params] = eprload('spectra/20181024/1435.DTA');

%% DSR 1D
Y = real(spec);
Y = abs(Y).^2 / length(Y);

plot(f, Y)

print('~/git/uni-writing/res/dressed-spins-epr/gly_dsr1d', '-dpng')