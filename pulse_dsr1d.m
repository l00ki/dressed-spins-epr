tmw  = [0.0 1.0 1.0 2.0 2.0 3.0 3.0 8.0 8.0 9.0];
smw  = [0.0 0.0 0.8 0.8 0.0 0.0 1.0 1.0 0.0 0.0];
trfa = [0.0 1.0 1.0 2.0 2.0 3.5 3.5 5.25 5.25 5.75 5.75 7.75 7.75 9.0];
srfa = [0.0 0.0 0.0 0.0 0.0 0.0 0.5 0.50 0.50 0.50 0.50 0.50 0.00 0.0];

subplot(2, 1, 1)
plot(tmw, smw, 'LineWidth', 5, 'Color', 'red')
ylim([0 1])
axis off
text(-0.5, 0.5, 'mw', 'FontWeight', 'bold', 'FontSize', 32)
text(1.5, 0.5, '\pi/2_{+x/-x}', 'FontWeight', 'bold', 'FontSize', 32, 'Color', 'red', 'HorizontalAlignment', 'center')
text(5.5, 0.5, 'HTA_{+y}', 'FontWeight', 'bold', 'FontSize', 32, 'Color', 'red', 'HorizontalAlignment', 'center')

subplot(2, 1, 2)
plot(trfa, srfa, 'LineWidth', 5, 'Color', 'blue')
ylim([0 1])
axis off
text(-0.5, 0.25, 'rf', 'FontWeight', 'bold', 'FontSize', 32)
text(5.625, 0.25, '+z', 'FontWeight', 'bold', 'FontSize', 32, 'Color', 'blue', 'HorizontalAlignment', 'center')

print('~/git/uni-writing/res/dressed-spins-epr/pulse_dsr1d', '-dpng')