clear;clc;

% Monte Carlo trials
trials=10000;

% pre-definition of crater diameter
D1_result=zeros(trials,1);
D2_result=zeros(trials,1);

% Begin Monte Carlo simulation
for i=1:trials

P = (22 + 8*rand(1)) *1e9; % P = shock pressure (22-30 GPa)
rho_0 = 2656;  % rho_0, initial density of projectile (2656 kg m-3)
rho_t = 3190;    % rho_t, target density (3190 kg m-3)
c0 = 1870;          % c0, Material parameter1 (1870 m/s)
s = 1.48;           % s, Material parameter2 (1.48 a.u.)
t = 0.05+0.023*rand(1);    % t, duration time (0.05-0.073 s)
g = 1.63;                      % g, gravity of the Moon (1.63 m/s2)

f1 = @(rho) P - (rho_0*c0^2*(1-rho_0/rho))/(1-s*(1-rho_0/rho))^2;
rho_initial_guess = 1;
rho = fzero(f1, rho_initial_guess);   % rho, density of the shocked projectile (kg m-3)
cr=sqrt((rho_0*c0^2+(4*s-1)*P)/rho);  % cr, rarefaction wave velocity (m/s)

f2 = @(Vp) rho_0 * Vp * (c0 + s*Vp) - P;
Vp_initial_guess = 1;
Vp = fzero(f2, Vp_initial_guess); % Vp, particle velocity (m/s)
U = c0 + s*Vp;                    % U, shock wave velocity
Vi = Vp*2;                        % Vi, impact velocity (m/s)

L=t/(1/U+(rho_0/rho)*(1/cr));     % L, size of projectile (m)

m = (4/3)*pi*((L/2)^3)*rho_0;     % m, target mass (kg)

% using method of Pang et al. (2016) SR 6: 26063.
D1=1.8*rho_0^0.11*rho_t^(-1/3)*g^(-0.22)*L^0.13*(0.5*Vi^2*m)^0.22;
D1_result(i,:)=D1;             % D1, diameter of crater (m)
 
% using method of Nagaoka et al. (2021) Icarus 370: 114690.
pi_2 = (1.61*g*L)/(Vi^2);      % Independent dimensionless parameter
beta=0.16+(0.22-0.16)*rand(1); % Diameter constants, 0.16-0.22
CD=1.4+0.2*rand(1);            % Diameter constants, 1.4-1.6
pi_D = CD / (pi_2^beta);       % Independent dimensionless parameter
D2 = pi_D / ((rho_t/m)^(1/3)); % D2, diameter of crater (m)
D2_result(i,:)=D2;

end

% Plot the histogram
hold on
H1=histogram(D1_result,20);
H2=histogram(D2_result,20);
xlabel('Crater diameter (m)')
ylabel('Frequency counts')
hLegend=legend([H1,H2],'Pi-scaling relation (Pang et al., 2016)',...
    'Pi-scaling relation (Nagaoka et al., 2021)');

set(hLegend, 'FontName',  'Calibri', 'FontSize', 16)
set(gca, 'FontName', 'Calibri', 'FontSize', 16, ...
         'Box', 'on', ... 
         'XGrid', 'off', 'YGrid', 'off', ... 
         'TickDir', 'out', 'TickLength', [.01 .01])

% Save the figure
figWidth = 700; figHeight = 700; 
set(gcf, 'Position', [100, 100, figWidth, figHeight]);
set(gcf, 'PaperPositionMode', 'auto');
fileout='supp_fig10';
exportgraphics(gcf,[fileout,'.pdf'], 'ContentType', 'vector');
