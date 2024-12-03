clear;clc;

% This code yields REE contents from partial melts of LMO cumulates
% Input parameters: PCS (the formation of source cumulates after XX PCS solidification of LMO, ranging from 0 to 1)
% F (partial melting degree of LMO cumulates, ranging from 0 to 1 and accepting matrix input).

% Output parameters: mantle_comp (REE compositions of lunar mantle source);
% primary_melt (REE compositions of designative primary melts)

PCS=0.50; % A source region depth of 2.1 GPa (Prissel & Gross 2020) approximately equals to 50% PCS of LMO

% CI chondrite values from McDonough & Sun (1995) CG
CI=[0.237,0.613,0.0928,0.457,0.148,0.0563,0.199,0.0361,0.246,0.0546,0.16,0.0247,0.161,0.0246];

% A LMO bulk composition of TWM in Elardo et al. (2011) GCA
Modal_E11TWM=E11TWM(PCS);
[CS0_E11TWM,CS1_E11TWM,CS3_E11TWM,CS5_E11TWM]=makemantle(PCS,Modal_E11TWM);

% A LMO bulk composition of TWM in Elardo et al. (2011) GCA
Modal_E11LPUM=E11LPUM(PCS);
[CS0_E11LPUM,CS1_E11LPUM,CS3_E11LPUM,CS5_E11LPUM]=makemantle(PCS,Modal_E11LPUM);

mantle_comp=CS3_E11TWM.*CI; % Considering a mantle region with 3% TIRL, following Prissel & Gross (2020)
mantle_norm=Modal_E11TWM;

x=1:1:14;

    % La     Ce      Pr      Nd      Sm      Eu      Gd     Tb      Dy      Ho      Er     Tm      Yb      Lu
KD=[0.00006	0.00004	0.00004	0.00014	0.00020	0.00024	0.00067	0.00106	0.00185	0.00310	0.00490	0.00770	0.01070	0.01680   % Ol
    0.00390	0.00530	0.00711	0.00970	0.01770	0.01695	0.03145	0.04125	0.05230	0.06635	0.08293	0.10319	0.12767	0.15682   % Opx
    0.02750	0.04300	0.06484	0.09650	0.15000	0.15500	0.18500	0.19500	0.21500	0.22227	0.23000	0.23730	0.24500	0.24500   % Cpx
    0.00310	0.00481	0.00771	0.01240	0.02550	0.03690	0.04550	0.06000	0.07250	0.08635	0.10300	0.11793	0.13550	0.15750   % Pgt
    0.00240	0.00190	0.00044	0.00120	0.00170	0.00130	0.00465	0.00820	0.01105	0.01400	0.02450	0.03745	0.05000	0.06500   % Ilm
    0.02617	0.02005	0.01785	0.01574	0.01137	1.32125	0.00726	0.00639	0.00576	0.00519	0.00470	0.00423	0.00382	0.00388   % Pl
    0.00090	0.00030	0.00038	0.00072	0.00105	0.00035	0.00113	0.00030	0.00060	0.00028	0.00062	0.00050	0.00063	0.00057   % Sp
    0.01000	0.02000	0.05000	0.09000	0.22000	0.33000	0.50000	0.78000	1.06000	1.60500	2.15000	3.07500	4.00000	4.00000]; % Grt
% Using coefficients in Fu & Jacobsen (2024) EPSL

F=[0.01,0.02,0.03]; % Partial melting degree of the mantle

% Implement the partial melting calculations
for i=1:length(F)
Result1(i,:)=melt_calc(mantle_comp,KD,F(i),mantle_norm,'equilibrium');
Result2(i,:)=melt_calc(mantle_comp,KD,F(i),mantle_norm,'fractional');
end

% Plot the REE pattern of generated partial melts (optional)

figure;hold on;

C=[0.0471    0.0275    0.5255
   0.2784    0.0118    0.6196
   0.4510         0    0.6588
   0.6118    0.0902    0.6196
   0.7412    0.2157    0.5176
   0.8431    0.3412    0.4196
   0.9294    0.4745    0.3216
   0.9804    0.6235    0.2275
   0.9882    0.7882    0.1451
   0.9373    0.9725    0.1294]; % Color matrix

