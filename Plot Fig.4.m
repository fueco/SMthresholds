%%%%%%%%Plot Fig.4_FSD
%%%plot map median of smapib smap smos
clear all
load('smapibglobal100.mat')
cc=ratio(:,:,2:6);
ratio3=nanmedian(cc,3);
point2ib=ratio3;
clearvars -except point2ib
load('smapglobal100.mat')
cc=ratio(:,:,2:6);
ratio3=nanmedian(cc,3);
point2scav=ratio3;
clearvars -except point2ib point2scav
load('smosglobal100.mat')
cc=ratio(:,:,6:10);
ratio3=nanmedian(cc,3);
point2smos=ratio3;
clearvars -except point2ib point2scav point2smos
a(:,:,1)=point2ib;a(:,:,2)=point2scav;a(:,:,3)=point2smos;
obs=nanmedian(a,3);

load('/Volumes/zf2-mac/LonLat_ecv.mat')
lat=repmat(Lat_ecv,1,1440);lon=repmat(Lon_ecv',720,1);
top_margin=0.005;
left_margin=0.025;
horizontal_margin=0.025;
vertical_margin=0.015;
map_width=0.45;
map_height=0.3;
f=figure;
subplot('position',[left_margin,1-top_margin-map_height-vertical_margin,map_width,map_height]);
axesm('MapProjection','robinson','MapLatLimit',[-60 80],'Frame','on','Grid','off','MeridianLabel','off','ParallelLabel','off')
geoshow(lat,lon,100*obs,'DisplayType','mesh')
InPath = '/Volumes/zf2-backup/Delta_LST_025deg/ddnumber';cd(InPath);
CT=cbrewer('seq', 'YlOrRd', 10);colormap(CT)
caxis([0 100])
coast = load('coast.mat');plotm(coast.lat,coast.long,'k','LineWidth',1);
tightmap;axis off;setm(gca,'FLineWidth',1.5)
title('Satellite observed SM','Fontsize',10,'FontWeigh','normal');
text(-0.035,1,'a','Units','normalized','Fontsize',16,'Fontweight','bold');

%%%%%%%%%%%plot map median of era5 during 2016-2020
load('/Volumes/zf2-mac/ERA5LAND/ddnumbersm1/ERA5LAND100_42yr.mat')
cc=ratio(:,:,38:42);
ratio3=nanmedian(cc,3);
ax2=subplot('position',[left_margin+map_width+horizontal_margin,1-top_margin-map_height-vertical_margin,map_width,map_height]);
axesm('MapProjection','robinson','MapLatLimit',[-60 80],'Frame','on','Grid','off','MeridianLabel','off','ParallelLabel','off')
geoshow(lat,lon,100*ratio3,'DisplayType','mesh')
InPath = '/Volumes/zf2-backup/Delta_LST_025deg/ddnumber';cd(InPath);
caxis([0 100])
coast = load('coast.mat');plotm(coast.lat,coast.long,'k','LineWidth',1);
tightmap;axis off;setm(gca,'FLineWidth',1.5)
title('ERA5-Land reanalysis SM','Fontsize',10,'FontWeigh','normal');
h1=colorbar('Location','southoutside','Position',...
    [0.21 0.671 0.553 0.02],...
    'Ticks',[10 30 50 70 90],'Fontsize',10);
set(get(h1,'label'),'string','Fraction of time when SM is below \theta_{crit} (%)','Fontsize',10)
text(-0.035,1,'b','Units','normalized','Fontsize',16,'Fontweight','bold');

clearvars -except f
top_margin=0.005;
left_margin=0.025;
horizontal_margin=0.025;
vertical_margin=0.015;
map_width=0.45;
map_height=0.3;
load('/Volumes/zf2-mac/ERA5LAND/ddnumbersm1/ERA5LAND100_42yr.mat')
cc=ratio(:,:,1:42);
ratio3=nanmedian(cc,3);
B = reshape(ratio,720*1440,42);
load('/Volumes/zf2-mac/land change vcf/all<10.mat')
ratio3(isnan(ALL)==1)=nan;
medianvalue = ratio3(:);

m8=B(medianvalue>0.7&medianvalue<=0.9,:);m81(1:42,1)=nanmedian(m8);% nanmedian(m8(:,15))
m6=B(medianvalue>0.5&medianvalue<=0.7,:);m61(1:42,1)=nanmedian(m6);% nanmedian(m8(:,15))
m4=B(medianvalue>0.3&medianvalue<=0.5,:);m41(1:42,1)=nanmedian(m4);% nanmedian(m8(:,15))
m2=B(medianvalue>0.1&medianvalue<=0.3,:);m21(1:42,1)=nanmedian(m2);% nanmedian(m8(:,15))
subplot('position',[left_margin+0.08,1-top_margin-map_height*2-vertical_margin*9-0.02,map_width-0.08,map_height]);
yy1=100*quantile(m8,0.25);yy2=100*quantile(m8,0.75);
x= 1979:1:2020;
for m=1:42-1
    patch([x(m) x(m+1) x(m+1) x(m) x(m)],[yy1(m) yy1(m+1) yy2(m+1) yy2(m) yy1(m)],ones(1,5),'facecolor','r','edgecolor','none','facealpha',0.1)
    hold on
end
h8=plot(x,100*m81,'r-','linewidth',3);hold on

yy1=100*quantile(m6,0.25);yy2=100*quantile(m6,0.75);
x= 1979:1:2020;
for m=1:42-1
    patch([x(m) x(m+1) x(m+1) x(m) x(m)],[yy1(m) yy1(m+1) yy2(m+1) yy2(m) yy1(m)],ones(1,5),'facecolor','k','edgecolor','none','facealpha',0.1)
    hold on
end
h6=plot(x,100*m61,'k-','linewidth',3);hold on

yy1=100*quantile(m4,0.25);yy2=100*quantile(m4,0.75);
x= 1979:1:2020;
for m=1:42-1
    patch([x(m) x(m+1) x(m+1) x(m) x(m)],[yy1(m) yy1(m+1) yy2(m+1) yy2(m) yy1(m)],ones(1,5),'facecolor',[117 107 177]/255,'edgecolor','none','facealpha',0.1)
    hold on
end
h4=plot(x,100*m41,'-','Color',[117 107 177]/255,'linewidth',3);hold on

yy1=100*quantile(m2,0.25);yy2=100*quantile(m2,0.75);
x= 1979:1:2020;
for m=1:42-1
    patch([x(m) x(m+1) x(m+1) x(m) x(m)],[yy1(m) yy1(m+1) yy2(m+1) yy2(m) yy1(m)],ones(1,5),'facecolor','b','edgecolor','none','facealpha',0.1)
    hold on
end
h2=plot(x,100*m21,'b-','linewidth',3);hold on


ylim([0,116]);xlim([1978,2021]);yticks([0 30 60 90])
ylabel({'Fraction of time'; 'when SM is below \theta_{crit} (%)'},'Fontsize',10)
xlabel('Year','Fontsize',10);set(gca,'Fontsize',10);box off
InPath = '/Volumes/zf2-mac/SMAPIB2022/ratio_lowtheta/usingensemble/github_repo/legendflex';cd(InPath);
legendflex([h2,h4,h6,h8],{'10%<Fraction<30%','30%<Fraction<50%','50%<Fraction<70%','70%<Fraction<90%'},'ncol',2,'xscale', 0.5,'fontsize',8)

InPath = '/Volumes/zf2-mac/SMAPIB2022/ratio_lowtheta/usingensemble/ktaub';cd(InPath);

datain(1:42,1)=1979:2020;datain(1:42,2)=100*m21;
[taub tau h sig Z S sigma sen n senplot CIlower CIupper] = ktaub(datain, 0.05)
sen1=sprintf('%.2f',sen);txt = ['Sen slope=',num2str(sen1),' [0.20, 0.29]'];
text(2003-8,12,txt,'fontsize',10,'color','b')

datain(1:42,1)=1979:2020;datain(1:42,2)=100*m41;
[taub tau h sig Z S sigma sen n senplot CIlower CIupper] = ktaub(datain, 0.05)
sen1=sprintf('%.2f',sen);txt = ['Sen slope=',num2str(sen1),' [0.18, 0.30]'];
text(2003-8,33,txt,'fontsize',10,'color',[117 107 177]/255)

datain(1:42,1)=1979:2020;datain(1:42,2)=100*m61;
[taub tau h sig Z S sigma sen n senplot CIlower CIupper] = ktaub(datain, 0.05)
sen1=sprintf('%.2f',sen);txt = ['Sen slope=',num2str(sen1),' [0.15, 0.26]'];
text(2003-8,53,txt,'fontsize',10,'color','k')

datain(1:42,1)=1979:2020;datain(1:42,2)=100*m81;
[taub tau h sig Z S sigma sen n senplot CIlower CIupper] = ktaub(datain, 0.05)
sen1=sprintf('%.2f',sen);txt = ['Sen slope=',num2str(sen1),' [0.07, 0.18]'];
text(2003-8,73,txt,'fontsize',10,'color','r')
text(-0.267,1,'c','Units','normalized','Fontsize',16,'Fontweight','bold');


%%%plot trend map
clearvars -except f
top_margin=0.005;
left_margin=0.025;
horizontal_margin=0.025;
vertical_margin=0.015;
map_width=0.45;
map_height=0.3;
load('/Volumes/zf2-mac/ERA5LAND/ddnumbersm1/ERA5land100maptrend.mat')
sen=output(:,:,1);h=output(:,:,3);sen(h==0)=nan;
load('/Volumes/zf2-mac/land change vcf/all<10.mat')
sen_mask=sen;
sen_mask(isnan(ALL)==1)=nan;
load('/Volumes/zf2-mac/LonLat_ecv.mat')
lat=repmat(Lat_ecv,1,1440);lon=repmat(Lon_ecv',720,1);
ax4=subplot('position',[left_margin+map_width+horizontal_margin,1-top_margin-map_height*2-vertical_margin*9,map_width,map_height]);
axesm('MapProjection','robinson','MapLatLimit',[-60 80],'Frame','on','Grid','off','MeridianLabel','off','ParallelLabel','off')
geoshow(lat,lon,100*sen_mask,'DisplayType','mesh')
InPath = '/Volumes/zf2-backup/Delta_LST_025deg/ddnumber';cd(InPath);
CT4=cbrewer('div', 'RdYlBu', 10);
CT4 = flipud(CT4);colormap(ax4,CT4)
caxis([-0.5 0.5])
coast = load('coast.mat');plotm(coast.lat,coast.long,'k','LineWidth',1);
tightmap;axis off;setm(gca,'FLineWidth',1.5)
title('Trend in Fraction using ERA5-Land reanalysis SM','Fontsize',10,'FontWeigh','normal');
h4=colorbar('Location','southoutside','Position',...
    [0.5478 0.671-map_height-vertical_margin*9 0.353 0.02],...
    'Ticks',[-0.4 -0.2 0 0.2 0.4],'Fontsize',10);
set(get(h4,'label'),'string','Trend in Fraction (yr^{-1})','Fontsize',10)
text(-0.035,1,'d','Units','normalized','Fontsize',16,'Fontweight','bold');

InPath = '/Volumes/zf2-mac/Figures/';cd(InPath);
print(f,'fig4','-dpdf','-r600');