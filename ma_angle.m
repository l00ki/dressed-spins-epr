%% read data
[f00, spec00, params00] = eprload('spectra/20181129/1226');
[f30, spec30, params30] = eprload('spectra/20181129/1236');
[f60, spec60, params60] = eprload('spectra/20181129/1241');
[f90, spec90, params90] = eprload('spectra/20181129/1246');

%% angle dependency
spec00 = datasmooth(real(spec00), 30);
spec30 = datasmooth(real(spec30), 30);
spec60 = datasmooth(real(spec60), 30);
spec90 = datasmooth(real(spec90), 30);

hold on

plot(f00, spec00)
plot(f30, spec30)
plot(f60, spec60)
plot(f90, spec90)
legend('0 deg', '30 deg', '60 deg', '90 deg')

hold off

print('~/git/uni-writing/res/dressed-spins-epr/ma_angle', '-dpng')