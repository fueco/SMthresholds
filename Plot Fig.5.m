%%%%%%%%%%Plot Fig.5_Threshold from Models
clear all
load('/Volumes/zf2-mac/CMIP6/obsmod.mat')

top_margin=0.005;
left_margin=0.025;
horizontal_margin=0.025;
vertical_margin=0.015;
map_width=0.45;
map_height=0.3;
f=figure;
load('/Volumes/zf2-mac/LonLat_ecv.mat')
lat=repmat(Lat_ecv,1,1440);lon=repmat(Lon_ecv',720,1);
subplot('position',[left_margin,1-top_margin-map_height-vertical_margin,map_width,map_height]);
axesm('MapProjection','robinson','MapLatLimit',[-60 80],'Frame','on','Grid','off','MeridianLabel','off','ParallelLabel','off')
geoshow(lat,lon,mmod1,'DisplayType','mesh')
InPath = '/Volumes/zf2-backup/Delta_LST_025deg/ddnumber';cd(InPath);
CT=cbrewer('div', 'RdYlBu', 12);colormap(CT);
caxis([0.05 0.35])
coast = load('coast.mat');plotm(coast.lat,coast.long,'k','LineWidth',1);
tightmap;axis off;setm(gca,'FLineWidth',1.5)
title('Multi-model mean \theta_{crit}','Fontsize',10,'FontWeigh','normal');
h=colorbar('Location','southoutside','Position',...
    [0.071 0.671 0.353 0.02],...
    'Ticks',[0.05 0.1 0.15 0.2 0.25 0.3 0.35],'Fontsize',8);
set(get(h,'label'),'string','\theta_{crit} (m^3/m^3)','Fontsize',10)
text(-0.035,1.1,'a','Units','normalized','Fontsize',16,'Fontweight','bold');


%%%%%%%%%%%plot model -obs
diff1=(-1)*diff;
ax2=subplot('position',[left_margin+map_width+horizontal_margin,1-top_margin-map_height-vertical_margin,map_width,map_height]);
axesm('MapProjection','robinson','MapLatLimit',[-60 80],'Frame','on','Grid','off','MeridianLabel','off','ParallelLabel','off')
geoshow(lat,lon,diff1,'DisplayType','mesh')
CT2=cbrewer('div', 'BrBG', 8);colormap(ax2,CT2);
caxis([-0.2 0.2])
coast = load('coast.mat');plotm(coast.lat,coast.long,'k','LineWidth',1);
tightmap;axis off;setm(gca,'FLineWidth',1.5)
title('Differences between obs- and models-based \theta_{crit}','Fontsize',10,'FontWeigh','normal');
h1=colorbar('Location','southoutside','Position',...
    [0.5478 0.671 0.353 0.02],...
    'Ticks',[-0.2 -0.15 -0.1 -0.05 0 0.05 0.1 0.15 0.2],'Fontsize',8);
set(get(h1,'label'),'string','Multi-model mean \theta_{crit} minus obs-based \theta_{crit} (m^3/m^3)','Fontsize',10)
text(-0.035,1.1,'b','Units','normalized','Fontsize',16,'Fontweight','bold');

InPath = '/Volumes/zf2-mac/Figures/';cd(InPath);
print(f,'fig5','-dpdf','-r600');