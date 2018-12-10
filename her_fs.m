%% read data
[B, spec, params] = eprload('spectra/20181121/1023.DTA');

%% field sweep
plot(B, spec)
title('Herasil Fieldsweep')
xlabel('B_0 / G')
ylabel('Signal')