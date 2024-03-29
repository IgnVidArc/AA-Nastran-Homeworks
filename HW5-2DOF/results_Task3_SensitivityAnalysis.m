%% TASK 3: SENSITIVITY ANALYSIS TO dt of 1-cos LOAD
% and comparison to task2 (free masses with no coupling)
dti = [0.01; 0.05; 0.09; 0.1; 0.11; 0.2; 0.3; 1.0]';
Fi = 1./dti;
disp(Fi)
leg_dti = cell(length(dti),1);
for k=1:length(dti)
    leg_dti{k} = ['dt = ', num2str(dti(k),'%.2f'), ' s'];
end
disp(leg_dti)

%% Run if first time

% % Number of deltat to test:
% Ncases = length(dti);
% % Number of timesteps defined in the Nastran Solver:
% NtimeSteps = 1001;
% 
% % Time array:
% TIMES = zeros(Ncases, NtimeSteps+1);
% % Arrays for times Vertical displacements of M1 and M2:
% Z1 = zeros(Ncases, NtimeSteps+1);
% Z2 = zeros(Ncases, NtimeSteps+1);
% LOADS = zeros(Ncases, NtimeSteps+1);    % Loads on M1
% % Displacement of M1 in the NoCoupling Case (to be called '0'):
% Z0 = zeros(Ncases, NtimeSteps+1);
% 
% 
% foldernameCoupling = 'task3_112_sensitivity_analysis/pch_Coupling/';
% foldernameNoCoupling = 'task3_112_sensitivity_analysis/pch_NoCoupling/';
% 
% for k = 1:Ncases
%     %%%% CASE WITH COUPLING: %%%%
%     filename = ['task3_sol112_dt', num2str(k), '.pch'];
%     filedir = [foldernameCoupling, filename];
%     % Displacements of Node 1002 (M1):
%     StartLine = 2019;
%     [times, states] = ReadTranscientResponse(filedir, StartLine, NtimeSteps);
%     TIMES(k,:) = times;
%     Z1(k,:) = states(:,3);
%     % Displacements of Node 1003 (M2):
%     StartLine = 4030;
%     [~    , states] = ReadTranscientResponse(filedir, StartLine, NtimeSteps);
%     Z2(k,:) = states(:,3);
%     % (1-cos) LOAD on mass M1:
%     StartLine = 14085;
%     [~    , loads] = ReadTranscientResponse(filedir, StartLine, NtimeSteps);
%     LOADS(k,:) = loads(:,3);
% 
%     %%%% CASE WITHOUT COUPLING: %%%%
%     filedir = [foldernameNoCoupling, filename];
%     % Displacements of Node 1002 (M0):
%     StartLine = 2019;
%     [times, states] = ReadTranscientResponse(filedir, StartLine, NtimeSteps);
%     Z0(k,:) = states(:,3);
% end
% save('TASK3_SIMULATION_DATA.mat', 'TIMES', "Z0", "Z1", "Z2", "LOADS", "Ncases", ...
%     "NtimeSteps", "-mat")

%% Run if already saved data.
load("TASK3_SIMULATION_DATA.mat") % --> TIMES, Z0, Z1, Z2, LOADS, Ncases, NtimeSteps

%% Calcultaing the maximum amplitude for each dt:
maxZ0 = zeros(Ncases,1);
maxZ1 = zeros(Ncases,1);
maxZ2 = zeros(Ncases,1);
for k=1:Ncases
    maxZ0(k) = max(abs(Z0(k,:)));
    maxZ1(k) = max(abs(Z1(k,:)));
    maxZ2(k) = max(abs(Z2(k,:)));
end

%% FIG (MAYBE JUST FOR US): Load on mass M1:
% figure
% hold on
% for k=1:Ncases
%     plot(TIMES(k,:), LOADS(k,:))
% end
% legend(leg_dti, Interpreter='latex')
% xlim([0,1])

%% FIGS: Temporal responses of each mass:
fs = 14;

figure
hold on
for k=1:Ncases
    plot(TIMES(k,:), 1000*Z0(k,:))
end
title('M0')
legend(leg_dti, Interpreter='latex'); xlim([0,1]); box on
xlabel('Time (s)', Interpreter='latex', FontSize=fs)
ylabel('Displacement (mm)', Interpreter='latex', FontSize=fs)

figure
hold on
for k=1:Ncases
    plot(TIMES(k,:), 1000*Z1(k,:))
end
title('M1')
legend(leg_dti, Interpreter='latex'); xlim([0,1]); box on
xlabel('Time (s)', Interpreter='latex', FontSize=fs)
ylabel('Displacement (mm)', Interpreter='latex', FontSize=fs)

figure
hold on
for k=1:Ncases
    plot(TIMES(k,:), 1000*Z2(k,:))
end
title('M2')
legend(leg_dti, Interpreter='latex'); xlim([0,1]); box on
xlabel('Time (s)', Interpreter='latex', FontSize=fs)
ylabel('Displacement (mm)', Interpreter='latex', FontSize=fs)


%% FIG: (Maximum displacements) vs (dt)
fs = 14;
lw = 1.25;
figure
plot(dti, 1000*maxZ0, '-s', LineWidth=lw)
hold on
plot(dti, 1000*maxZ1, '-s', LineWidth=lw)
plot(dti, 1000*maxZ2, '-s', LineWidth=lw)

legend({'$M_1$ (Free)', '$M_1$', '$M_2$'}, Interpreter='latex', FontSize=fs)
xlabel('dt (s)', Interpreter='latex', FontSize=fs)
ylabel('Maximum displacement (mm)', Interpreter='latex', FontSize=fs)
set(gca, 'Xscale', 'log')
grid on
