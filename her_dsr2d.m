%% read data
[x, spec] = eprload('spectra/20181017/1350.DTA');

%% DSR 2D
bg1 = median(spec, 1);
bg2 = median(spec, 2);

spec = bsxfun(@minus, spec, bg1);
spec = bsxfun(@minus, spec, bg2);

spec = real(spec);

contour(x{1}, x{2}, spec, 5)

print('~/git/uni-writing/res/dressed-spins-epr/her_dsr2d', '-dpng')