% This code was used to plot Fig. 2a-b in the main text
% This code was originally run using MATLAB R2023b on November 12th, 2024

clear;clc;

% CI chondrite values from McDonough & Sun (1995) CG
CI=[0.237,0.613,0.0928,0.457,0.148,0.0563,0.199,0.0361,0.246,0.0546,0.16,0.0247,0.161,0.0246];

% Import Arguin 002 data
Arguin_Cpx=readmatrix("fig2_data2.xlsx",'Sheet','Arguin_Cpx','Range','B:O'); Arguin_Cpx(1,:)=[];
Arguin_Cpx=Arguin_Cpx./CI; %Arguin_Cpx=fillmissing(Arguin_Cpx,'linear',2);
Arguin_Opx=readmatrix("fig2_data2.xlsx",'Sheet','Arguin_Opx','Range','B:O'); Arguin_Opx(1,:)=[];
Arguin_Opx=Arguin_Opx./CI; %Arguin_Opx=fillmissing(Arguin_Opx,'linear',2);
Arguin_Pl=readmatrix("fig2_data2.xlsx",'Sheet','Arguin_Pl','Range','B:O'); Arguin_Pl(1,:)=[];
Arguin_Pl=Arguin_Pl./CI; %Arguin_Pl=fillmissing(Arguin_Pl,'linear',2);

% Import meteoritic troctolites data
Tro_Cpx=readmatrix("fig2_data2.xlsx",'Sheet','Tro_Cpx','Range','B:O'); Tro_Cpx(1,:)=[];
Tro_Cpx=Tro_Cpx./CI; %Tro_Cpx=fillmissing(Tro_Cpx,'linear',2);
Tro_Opx=readmatrix("fig2_data2.xlsx",'Sheet','Tro_Opx','Range','B:O'); Tro_Opx(1,:)=[];
Tro_Opx=Tro_Opx./CI; %Tro_Opx=fillmissing(Tro_Opx,'linear',2);
Tro_Pl=readmatrix("fig2_data2.xlsx",'Sheet','Tro_Pl','Range','B:O'); Tro_Pl(1,:)=[];
Tro_Pl=Tro_Pl./CI; %Tro_Pl=fillmissing(Tro_Pl,'linear',2);

% Import meteoritic norites data
Nor_Cpx=readmatrix("fig2_data2.xlsx",'Sheet','Nor_Cpx','Range','B:O'); Nor_Cpx(1,:)=[];
Nor_Cpx=Nor_Cpx./CI; %Nor_Cpx=fillmissing(Nor_Cpx,'linear',2);
Nor_Opx=readmatrix("fig2_data2.xlsx",'Sheet','Nor_Opx','Range','B:O'); Nor_Opx(1,:)=[];
Nor_Opx=Nor_Opx./CI; %Nor_Opx=fillmissing(Nor_Opx,'linear',2);
Nor_Pl=readmatrix("fig2_data2.xlsx",'Sheet','Nor_Pl','Range','B:O'); Nor_Pl(1,:)=[];
Nor_Pl=Nor_Pl./CI; %Nor_Pl=fillmissing(Nor_Pl,'linear',2);

% Import Apollo norites data
ANor_Opx=readmatrix("fig2_data2.xlsx",'Sheet','ANor_Opx','Range','B:O'); ANor_Opx(1,:)=[];
ANor_Opx=ANor_Opx./CI; ANor_Opx=fillmissing(ANor_Opx,'linear',2);
ANor_Pl=readmatrix("fig2_data2.xlsx",'Sheet','ANor_Pl','Range','B:O'); ANor_Pl(1,:)=[];
ANor_Pl=ANor_Pl./CI; ANor_Pl=fillmissing(ANor_Pl,'linear',2);

% Import Apollo troctolites data
ATro_Cpx=readmatrix("fig2_data2.xlsx",'Sheet','ATro_Cpx','Range','B:O'); ATro_Cpx(1,:)=[];
ATro_Cpx=ATro_Cpx./CI; ATro_Cpx=fillmissing(ATro_Cpx,'linear',2);
ATro_Opx=readmatrix("fig2_data2.xlsx",'Sheet','ATro_Opx','Range','B:O'); ATro_Opx(1,:)=[];
ATro_Opx=ATro_Opx./CI; ATro_Opx=fillmissing(ATro_Opx,'linear',2);
ATro_Pl=readmatrix("fig2_data2.xlsx",'Sheet','ATro_Pl','Range','B:O'); ATro_Pl(1,:)=[];
ATro_Pl=ATro_Pl./CI; ATro_Pl=fillmissing(ATro_Pl,'linear',2);

