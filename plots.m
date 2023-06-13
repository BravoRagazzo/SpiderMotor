%% LQ Discrete
close all
sim('regulator_LQR_discrete_COMPARISON.mdl')

% Current
figure(1)
stairs(out.LQR.Time, out.LQR.Data(:,1), 'LineWidth',2,'Color','#2525f7')
hold on
stairs(out.LQR.Time, out.LQR.Data(:,3), 'LineWidth',2,'Color','#04b50f')
hold on
stairs(out.LQR.Time, out.LQR.Data(:,5), 'LineWidth',2,'Color','#e805e8')
hold on
stairs(out.LQR.Time, out.LQR.Data(:,7), 'LineWidth',2,'Color','#04addb')
hold on
yline(yref(1), 'Color', 'red', 'LineStyle','--', 'LineWidth', 1.5)
grid on
legend('Q=I_2 R=1','Q=10*I_2 R=1','Q=1000*I_2 R=1','Q=I_2 R=100','i\_ref', 'Location','northeast')
xlabel("Time [s]")
ylabel("Current [A]")
saveas(gcf, 'img/LQR_QR/dist/LQR_i_QR.svg', 'svg');

figure(2)
zoomX = [0.059 0.06];
zoomY = [0.26 0.45];
stairs(out.LQR.Time, out.LQR.Data(:,1),'LineWidth',2,'Color','#2525f7')
hold on
stairs(out.LQR.Time, out.LQR.Data(:,3), 'LineWidth',2,'Color','#04b50f')
hold on
stairs(out.LQR.Time, out.LQR.Data(:,5), 'LineWidth',2,'Color','#e805e8')
hold on
stairs(out.LQR.Time, out.LQR.Data(:,7), 'LineWidth',2,'Color','#04addb')
hold on
yline(yref(1), 'Color', 'red', 'LineStyle','--','LineWidth', 1.5)
xlim(zoomX);
ylim(zoomY);
xlabel("Time [s]")
ylabel("Current [A]")
legend('Q=I_2 R=1','Q=10*I_2 R=1','Q=1000*I_2 R=1','Q=I_2 R=100','i\_ref', 'Location','northeast')
grid on
saveas(gcf, 'img/LQR_QR/dist/LQR_i_QR_zoom.svg', 'svg');

% Velocity
figure(3)
stairs(out.LQR.Time, out.LQR.Data(:,2), 'LineWidth',2,'Color','#2525f7')
hold on
stairs(out.LQR.Time, out.LQR.Data(:,4), 'LineWidth',2,'Color','#04b50f')
hold on
stairs(out.LQR.Time, out.LQR.Data(:,6), 'LineWidth',2,'Color','#e805e8')
hold on
stairs(out.LQR.Time, out.LQR.Data(:,8), 'LineWidth',2,'Color','#04addb')
hold on
yline(yref(2), 'Color', 'red', 'LineStyle','--', 'LineWidth', 1.5)
grid on
legend('Q=I_2 R=1','Q=10*I_2 R=1','Q=1000*I_2 R=1','Q=I_2 R=100','n\_ref', 'Location','southeast')
xlabel("Time [s]")
ylabel("Velocity [rad/s]")
ylim([65 105])
saveas(gcf, 'img/LQR_QR/dist/LQR_n_QR.svg', 'svg');

figure(4)
zoomX = [0.059 0.06];
zoomY = [99.5 100.5];
stairs(out.LQR.Time, out.LQR.Data(:,2),'LineWidth',2,'Color','#2525f7')
hold on
stairs(out.LQR.Time, out.LQR.Data(:,4), 'LineWidth',2,'Color','#04b50f')
hold on
stairs(out.LQR.Time, out.LQR.Data(:,6), 'LineWidth',2,'Color','#e805e8')
hold on
stairs(out.LQR.Time, out.LQR.Data(:,8), 'LineWidth',2,'Color','#04addb')
hold on
yline(yref(2), 'Color', 'red', 'LineStyle','--','LineWidth', 1.5)
xlim(zoomX);
ylim(zoomY);
xlabel("Time [s]")
ylabel("Velocity [rad/s]")
legend('Q=I_2 R=1','Q=10*I_2 R=1','Q=1000*I_2 R=1','Q=I_2 R=100','n\_ref', 'Location','northeast')
grid on
saveas(gcf, 'img/LQR_QR/dist/LQR_n_QR_zoom.svg', 'svg');


