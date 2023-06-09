%% LQ Discrete
sim('regulator_LQR_discrete.mdl')

% Current
figure(1)
plot(LQR.Time, LQR.Data(:,1), 'LineWidth',2)
hold on
yline(yref(1), 'Color', 'red', 'LineStyle','--', 'LineWidth', 1.5)
grid on
legend('i','i\_ref', 'Location','northeast')
xlabel("Time [s]")
ylabel("Current [A]")
saveas(gcf, 'img/LQR_i.svg', 'svg');

figure(2)
zoomX = [0.059 0.06];
zoomY = [0.25 0.4];
plot(LQR.Time, LQR.Data(:,1),'LineWidth',2)
hold on
yline(yref(1), 'Color', 'red', 'LineStyle','--','LineWidth', 1.5)
xlim(zoomX);
ylim(zoomY);
xlabel("Time [s]")
ylabel("Current [A]")
legend('i','i\_ref', 'Location','southeast')
grid on
saveas(gcf, 'img/LQR_i_zoom.svg', 'svg');

% Velocity
figure(3)
plot(LQR.Time, LQR.Data(:,2), 'LineWidth',2)
hold on
yline(yref(2), 'Color', 'red', 'LineStyle','--', 'LineWidth', 1.5)
grid on
legend('n','n\_ref', 'Location','southeast')
xlabel("Time [s]")
ylabel("Velocity [rad/s]")
ylim([65 105])
saveas(gcf, 'img/LQR_n.svg', 'svg');

figure(4)
zoomX = [0.059 0.06];
zoomY = [99.5 100.5];
plot(LQR.Time, LQR.Data(:,2),'LineWidth',2)
hold on
yline(yref(2), 'Color', 'red', 'LineStyle','--','LineWidth', 1.5)
xlim(zoomX);
ylim(zoomY);
xlabel("Time [s]")
ylabel("Velocity [rad/s]")
legend('n','n\_ref', 'Location','northeast')
grid on
saveas(gcf, 'img/LQR_n_zoom.svg', 'svg');


%% LQ Discrete NO DISTURBANCE

sim('regulator_LQR_discrete.mdl')

% Current
figure(1)
plot(LQR.Time, LQR.Data(:,1), 'LineWidth',2)
hold on
yline(yref(1), 'Color', 'red', 'LineStyle','--', 'LineWidth', 1.5)
grid on
legend('i','i\_ref', 'Location','northeast')
xlabel("Time [s]")
ylabel("Current [A]")
saveas(gcf, 'img/LQR_i_noDist.svg', 'svg');

figure(2)
zoomX = [0.059 0.06];
zoomY = [0.25 0.4];
plot(LQR.Time, LQR.Data(:,1),'LineWidth',2)
hold on
yline(yref(1), 'Color', 'red', 'LineStyle','--','LineWidth', 1.5)
xlim(zoomX);
ylim(zoomY);
xlabel("Time [s]")
ylabel("Current [A]")
legend('i','i\_ref', 'Location','southeast')
grid on
saveas(gcf, 'img/LQR_i_zoom_NoDist.svg', 'svg');

% Velocity
figure(3)
plot(LQR.Time, LQR.Data(:,2), 'LineWidth',2)
hold on
yline(yref(2), 'Color', 'red', 'LineStyle','--', 'LineWidth', 1.5)
grid on
legend('n','n\_ref', 'Location','southeast')
xlabel("Time [s]")
ylabel("Velocity [rad/s]")
ylim([65 105])
saveas(gcf, 'img/LQR_n_NoDist.svg', 'svg');

figure(4)
zoomX = [0.059 0.06];
zoomY = [99.5 100.5];
plot(LQR.Time, LQR.Data(:,2),'LineWidth',2)
hold on
yline(yref(2), 'Color', 'red', 'LineStyle','--','LineWidth', 1.5)
xlim(zoomX);
ylim(zoomY);
xlabel("Time [s]")
ylabel("Velocity [rad/s]")
legend('n','n\_ref', 'Location','northeast')
grid on
saveas(gcf, 'img/LQR_n_zoom_NoDist.svg', 'svg');

%% MPC unconstrained

sim('mpc_unconstrained.slx')
% Current
figure(5)
plot(out.mpc_unconstrained.Time, out.mpc_unconstrained.Data(:,1), 'LineWidth',2)
hold on
yline(yref(1), 'Color', 'red', 'LineStyle','--', 'LineWidth', 1.5)
grid on
legend('i','i\_ref', 'Location','northeast')
xlabel("Time [s]")
ylabel("Current [A]")
saveas(gcf, 'img/LQR_i.svg', 'svg');

