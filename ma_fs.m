%% read data
[B, spec, params] = eprload('spectra/20181129/1113.DTA');

%% field sweep
plot(B, spec)
title('Herasil Fieldsweep')
xlabel('B_0 / G')
ylabel('Signal')