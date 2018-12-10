%% read data
[f, spec, params] = eprload('spectra/20181030/1210.DTA');

%% DSR 1D
Y = real(spec);
Y = abs(Y).^2 / length(Y);

plot(f, Y)