figure(5)
stairs(out.controlLQR.Time, out.controlLQR.Data(:,1), 'LineWidth',2,'Color','#2525f7')
hold on
stairs(out.controlLQR.Time, out.controlLQR.Data(:,2), 'LineWidth',2,'Color','#04b50f')
hold on
stairs(out.controlLQR.Time, out.controlLQR.Data(:,3), 'LineWidth',2,'Color','#e805e8')
hold on
stairs(out.controlLQR.Time, out.controlLQR.Data(:,4), 'LineWidth',2,'Color','#04addb')
grid on
legend('Q=I_2 R=1','Q=10*I_2 R=1','Q=1000*I_2 R=1','Q=I_2 R=100', 'Location','northeast')
xlabel("Time [s]")
ylabel("Voltage [V]")
saveas(gcf, 'img/LQR_QR/dist/LQR_controls.svg', 'svg');

%% MPC unconstrained vs LQR
close all
sim('LQR_MPC_comparison.slx')

% Current
figure(6)
stairs(out.comparison_LQR_MPC.Time, out.comparison_LQR_MPC.Data(:,1), 'LineWidth',2,'Color','#e805e8')
hold on
stairs(out.comparison_LQR_MPC.Time, out.comparison_LQR_MPC.Data(:,3), 'LineWidth',2,'Color','#2525f7')
hold on
yline(yref(1), 'Color', 'red', 'LineStyle','--', 'LineWidth', 1.5)
grid on
legend('i_{LQR}','i_{MPC}','i\_ref', 'Location','northeast')
xlabel("Time [s]")
ylabel("Current [A]")
saveas(gcf, 'img/MPC/MPC_LQR_comparison_current.svg', 'svg');

% Velocity
figure(7)
stairs(out.comparison_LQR_MPC.Time, out.comparison_LQR_MPC.Data(:,2), 'LineWidth',2,'Color','#e805e8')
hold on
stairs(out.comparison_LQR_MPC.Time, out.comparison_LQR_MPC.Data(:,4), 'LineWidth',2,'Color','#2525f7')
hold on
yline(yref(2), 'Color', 'red', 'LineStyle','--', 'LineWidth', 1.5)
grid on
legend('v_{LQR}','v_{MPC}','v\_ref', 'Location','southeast')
ylim([69 105]);
xlabel("Time [s]")
ylabel("Velocity [rad/s]")
saveas(gcf, 'img/MPC/MPC_LQR_comparison_velocity.svg', 'svg');

%% MPC unconstrained vs MPC all constraints
close all
sim('mpc_all_constraints_vs_unconstrained.slx')

% Current
figure(6)
stairs(out.constr_unconstr.Time, out.constr_unconstr.Data(:,1), 'LineWidth',2,'Color','#e805e8')
hold on
stairs(out.constr_unconstr.Time, out.constr_unconstr.Data(:,3), 'LineWidth',2,'Color','#2525f7')
hold on
yline(yref(1), 'Color', 'red', 'LineStyle','--', 'LineWidth', 1.5)
grid on
legend('i_{allConstr}','i_{unconstr}','i\_ref', 'Location','northeast')
xlabel("Time [s]")
ylabel("Current [A]")
saveas(gcf, 'img/MPC/allConstraintsVSunconstrained/MPC_allConstr_VS_unconstr_current.svg', 'svg');

