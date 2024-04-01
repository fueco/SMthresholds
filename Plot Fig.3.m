%%%%%Plot SHAP values 
clear all
width = 12;     
height = 12;    
defpos = get(0,'defaultFigurePosition');
set(0,'defaultFigurePosition', [defpos(1) defpos(2) width*100, height*100]);
top_margin=0.005;
left_margin=0.12;
horizontal_margin=0.06;
vertical_margin=0.015;
map_width=0.25;
map_height=0.61;
f=figure;
AI	=0.037892584
LAI	=0.009070203
Sand=	0.008922906
LeafN=	0.006440041
Pfreq=	0.006115148
Rad=	0.0039667
WoodD=	0.003960079
Cfvo=	0.00391594
SLA	=0.003861743
Rplant=	0.003237842
VPD	=0.002745112
y=[AI	LAI	Sand	LeafN	Pfreq	Rad	WoodD	Cfvo	SLA	Rplant	VPD]
subplot('position',[left_margin,1-top_margin-map_height-vertical_margin,map_width,map_height]);
barh(nan(size(y))); 
hold on
y1=fliplr(y);
for ii = 1:11
    barh(ii,y1(ii),0.5,'FaceColor',[30/255,148/255,1],'facealpha',1);
    hold on
end
varname=fliplr({'Aridity Index' 'Leaf Area Index' 'Sand'  'Leaf Nitrogen'  'Precip Frequency' 'Radiation' 'Wood Density'  'Coarse fragments' 'Specific leaf area' 'Hydraulic resistance' 'Vapor pressure deficit'})
yticklabels(varname);ylim([0.5,11.5])
xlabel({'Importance (mean absolute SHAP value)'})
box on;set(gca,'Fontsize',14);
text(0.72,0.135,'R^2 = 0.74','Units','normalized','Fontsize',14,'Fontweight','bold');
text(-0.37,1.02,'a','Units','normalized','Fontsize',22,'Fontweight','bold');

clearvars -except f
%clear all
uiopen('/Volumes/zf2-mac/drivers/liang/yuanzhang code/ensemble/driverensemble11nocrop.csv',1)
uiopen('/Volumes/zf2-mac/drivers/liang/yuanzhang code/ensemble/shapvaluesensemble.csv',1)
top_margin=0.005;
left_margin=0.12;
horizontal_margin=0.06;
vertical_margin=0.015;
map_width=0.25;
map_height=0.16;
subplot('position',[left_margin+map_width+horizontal_margin,1-top_margin-map_height-vertical_margin,0.15,map_height]);
scatter(1./AI,AI1,2,'b.');xlabel({'Aridity Index'});ylabel({'SHAP value'});box on;set(gca,'Fontsize',14);
text(-0.31,1.02,'b','Units','normalized','Fontsize',22,'Fontweight','bold');
xlim([0,20]);ylim([-0.1,0.15])
subplot('position',[left_margin+map_width+horizontal_margin+0.15+0.045,1-top_margin-map_height-vertical_margin,0.15,map_height]);
scatter(LAI,LAI1,2,'b.');xlabel({'Leaf Area Index (m^2/m^2)'});box on;set(gca,'Fontsize',14);
text(-0.26,1.02,'c','Units','normalized','Fontsize',22,'Fontweight','bold');
subplot('position',[left_margin+map_width+horizontal_margin,1-top_margin-map_height*2-vertical_margin*2-0.05,0.15,map_height]);
scatter(Sand,Sand1,2,'b.');xlabel({'Sand (%)'});ylabel({'SHAP value'});box on;set(gca,'Fontsize',14);
text(-0.31,1.02,'d','Units','normalized','Fontsize',22,'Fontweight','bold');
subplot('position',[left_margin+map_width+horizontal_margin+0.15+0.045,1-top_margin-map_height*2-vertical_margin*2-0.05,0.15,map_height]);
scatter(LeafN,LeafN1,2,'b.');xlabel({'Leaf Nitrogen (mg/g)'});box on;set(gca,'Fontsize',14);
text(-0.26,1.02,'e','Units','normalized','Fontsize',22,'Fontweight','bold');

subplot('position',[left_margin+map_width+horizontal_margin,1-top_margin-map_height*3-vertical_margin*3-0.05*2,0.15,map_height]);
scatter(Pfreq,Pfreq1,2,'b.');xlabel({'Precipitation Frequency (days)'});ylabel({'SHAP value'});box on;set(gca,'Fontsize',14);
text(-0.31,1.02,'f','Units','normalized','Fontsize',22,'Fontweight','bold');
subplot('position',[left_margin+map_width+horizontal_margin+0.15+0.045,1-top_margin-map_height*3-vertical_margin*3-0.05*2,0.15,map_height]);
scatter(Rad,Rad1,2,'b.');xlabel({'Radiation (W/m^2)'});box on;set(gca,'Fontsize',14);
text(-0.26,1.02,'g','Units','normalized','Fontsize',22,'Fontweight','bold');

InPath = '/Volumes/zf2-mac/SMAPIB2022/Figures/';cd(InPath);
print(f,'shap','-dpdf','-r600');
   