tiledlayout(1,3,'TileSpacing','compact','Padding','compact');

%% Plot Fig. 2c in the main text
nexttile;

x=1:1:14;
C1=[0.9765    0.8314    0.1373
    0.9765    0.7294    0.1137
    0.9765    0.6235    0.0902
    0.9765    0.5216    0.0706
    0.9725    0.4196    0.0471
    0.9725    0.3176    0.0235
    0.9725    0.2118         0]; % Color matrix
hold on
p2=fill([1:14, fliplr(1:14)], [max(Nor_Cpx,[],1), fliplr(min(Nor_Cpx,[],1))], [191 212 255]./255, ...
    'FaceAlpha', 1, 'EdgeColor','none');
p3=fill([1:14, fliplr(1:14)], [max(ATro_Cpx,[],1), fliplr(min(ATro_Cpx,[],1))], [255 220 255]./255, ...
    'FaceAlpha', 1, 'EdgeColor','none');
p1=fill([1:14, fliplr(1:14)], [max(Tro_Cpx,[],1), fliplr(min(Tro_Cpx,[],1))], [229 238 255]./255, ...
    'FaceAlpha', 1, 'EdgeColor','none');
p4=fill([1:14, fliplr(1:14)], [1:14, fliplr(1:14)], [222 179 245]./255, ...
    'FaceAlpha', 1, 'EdgeColor','none');

for i=1:height(Arguin_Cpx)
    %plot(x,Arguin_Cpx(i,:),'-o','Color',C1(i,:),'LineWidth',1,'MarkerSize',4,'MarkerFaceColor',C1(i,:))
    plot(x,Arguin_Cpx(i,:),'-','Color',C1(i,:),'LineWidth',1)
end
hold off
xlim([0.5 14.5])
ylim([0.1 1000])
xlabel('Trace elements')
ylabel('Sample / Chondrite');
hLegend = legend([p1,p2,p3,p4], 'Meteoritic troctolites',...
                 'Meteoritic norites',...
                 'Apollo troctolites','Apollo norites',...
                 'Location', 'southeast','NumColumns',1);
set(hLegend,'FontSize',11)
xticks(x);
xticklabels({'La', 'Ce', 'Pr', 'Nd', 'Sm', 'Eu', 'Gd', 'Tb', 'Dy', ...
    'Ho', 'Er', 'Tm', 'Yb', 'Lu'});
set(gca, 'Box', 'on', 'YScale', 'log',... 
         'LineWidth', .75, 'FontName', 'Calibri', 'FontSize', 14,...  
         'XGrid', 'off', 'YGrid', 'off', ...  
         'TickDir', 'out', 'TickLength', [.01 .01])

%% Plot Fig. 2d in the main text
nexttile;

C2=[0.9765    0.8314    0.1373
    0.9765    0.7961    0.1294
    0.9765    0.7647    0.1216
    0.9765    0.7294    0.1137
    0.9765    0.6941    0.1059
    0.9765    0.6588    0.0980
    0.9765    0.6235    0.0902
    0.9765    0.5922    0.0824
    0.9765    0.5569    0.0745
    0.9765    0.5216    0.0706
    0.9725    0.4863    0.0627
    0.9725    0.4510    0.0549
    0.9725    0.4196    0.0471
    0.9725    0.3843    0.0392
    0.9725    0.3490    0.0314
    0.9725    0.3176    0.0235
    0.9725    0.2784    0.0157
    0.9725    0.2471    0.0078
    0.9725    0.2118         0]; % Color matrix

hold on
fill([1:14, fliplr(1:14)], [max(ATro_Opx,[],1), fliplr(min(ATro_Opx,[],1))], [255 220 255]./255, ...
    'FaceAlpha', 1, 'EdgeColor','none');
fill([1:14, fliplr(1:14)], [max(Tro_Opx,[],1), fliplr(min(Tro_Opx,[],1))], [229 238 255]./255, ...
    'FaceAlpha',1, 'EdgeColor','none');
fill([1:14, fliplr(1:14)], [max(Nor_Opx,[],1), fliplr(min(Nor_Opx,[],1))], [191 212 255]./255, ...
    'FaceAlpha', 1, 'EdgeColor','none');
