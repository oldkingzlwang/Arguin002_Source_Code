% This code was used to plot Fig. 2a-b in the main text
% This code was originally run using MATLAB R2023b on November 12th, 2024

clear;clc;
% Import data needed to plot Fig. 2a
data=readmatrix('fig2_data1.xlsx','Sheet','PlPx');
% Import data needed to plot Fig. 2b
data2=readcell('fig2_data1.xlsx','Sheet','Bulk');

% CI chondrite values from McDonough & Sun (1995) CG
CI=[0.237,0.613,0.0928,0.457,0.148,0.0563,0.199,0.0361,0.246,0.0546,0.16,0.0247,0.161,0.0246];

tiledlayout(1,2,'TileSpacing','compact','Padding','compact');

%% Plot Fig. 2a in the main text
nexttile;

hold on
% Define colors
C = [0.0706    0.3294    0.5333
    0.1647    0.5765    0.8314
    0.2392    0.8510    0.8392
    0.6784    0.8510    0.8471];

% Typical Apollo norite data
N_px=data(2:13,6); N_pl=data(2:13,4); 
N=scatter(N_pl, N_px,70, 'filled','square','MarkerFaceColor',C(2,:));

% Typical Apollo gabbronorite data
GN_px=data(14:21,6); GN_pl=data(14:21,4); 
GN=scatter(GN_pl, GN_px,70, 'filled','square','MarkerFaceColor',C(3,:));

% Typical Apollo alkali norite data
AN_px=data(22:39,6); AN_pl=data(22:39,4); 
AN=scatter(AN_pl, AN_px, 70,'filled','square','MarkerFaceColor',C(4,:));

% Mg-suite clasts in meteorites data
MT_px=data(52:56,6); MT_px_err=data(52:56,7);
MT_pl=data(52:56,4); MT_pl_err=data(52:56,5);
errorbar(MT_pl, MT_px, MT_pl_err, MT_pl_err, MT_px_err, MT_px_err, ...
    'LineStyle', 'none', 'Color', 'k','CapSize',0);
MT=scatter(MT_pl, MT_px, 70,'filled','square','MarkerFaceColor',[83 3 237]./255);

% Atypical Apollo-15 Fe-norite data
A15_px=data(40:46,6); A15_px_err=data(40:46,7);
A15_pl=data(40:46,4); A15_pl_err=data(40:46,5);
errorbar(A15_pl, A15_px, A15_pl_err, A15_pl_err, A15_px_err, A15_px_err, ...
    'LineStyle', 'none', 'Color', 'k','CapSize',0);
A15=scatter(A15_pl, A15_px, 70,'filled','diamond','MarkerFaceColor',C(1,:));

% Arguin 002 data
errorbar(data(1,4), data(1,6), data(1,7), data(1,7), data(1,5), data(1,5), ...
    'LineStyle', 'none', 'Color', 'k','CapSize',0);
Arguin=scatter(data(1,4), data(1,6), 120 ,'filled','Marker','h',...
    'MarkerFaceColor',[192 0 255]./255,'MarkerEdgeColor',[112 40 88]./255,'LineWidth',1);

% Define colors
C1 = [0.3137    0.8000    0.4980
      0.4745    0.8039    0.3725
      0.6392    0.8118    0.2510
      0.8000    0.8157    0.1255
      0.9608    0.8196         0];

% Import evolution data from Elardo & Astudillo Manosalva (2023) GCA
elardo=readmatrix('Elardo2023PMELTS.xlsx');
KREEP0=plot(elardo(:,2),elardo(:,3),'Color', C1(1,:), 'LineWidth', 1.5);
KREEP10=plot(elardo(:,5),elardo(:,6),'Color', C1(2,:), 'LineWidth', 1.5);
KREEP15=plot(elardo(:,8),elardo(:,9),'Color', C1(3,:), 'LineWidth', 1.5);
KREEP25=plot(elardo(:,11),elardo(:,12),'Color', C1(4,:), 'LineWidth', 1.5);

% Import evolution data from Prissel & Gross (2020) EPSL
Prissel2020data=[0.944	0.79
0.9428	0.7508
0.9392	0.7181
0.9362  0.6363
0.9343  0.6059
0.9328  0.5741
].*100;
Prissel2020=plot(Prissel2020data(:,1),Prissel2020data(:,2),'Color', C1(5,:), 'LineWidth', 1.5);

hold off

