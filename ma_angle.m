%% read data
[f00, spec00, params00] = eprload('spectra/20181129/1226');
[f30, spec30, params30] = eprload('spectra/20181129/1236');
[f60, spec60, params60] = eprload('spectra/20181129/1241');
[f90, spec90, params90] = eprload('spectra/20181129/1246');

%% angle dependency
%spec00 = datasmooth(real(spec00), 10);
%spec30 = datasmooth(real(spec30), 10);
%spec60 = datasmooth(real(spec60), 10);
%spec90 = datasmooth(real(spec90), 10);

spec00 = max(spec00) - spec00;
spec30 = max(spec30) - spec30;
spec60 = max(spec60) - spec60;
spec90 = max(spec90) - spec90;

m = max([max(spec00) max(spec30) max(spec60) max(spec90)]);
spec00 = spec00 / m;
spec30 = spec30 / m;
spec60 = spec60 / m;
spec90 = spec90 / m;


hold on

plot(f00, spec00, 'LineWidth', 3)
plot(f30, spec30, 'LineWidth', 3)
plot(f60, spec60, 'LineWidth', 3)
plot(f90, spec90, 'LineWidth', 3)
legend('0 deg', '30 deg', '60 deg', '90 deg')

hold off

print('~/git/uni-writing/res/dressed-spins-epr/ma_angle', '-dpng')