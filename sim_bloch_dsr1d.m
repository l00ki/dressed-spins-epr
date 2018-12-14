close all

sys = 1/2;

nu1 = 10.000;
nuS = 5.000;

dt   = 0.001;
ntp  = 25;
ntau = 150;
nT   = 7000;
nt   = 2 * ntau;
ntot = 1 + ntp + ntau + nT + nt;

t = 0:dt:ntot*dt;
M = zeros(3, ntot);
Mnorm = zeros(3, ntot);

Sx = sop(sys, 'x');
Sy = sop(sys, 'y');
Sz = sop(sys, 'z');

s  = cell(1, ntot);

for ii = 1 : ntot
    s{ii} = zeros(2);
end

s{1} = Sz;
H0 = nuS * Sz;

H = H0 + nu1 * Sx;
U = expm(-2i * pi * H * dt);
for itp = 1 : ntp
    s{1 + itp} = U * s{itp} * U';
end

H = H0;
U = expm(-2i * pi * H * dt);
for itau = 1 : ntau
    s{1 + ntp + itau} = U * s{ntp + itau} * U';   
end

H = nuS * Sz + nu1 * Sy;
U = expm(-2i * pi * H * dt);
for iT = 1 : nT
    s{1 + ntp + ntau + iT} = U * s{ntp + ntau + iT} * U';
end

H = H0;
U = expm(-2i * pi * H * dt);
for it = 1 : nt
    s{1 + ntp + ntau + nT + it} = U * s{ntp + ntau + nT + it} * U';
end

for ii = 1 : ntot
    M(1, ii) = real(trace(Sx * s{ii}));
    M(2, ii) = real(trace(Sy * s{ii}));
    M(3, ii) = real(trace(Sz * s{ii}));
    Mnorm(:, ii) = M(:, ii) / norm(M(:, ii));
end

% % show
% subplot(1, 2, 1)
% plot3(0, 0, 0)
% hold on
% grid on
% xlim([-1 1])
% xlabel('x')
% ylim([-1 1])
% ylabel('y')
% zlim([-1 1])
% zlabel('z')
% 
% subplot(1, 2, 2)
% hold on
% xlim([0 ntot*dt])
% xlabel('t')
% ylim([-1 1])
% ylabel('M_i')
% 
% for ii = 2 : ntot
%     subplot(1, 2, 1)
%     plot3([Mnorm(1, ii) Mnorm(1, ii-1)], [Mnorm(2, ii) Mnorm(2, ii-1)], [Mnorm(3, ii) Mnorm(3, ii-1)], 'LineWidth', 2, 'Color', 'blue')
%     subplot(1, 2, 2)
%     plot([t(ii) t(ii-1)], [M(1, ii) M(1, ii-1)], 'Color', 'red', 'LineWidth', 2)
%     plot([t(ii) t(ii-1)], [M(2, ii) M(2, ii-1)], 'Color', 'green', 'LineWidth', 2)
%     plot([t(ii) t(ii-1)], [M(3, ii) M(3, ii-1)], 'Color', 'blue', 'LineWidth', 2)
%     pause(0.01)
% end

%% plot
plot3(Mnorm(1, :), Mnorm(2, :), Mnorm(3, :), 'LineWidth', 3)
grid on
xlim([-1 1])
xlabel('x')

print('~/git/uni-writing/res/dressed-spins-epr/sim_bloch_dsr1d', '-dpng')