fill([1:14, fliplr(1:14)], [max(ANor_Opx,[],1), fliplr(min(ANor_Opx,[],1))], [222 179 245]./255, ...
    'FaceAlpha', 1, 'EdgeColor','none');
for i=1:height(Arguin_Opx)
    %plot(x,Arguin_Opx(i,:),'-o','Color',C2(i,:),'LineWidth',1,'MarkerSize',4,'MarkerFaceColor',C2(i,:))
    plot(x,Arguin_Opx(i,:),'-','Color',C2(i,:),'LineWidth',1)
end
hold off
xlim([0.5 14.5])
ylim([0.01 100])
xlabel('Trace elements')
xticks(x);
xticklabels({'La', 'Ce', 'Pr', 'Nd', 'Sm', 'Eu', 'Gd', 'Tb', 'Dy', ...
    'Ho', 'Er', 'Tm', 'Yb', 'Lu'});
set(gca, 'Box', 'on', 'YScale', 'log',...                           
         'LineWidth', .75, 'FontName', 'Calibri', 'FontSize', 14,... 
         'XGrid', 'off', 'YGrid', 'off', ...  
         'TickDir', 'out', 'TickLength', [.01 .01])

%% Plot Fig. 2e in the main text
nexttile;

C3=[0.9765    0.8314    0.1373
    0.9765    0.7961    0.1294
    0.9765    0.7569    0.1216
    0.9765    0.7216    0.1137
    0.9765    0.6863    0.1059
    0.9765    0.6510    0.0980
    0.9765    0.6118    0.0902
    0.9765    0.5765    0.0824
    0.9765    0.5412    0.0745
    0.9725    0.5020    0.0627
    0.9725    0.4667    0.0549
    0.9725    0.4314    0.0471
    0.9725    0.3922    0.0392
    0.9725    0.3569    0.0314
    0.9725    0.3216    0.0235
    0.9725    0.2863    0.0157
    0.9725    0.2471    0.0078
    0.9725    0.2118         0]; % Color matrix
hold on
fill([1:14, fliplr(1:14)], [max(Tro_Pl,[],1), fliplr(min(Tro_Pl,[],1))], [229 238 255]./255, ...
    'FaceAlpha', 1, 'EdgeColor','none');
fill([1:14, fliplr(1:14)], [max(ATro_Pl,[],1), fliplr(min(ATro_Pl,[],1))], [255 220 255]./255, ...
    'FaceAlpha', 1, 'EdgeColor','none');
fill([1:14, fliplr(1:14)], [max(Nor_Pl,[],1), fliplr(min(Nor_Pl,[],1))], [191 212 255]./255, ...
    'FaceAlpha', 1, 'EdgeColor','none');
fill([1:14, fliplr(1:14)], [max(ANor_Pl,[],1), fliplr(min(ANor_Pl,[],1))], [222 179 245]./255, ...
    'FaceAlpha', 1, 'EdgeColor','none');
for i=1:height(Arguin_Pl)
    %plot(x,Arguin_Pl(i,:),'-o','Color',C3(i,:),'LineWidth',1,'MarkerSize',4,'MarkerFaceColor',C3(i,:))
    plot(x,Arguin_Pl(i,:),'-','Color',C3(i,:),'LineWidth',1)
end
hold off
xlim([0.5 14.5])
ylim([0.01 500])
xlabel('Trace elements')
xticks(x);
xticklabels({'La', 'Ce', 'Pr', 'Nd', 'Sm', 'Eu', 'Gd', 'Tb', 'Dy', ...
    'Ho', 'Er', 'Tm', 'Yb', 'Lu'});
set(gca, 'Box', 'on', 'YScale', 'log',...                                                 
         'LineWidth', .75, 'FontName', 'Calibri', 'FontSize', 14,...          
         'XGrid', 'off', 'YGrid', 'off', ...                          
         'TickDir', 'out', 'TickLength', [.01 .01])

%% Output the final figure
figureUnits = 'centimeters';
figureHandle = get(groot,'CurrentFigure');
figW = 1200; figH = 400;
set(figureHandle,'PaperUnits',figureUnits);
set(figureHandle,'Position',[80 80 figW figH]);
figureHandle.Renderer='Painters';
fileout = 'fig2cde';
exportgraphics(gcf,[fileout,'.pdf'], 'ContentType', 'vector');