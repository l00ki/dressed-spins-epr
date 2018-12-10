%% read data
[B, spec, params] = eprload('spectra/20181030/1039.DTA');

%% field sweep
plot(B, spec)
title('Herasil Fieldsweep')
xlabel('B_0 / G')
ylabel('Signal')