% Plot the partial melting 
e0=plot(x,mantle_comp./CI,'LineStyle','-','LineWidth',1,'Color','k');

% Equilibrium melts
plot(x,Result1(1,11:24),'LineStyle','--','LineWidth',0.75,'Color',C(1,:))
plot(x,Result1(2,11:24),'LineStyle','--','LineWidth',0.75,'Color',C(3,:))
plot(x,Result1(3,11:24),'LineStyle','--','LineWidth',0.75,'Color',C(5,:))

% Fractional melts
plot(x,Result2(1,11:24),'LineStyle','-','LineWidth',0.75,'Color',C(2,:))
plot(x,Result2(2,11:24),'LineStyle','-','LineWidth',0.75,'Color',C(4,:))
plot(x,Result2(3,11:24),'LineStyle','-','LineWidth',0.75,'Color',C(6,:))

hold off

xlim([0.5 14.5])
ylim([0.008 100])

xticks(x);
xticklabels({'La', 'Ce', 'Pr', 'Nd', 'Sm', 'Eu', 'Gd', 'Tb', 'Dy', ...
    'Ho', 'Er', 'Tm', 'Yb', 'Lu'});
ylabel('Sample / Chondrite')
set(gca, 'Box', 'on', 'YScale', 'log',...    
         'LineWidth', .75, 'FontName', 'Calibri', 'FontSize', 11,... 
         'XGrid', 'off', 'YGrid', 'off', ...  
         'FontName', 'Calibri', 'FontSize', 12,...
         'TickDir', 'out', 'TickLength', [.01 .01])

% Save the variables for running Fig5.m
primary_melt=Result1(1,11:24);
save('fig5_mantle.mat','mantle_comp');
save('fig5_melt.mat','primary_melt');

function [CS,CS_1TIRL,CS_3TIRL,CS_5TIRL]=makemantle(PCS,Modal)
% Calculate the bulk REE compositions of lunar mantle sources
% Input: LMO fractionation degree (PCS) and mineral modal abundance in the source (Modal)
% Output: Bulk REE compositions of solids in the source (CS + n% TIRL)

F=1-PCS;

    % La     Ce      Pr      Nd      Sm      Eu      Gd     Tb      Dy      Ho      Er     Tm      Yb      Lu
KD=[0.00006	0.00004	0.00004	0.00014	0.00020	0.00024	0.00067	0.00106	0.00185	0.00310	0.00490	0.00770	0.01070	0.01680   % Ol
    0.00390	0.00530	0.00711	0.00970	0.01770	0.01695	0.03145	0.04125	0.05230	0.06635	0.08293	0.10319	0.12767	0.15682   % Opx
    0.02750	0.04300	0.06484	0.09650	0.15000	0.15500	0.18500	0.19500	0.21500	0.22227	0.23000	0.23730	0.24500	0.24500   % Cpx
    0.00310	0.00481	0.00771	0.01240	0.02550	0.03690	0.04550	0.06000	0.07250	0.08635	0.10300	0.11793	0.13550	0.15750   % Pgt
    0.00240	0.00190	0.00044	0.00120	0.00170	0.00130	0.00465	0.00820	0.01105	0.01400	0.02450	0.03745	0.05000	0.06500   % Ilm
    0.02617	0.02005	0.01785	0.01574	0.01137	1.32125	0.00726	0.00639	0.00576	0.00519	0.00470	0.00423	0.00382	0.00388   % Pl
    0.00090	0.00030	0.00038	0.00072	0.00105	0.00035	0.00113	0.00030	0.00060	0.00028	0.00062	0.00050	0.00063	0.00057   % Sp
    0.01000	0.02000	0.05000	0.09000	0.22000	0.33000	0.50000	0.78000	1.06000	1.60500	2.15000	3.07500	4.00000	4.00000]; % Grt
% Using coefficients in Fu & Jacobsen (2024) EPSL

% LMO initial REE composition (CI normalized) (Fu & Jacobsen, 2024)
LMO=[2.76	2.78	2.85	2.77	2.76	2.75	2.76	2.73	2.68	2.77	2.75	2.81	2.71	2.78];

D=Modal*KD;

CL=LMO./(F+D.*(1-F)); CS=D.*CL;     % equilibrium crystallization of LMO
% CLf=LMO.*F.^(D-1);    CSf=D.*CLf; % fractional crystallization of LMO

