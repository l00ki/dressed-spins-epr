%% read data
[x, spec] = eprload('spectra/20181024/1400.DTA');

%% DSR 2D
bg1 = median(spec, 1);
bg2 = median(spec, 2);

spec = bsxfun(@minus, spec, bg1);
spec = bsxfun(@minus, spec, bg2);

spec = real(spec);

surface(x{1}, x{2}, spec, 'EdgeColor', 'none')