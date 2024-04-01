%%%Plot Fig.2_SM threshold
clear all
load('/Volumes/zf2-mac/threshold.mat')
top_margin=0.005;
left_margin=0.025;
horizontal_margin=0.025;
vertical_margin=0.015;
map_width=0.3;
map_height=0.2;
f=figure;
subplot('position',[left_margin,1-top_margin-map_height-vertical_margin,map_width,map_height]);
axesm('MapProjection','robinson','MapLatLimit',[-60 80],'Frame','on','Grid','off','MeridianLabel','off','ParallelLabel','off')
geoshow(lat,lon,point2ib,'DisplayType','mesh')
CT=cbrewer('div', 'RdYlBu', 12);colormap(CT);
caxis([0.05 0.35])
coast = load('coast.mat');plotm(coast.lat,coast.long,'k','LineWidth',0.5);
title('SMAP-IB','Fontsize',10,'FontWeigh','normal');
ylabel('Copernicus','Fontsize',10)
tightmap;setm(gca,'FLineWidth',1)
ax = gca;set(ax,'YColor','w');set(ax,'XColor','w');ax.YLabel.Color ='k';
text(-0.055,1,'a','Units','normalized','Fontsize',18,'Fontweight','bold');

subplot('position',[left_margin+map_width+horizontal_margin,1-top_margin-map_height-vertical_margin,map_width,map_height]);
axesm('MapProjection','robinson','MapLatLimit',[-60 80],'Frame','on','Grid','off','MeridianLabel','off','ParallelLabel','off')
geoshow(lat,lon,point2scav,'DisplayType','mesh')
caxis([0.05 0.35])
coast = load('coast.mat');plotm(coast.lat,coast.long,'k','LineWidth',0.5);
title('SCA-V','Fontsize',10,'FontWeigh','normal');
tightmap;axis off;setm(gca,'FLineWidth',1)
text(-0.055,1,'b','Units','normalized','Fontsize',18,'Fontweight','bold');

subplot('position',[left_margin+map_width*2+horizontal_margin*2,1-top_margin-map_height-vertical_margin,map_width,map_height]);
axesm('MapProjection','robinson','MapLatLimit',[-60 80],'Frame','on','Grid','off','MeridianLabel','off','ParallelLabel','off')
geoshow(lat,lon,point2smos,'DisplayType','mesh')
caxis([0.05 0.35])
coast = load('coast.mat');plotm(coast.lat,coast.long,'k','LineWidth',0.5);
title('SMOS-IC','Fontsize',10,'FontWeigh','normal');
tightmap;axis off;setm(gca,'FLineWidth',1)
text(-0.055,1,'c','Units','normalized','Fontsize',18,'Fontweight','bold');

load('threshold2.mat')
subplot('position',[left_margin,1-top_margin-map_height*2-vertical_margin,map_width,map_height]);
axesm('MapProjection','robinson','MapLatLimit',[-60 80],'Frame','on','Grid','off','MeridianLabel','off','ParallelLabel','off')
geoshow(lat,lon,point2ib,'DisplayType','mesh')
caxis([0.05 0.35])
coast = load('coast.mat');plotm(coast.lat,coast.long,'k','LineWidth',0.5);
ylabel('MODIS','Fontsize',10)
tightmap;setm(gca,'FLineWidth',1)
ax = gca;set(ax,'YColor','w');set(ax,'XColor','w');ax.YLabel.Color ='k';
text(-0.055,1,'d','Units','normalized','Fontsize',18,'Fontweight','bold');

subplot('position',[left_margin+map_width+horizontal_margin,1-top_margin-map_height*2-vertical_margin,map_width,map_height]);
axesm('MapProjection','robinson','MapLatLimit',[-60 80],'Frame','on','Grid','off','MeridianLabel','off','ParallelLabel','off')
geoshow(lat,lon,point2scav,'DisplayType','mesh')
caxis([0.05 0.35])
coast = load('coast.mat');plotm(coast.lat,coast.long,'k','LineWidth',0.5);
tightmap;axis off;setm(gca,'FLineWidth',1)
text(-0.055,1,'e','Units','normalized','Fontsize',18,'Fontweight','bold');

subplot('position',[left_margin+map_width*2+horizontal_margin*2,1-top_margin-map_height*2-vertical_margin,map_width,map_height]);
axesm('MapProjection','robinson','MapLatLimit',[-60 80],'Frame','on','Grid','off','MeridianLabel','off','ParallelLabel','off')
geoshow(lat,lon,point2smos,'DisplayType','mesh')
caxis([0.05 0.35])
coast = load('coast.mat');plotm(coast.lat,coast.long,'k','LineWidth',0.5);
tightmap;axis off;setm(gca,'FLineWidth',1)
text(-0.055,1,'f','Units','normalized','Fontsize',18,'Fontweight','bold');

subplot('position',[left_margin-map_width*1.5,1-top_margin-map_height*4.2-vertical_margin*2.5,map_width*6+vertical_margin*2,map_height*2.2]);
load('/Volumes/zf2-mac/ensemble/ensemble1.mat')
axesm('MapProjection','robinson','MapLatLimit',[-60 80],'Frame','on','Grid','off','MeridianLabel','off','ParallelLabel','off')
geoshow(lat,lon,ensemble,'DisplayType','mesh')
caxis([0.05 0.35])
coast = load('coast.mat');plotm(coast.lat,coast.long,'k','LineWidth',0.5);
tightmap;axis off;setm(gca,'FLineWidth',1)
title('Ensemble','Fontsize',10,'FontWeigh','normal');
text(-0.055,1,'g','Units','normalized','Fontsize',18,'Fontweight','bold');
h=colorbar('Location','southoutside','Position',...
    [0.182 0.0809 0.61607 0.02],...
    'Ticks',[0.05 0.1 0.15 0.2 0.25 0.3 0.35],'Fontsize',8);
set(get(h,'label'),'string','\theta_{crit} (m^3/m^3)','Fontsize',10)

ax8=axes('Position',[0.11 0.2 0.2 0.2])
axesm('MapProjection','robinson','MapLatLimit',[-60 80],'Frame','on','Grid','off','MeridianLabel','off','ParallelLabel','off')
geoshow(lat,lon,ensembleRUncer,'DisplayType','mesh')
CT1=cbrewer('seq', 'YlOrRd', 50);
colormap(ax8,CT1);
caxis([0 40])
coast = load('coast.mat');plotm(coast.lat,coast.long,'k','LineWidth',0.5);
tightmap;axis off
setm(gca,'FLineWidth',1)
title('Relative uncertainty','Fontsize',7,'Fontweight','normal');
text(0.02,1.112,'h','Units','normalized','Fontsize',18,'Fontweight','bold');
h1=colorbar('Location','southoutside','Position',...
    [0.129285714285714 0.221428571428571 0.161071428571429 0.0119047619047621],...
    'Ticks',[0 10 20 30 40],'Fontsize',6.5);
set(get(h1,'label'),'string','Relative uncertainty (%)','Fontsize',7)

set(gcf,'color','w')
set(gcf, 'InvertHardCopy', 'off');
InPath = '/Volumes/zf2-mac/';cd(InPath);
print(f,'threshold','-dpdf','-r600');