xlabel('Mol % An in plagioclase');
ylabel('Mg# in orthopyroxene');
xlim([75 100])
ylim([50 100])
hLegend = legend([KREEP0,KREEP10,KREEP15,KREEP25,Prissel2020,MT,N,GN,AN,A15,Arguin], ...
                 '0% KREEP (Elardo2023)','10% KREEP (Elardo2023)','15% KREEP (Elardo2023)',...
                 '25% KREEP (Elardo2023)','0% KREEP (Prissel2020)','Mg-suite clasts in meteorites',...
                 'Typical Apollo norite', 'Typical Apollo gabbronorite', 'Typical Apollo alkali norite',...
                 'Atypical Apollo-15 Fe-norite', 'Arguin 002',...
                 'Location', 'northwest');

set(gca, 'Box', 'on', 'LineWidth', .75,... 
         'XGrid', 'off', 'YGrid', 'off', ...   
         'TickDir', 'out', 'TickLength', [.01 .01],...
         'FontName', 'Calibri', 'FontSize', 14)           

set(hLegend, 'FontName',  'Calibri', 'FontSize', 12)

%% Plot Fig. 2b in the main text
nexttile;

% Fig. 2b data preprocessing
REE=data2(54:64,15:28); REE(4,:)=[]; REE(7,:)=[];
REE_L89=data2(37:44,15:28);
Arguin_REE=cell2mat(data2(50:52,15:28));

for i = 1:numel(REE)
    if ismissing(REE{i})
        REE{i} = NaN;
    end
end
for j = 1:numel(REE_L89)
    if ismissing(REE_L89{j})
        REE_L89{j} = NaN;
    end
end
REE = cell2mat(REE);
REE_L89 = cell2mat(REE_L89);
REE_Norm=REE./CI;
REE_L89_Norm=REE_L89./CI;
Tiji_REE_Norm=Arguin_REE./CI;
x=1:1:14;

for i=1:height(REE_Norm)
    y_filled(i,:) = fillmissing(REE_Norm(i,:), 'linear');
end

for i=1:height(REE_L89_Norm)
    REE_L89_Norm2(i,:) = fillmissing(REE_L89_Norm(i,:), 'linear');
end

hold on

x_fill = [x, fliplr(x)];

y_fill = [y_filled(8,:), fliplr(y_filled(7,:))];
fill(x_fill, y_fill, [253 242 253]./255, 'FaceAlpha', 1, 'EdgeColor','none'); % Typical Apollo alkali norite

y_fill = [y_filled(5,:), fliplr(y_filled(4,:))];
fill(x_fill, y_fill, [255 243 229]./255, 'FaceAlpha', 1, 'EdgeColor','none'); % Typical Apollo gabbronorite

y_fill = [y_filled(2,:), fliplr(y_filled(1,:))];
fill(x_fill, y_fill, [230 244 255]./255, 'FaceAlpha', 1, 'EdgeColor','none'); % Typical Apollo norite

% Plot the average data of typical Apollo Mg-suite rocks
GNavg=plot(x,y_filled(6,:),'--','LineWidth', 1, 'Color', [255 140 0]./255);
Navg=plot(x,y_filled(3,:),'--','LineWidth', 1, 'Color', [47 112 178]./255);
ANavg=plot(x,y_filled(9,:),'--','LineWidth', 1, 'Color', [238 128 238]./255);

% Plot the data of atypical Apollo-15 Fe-norite
h=plot(x,REE_L89_Norm2,'Color',[0 0 0]./255,'LineStyle',':','LineWidth',0.75);

% Plot the data of Arguin 002
hArguin=plot(x, Tiji_REE_Norm, '-', 'Color', [82 0 109]./255, 'LineWidth', 1.5);

hold off

hLegend3 = legend([Navg,GNavg,ANavg,h(1),hArguin(1)], ...
                 'Typical Apollo norite', 'Typical Apollo gabbronorite', ...
                 'Typical Apollo alkali norite','Atypical Apollo-15 Fe-norite','Arguin 002',...
                 'Location', 'northeast');
set(hLegend3, 'FontName',  'Calibri', 'FontSize', 12)

xlim([0.5 14.5])
ylim([1 10000])
xlabel('Trace elements')
ylabel('Sample / Chondrite');
xticks(x);
xticklabels({'La', 'Ce', 'Pr', 'Nd', 'Sm', 'Eu', 'Gd', 'Tb', 'Dy', ...
    'Ho', 'Er', 'Tm', 'Yb', 'Lu'});
set(gca, 'YScale', 'log','Box', 'on',  'LineWidth', .75,...
         'XGrid', 'off', 'YGrid', 'off', ... 
         'TickDir', 'out', 'TickLength', [.01 .01],...
         'FontName', 'Calibri', 'FontSize', 14)

%% Output the final figure
figWidth = 1200; figHeight = 600;
set(gcf, 'Position', [100, 100, figWidth, figHeight]);
set(gcf, 'PaperPositionMode', 'auto');
fileout='fig2ab';
exportgraphics(gcf,[fileout,'.pdf'], 'ContentType', 'vector');