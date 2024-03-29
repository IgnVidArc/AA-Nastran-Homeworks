%% TASK 3: EVOLUTION OF NATURAL FREQUENCIES WITH kCOUPLING:
k1 = 3947.84;
a = [0, .5, 1, 1.5, 2.5, 5, 50, 1000]';
k = a*k1;

% Frequencies obtained from the .f06 solutions of the 103 SOLVER.
freqs = [
9.999998E+00, 2.000000E+01;
1.191159E+01, 2.140359E+01;
1.302775E+01, 2.302775E+01;
1.370649E+01, 2.474130E+01;
1.443788E+01, 2.813445E+01;
1.509916E+01, 3.566532E+01;
1.574009E+01, 1.012534E+02;
1.580783E+01, 4.474930E+02
];

figure(100)
fs = 14;
lw = 1.25;
loglog(a, freqs(:,:), '-s', LineWidth=1.25)
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')
xlim([.5,1000])
legend({'$f_1$', '$f_2$'}, Interpreter="latex", FontSize=fs)
xlabel('Coupling Stiffness Relation, $k_{coupling}/k_1$', Interpreter='latex', FontSize=fs)
ylabel('Modal Frequency (Hz)', Interpreter='latex', FontSize=fs)
grid on; box on


%% Analytical f1
k1 = 3947.84;
k2 = 15791.36;
M1 = 1;
cycles_kinfinity_eig1 = 1/(2*pi) * sqrt((k1+k2)/2*M1);




