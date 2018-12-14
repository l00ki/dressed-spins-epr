%% read data
[x, spec] = eprload('spectra/20181205/1159.DTA');

%% DSR 2D
bg1 = median(spec, 1);
bg2 = median(spec, 2);

for ii = 1 : length(spec)
    spec(ii, :) - bg1;
    spec(:, ii) - bg2;
end

spec = real(spec);
spec = datasmooth(spec, 10);

contour(x{1}, x{2}, spec, 3)
xlabel('\nu_1 / MHz')
ylabel('\nu_2 / MHz')

print('~/git/uni-writing/res/dressed-spins-epr/ma_dsr2d', '-dpng')