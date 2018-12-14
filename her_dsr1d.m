%% read data
[f, spec, params] = eprload('spectra/20181107/1342.DTA');

%% DSR 1D
Y = real(spec);
%Y = max(Y) - Y;
Y = datasmooth(Y, 3);
Y = Y / max(Y);

plot(f, Y, 'LineWidth', 3)
xlabel('\nu_{rf} / MHz')
ylabel('signal / a.u.')
xlim([30 70])

print('~/git/uni-writing/res/dressed-spins-epr/her_dsr1d', '-dpng')