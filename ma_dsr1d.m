%% read data
[f, spec, params] = eprload('spectra/20181129/1226.DTA');

%% DSR 1D
Y = real(spec);
Y = max(Y) - Y;
Y = Y / max(Y);

plot(f, Y)
xlabel('\nu_{rf} / MHz')
ylabel('signal / a.u.')

print('~/git/uni-writing/res/dressed-spins-epr/ma_dsr1d', '-dpng')