CS_1TIRL=0.99.*CS+0.01.*CL;    % LMO cumulates with 1% TIRL
CS_3TIRL=0.97.*CS+0.03.*CL;    % LMO cumulates with 3% TIRL
CS_5TIRL=0.95.*CS+0.05.*CL;    % LMO cumulates with 5% TIRL

% CSf_1TIRL=0.99.*CSf+0.01.*CLf;
% CSf_3TIRL=0.97.*CSf+0.03.*CLf;
% CSf_5TIRL=0.95.*CSf+0.05.*CLf;
end

function Modal=E11TWM(PCS)
% LMO crystallization model based on TWM composition in 
% Elardo et al. (2011) GCA (Appendix A)
% Input: LMO fractionation degree (PCS)
% Output: Mineral modal abundances in the source

%       PCS     Ol      Opx     Cpx     Pgt     Ilm     Pl      Sp      Grt
Modal0=[0.000	1.000 	0.000 	0.000 	0.000 	0.000 	0.000 	0.000 	0.000 
        0.030	1.000 	0.000 	0.000 	0.000 	0.000 	0.000 	0.000 	0.000 
        0.290	1.000   0.000 	0.000 	0.000 	0.000 	0.000 	0.000 	0.000
        0.410	1.000   0.000 	0.000 	0.000 	0.000 	0.000 	0.000 	0.000
        0.500	0.880 	0.120 	0.000 	0.000 	0.000 	0.000 	0.000 	0.000 
        0.670	0.636 	0.364 	0.000 	0.000 	0.000 	0.000 	0.000 	0.000];
Modal=[interp1(Modal0(:,1),Modal0(:,2),PCS,'linear'),interp1(Modal0(:,1),Modal0(:,3),PCS,'linear'),...
       interp1(Modal0(:,1),Modal0(:,4),PCS,'linear'),interp1(Modal0(:,1),Modal0(:,5),PCS,'linear'),...
       interp1(Modal0(:,1),Modal0(:,6),PCS,'linear'),interp1(Modal0(:,1),Modal0(:,7),PCS,'linear'),...
       interp1(Modal0(:,1),Modal0(:,8),PCS,'linear'),interp1(Modal0(:,1),Modal0(:,9),PCS,'linear')];
Modal=Modal./sum(Modal(:)); % Mineral model abundances in the source regions
end

function Modal=E11LPUM(PCS)
% LMO crystallization model based on LPUM composition in 
% Elardo et al. (2011) GCA (Appendix A)
% Input: LMO fractionation degree (PCS)
% Output: Mineral modal abundances in the source

%       PCS     Ol      Opx     Cpx     Pgt     Ilm     Pl      Sp      Grt
Modal0=[0.000	1.000 	0.000 	0.000 	0.000 	0.000 	0.000 	0.000 	0.000 
        0.240	1.000 	0.000 	0.000 	0.000 	0.000 	0.000 	0.000 	0.000 
        0.300	1.000   0.000 	0.000 	0.000 	0.000 	0.000 	0.000 	0.000
        0.450	1.000   0.000 	0.000 	0.000 	0.000 	0.000 	0.000 	0.000
        0.510	1.000 	0.000	0.000 	0.000 	0.000 	0.000 	0.000 	0.000 
        0.670	0.716 	0.284 	0.000 	0.000 	0.000 	0.000 	0.000 	0.000
        0.800	0.600 	0.400 	0.000 	0.000 	0.000 	0.000 	0.000 	0.000];
Modal=[interp1(Modal0(:,1),Modal0(:,2),PCS,'linear'),interp1(Modal0(:,1),Modal0(:,3),PCS,'linear'),...
       interp1(Modal0(:,1),Modal0(:,4),PCS,'linear'),interp1(Modal0(:,1),Modal0(:,5),PCS,'linear'),...
       interp1(Modal0(:,1),Modal0(:,6),PCS,'linear'),interp1(Modal0(:,1),Modal0(:,7),PCS,'linear'),...
       interp1(Modal0(:,1),Modal0(:,8),PCS,'linear'),interp1(Modal0(:,1),Modal0(:,9),PCS,'linear')];
Modal=Modal./sum(Modal(:)); % Mineral model abundances in the source regions
end