% Velocity
figure(7)
stairs(out.constr_unconstr.Time, out.constr_unconstr.Data(:,2), 'LineWidth',2,'Color','#e805e8')
hold on
stairs(out.constr_unconstr.Time, out.constr_unconstr.Data(:,4), 'LineWidth',2,'Color','#2525f7')
hold on
yline(yref(2), 'Color', 'red', 'LineStyle','--', 'LineWidth', 1.5)
grid on
legend('n_{allConstr}','n_{unconstr}','n\_ref', 'Location','southeast')
ylim([69 105]);
xlabel("Time [s]")
ylabel("Velocity [rad/s]")
saveas(gcf, 'img/MPC/allConstraintsVSunconstrained/MPC_allConstr_VS_unconstr_velocity.svg', 'svg');

%% MPC control constraint comparison N
close all
sim('mpc_control_constraints_N.slx')

% Current comparison with different horizons
figure(8)
stairs(out.MPC_N5.Time, out.MPC_N5.Data(:,1), 'LineWidth',2,'Color','#e805e8')
hold on
stairs(out.MPC_N100.Time, out.MPC_N100.Data(:,1), 'LineWidth',2,'Color','#2525f7')
hold on
yline(yref(1), 'Color', 'red', 'LineStyle','--', 'LineWidth', 1.5)
grid on
legend('N=5','N=100', 'i\_ref', 'Location','northeast')
xlabel("Time [s]")
ylabel("Current [A]")
saveas(gcf, 'img/MPC/controlConstraints/MPC_N_comparison_current.svg', 'svg');

% Velocity comparison with different horizons
figure(9)
stairs(out.MPC_N5.Time, out.MPC_N5.Data(:,2), 'LineWidth',2,'Color','#e805e8')
hold on
stairs(out.MPC_N100.Time, out.MPC_N100.Data(:,2), 'LineWidth',2,'Color','#2525f7')
hold on
yline(yref(2), 'Color', 'red', 'LineStyle','--', 'LineWidth', 1.5)
grid on
legend('N=5','N=100','n\_ref', 'Location','southeast')
xlabel("Time [s]")
ylabel("Velocity [rad/s]")
saveas(gcf, 'img/MPC/controlConstraints/MPC_N_comparison_velocity.svg', 'svg');

%% MPC control constraints comparison with different Q
close all
sim('mpc_control_constraints_Q.slx')

% Current comparison with Q = [0.001 0; 0 0.001], Q = [1 0; 0 1], Q = [1000 0; 0 1000]
figure(9)
stairs(out.MPC_Q1.Time, out.MPC_Q1.Data(:,1), 'LineWidth',2,'Color','#e805e8')
hold on
stairs(out.MPC_Q2.Time, out.MPC_Q2.Data(:,1), 'LineWidth',2,'Color','#04addb')
hold on
stairs(out.MPC_Q3.Time, out.MPC_Q3.Data(:,1), 'LineWidth',2,'Color','#2525f7')
hold on
yline(yref(1), 'Color', 'red', 'LineStyle','--', 'LineWidth', 1.5)
grid on
legend('Q=0.001','Q=1','Q=1000', 'Location','northeast')
xlabel("Time [s]")
ylabel("Current [A]")
saveas(gcf, 'img/MPC/controlConstraints/MPC_Q_comparison_current.svg', 'svg');

% Velocity comparison with Q = [0.001 0; 0 0.001], Q = [1 0; 0 1], Q = [1000 0; 0 1000]
figure(10)
stairs(out.MPC_Q1.Time, out.MPC_Q1.Data(:,2), 'LineWidth',2,'Color','#e805e8')
hold on
stairs(out.MPC_Q2.Time, out.MPC_Q2.Data(:,2), 'LineWidth',2,'Color','#04addb')
hold on
stairs(out.MPC_Q3.Time, out.MPC_Q3.Data(:,2), 'LineWidth',2,'Color','#2525f7')
hold on
yline(yref(2), 'Color', 'red', 'LineStyle','--', 'LineWidth', 1.5)
grid on
ylim([69 105])
legend('Q=0.001','Q=1','Q=1000', 'Location','southeast')
xlabel("Time [s]")
ylabel("Velocity [rad/s]")
saveas(gcf, 'img/MPC/controlConstraints/MPC_Q_comparison_velocity.svg', 'svg');


