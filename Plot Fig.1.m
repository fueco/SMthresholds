%%%%%%%%%Plot Fig.1 EF-SM vs dLST-SM
clear all
load('DehaiThresholdLST.mat')
width = 10;     % Width in inches
height = 10;    % Height in inches
defpos = get(0,'defaultFigurePosition');
set(0,'defaultFigurePosition', [defpos(1) defpos(2) width*100, height*100]);
top_margin=0.017;
left_margin=0.06;
horizontal_margin=0.05;
vertical_margin=0.001;
map_width=0.2;
map_height=0.2;
ax2 = subplot('position',[left_margin,1-top_margin-map_height*2-vertical_margin-0.057,map_width-0.025,map_height]);
xx=mswc*0.01;YY=mef;
scatter(xx,YY,40,'b','LineWidth',1);hold on
peakef=0.5103;b=0.0362*100;th=19.16*0.01;%sav
x= min(xx)-0.0001:0.0001:th;
y=peakef+b*(x-th);
plot(x,y,'k-','linewidth',4);hold on
x1=[th-0.0001:0.0001:0.44];
p1=plot(x1,peakef+x1*0,'Color','k','linewidth',4);
ylabel('EF');
xlabel('Soil moisture (m^3/m^3)');box on;set(gca,'Fontsize',12);
hold on;yL = get(gca, 'YLim');plot([th th], yL, 'k:','LineWidth', 1.5);
title('DE-Hai','Fontsize',10);
text(-0.24,1.01,'a','Units','normalized','Fontsize',18,'Fontweight','bold');
text(th+0.002, 0.09,['\theta_{crit}'],'fontsize',11,'Color','red')

ax3 = subplot('position',[left_margin+map_width+horizontal_margin-0.025,1-top_margin-map_height*2-vertical_margin-0.057,map_width-0.025,map_height]);
YY=mdt;
scatter(xx,YY,40,'b','LineWidth',1);hold on
peakef=8.449124;b=-1.87*100;th=19.11*0.01;%sav
x= min(xx)-0.0001:0.0001:th;
y=peakef+b*(x-th);
plot(x,y,'k-','linewidth',4);hold on
x1=[th-0.0001:0.0001:0.44];
p1=plot(x1,peakef+x1*0,'Color','k','linewidth',4);
%ylabel('\DeltaLST (K)');
ylabel('dLST (K)');
xlabel('Soil moisture (m^3/m^3)');box on;set(gca,'Fontsize',12);
hold on;yL = get(gca, 'YLim');plot([th th], yL, 'k:','LineWidth', 1.5);
title('DE-Hai','Fontsize',10);
text(-0.24,1.01,'b','Units','normalized','Fontsize',18,'Fontweight','bold');
text(th+0.002,2,['\theta_{crit}'],'fontsize',11,'Color','red')

ax3 = subplot('position',[left_margin,1-top_margin-4*map_height-2*vertical_margin-0.054*2-0.015-0.003,map_width*2,map_height*2]);
YY=0.01*Threshold_lst;
xx=0.01*Threshold_ef;% mdl = fitlm(xx,YY)
XX = [ones(length(xx),1) xx];
b = XX\YY
yCalc2 = XX*b;
plot(xx,YY,'.','Color',[0.5,0.5,0.5],'Markersize',30);hold on
plot(xx,yCalc2,'r-','linewidth',3);
Rsq = 1 - sum((YY - yCalc2).^2)/sum((YY - mean(YY)).^2)
r2=Rsq;
xlim([0 0.4]);ylim([0 0.4]);yticks(0:0.1:0.4);xticks(0:0.1:0.4);
txt = ['y=0.96x+0.02 (r=0.87, {\itp}<0.001)'];
text(0.18,0.07,txt,'fontsize',14)
ylabel('Threshold using dLST method (m^3/m^3)')
xlabel('Threshold using EF method (m^3/m^3)');
set(gca, 'Fontsize',12);plot(xlim, ylim, '--k')
title('All sites','Fontsize',10);
text(-0.105,1.03,'c','Units','normalized','Fontsize',18,'Fontweight','bold');

threshold2=0.01*Threshold_lst;
igbpid1=igbpid;
x=nan(200,8);
x(1:length(threshold2(igbpid1==1)),1) = threshold2(igbpid1==1);
x(1:length(threshold2(igbpid1==2)),2)  = threshold2(igbpid1==2);
x(1:length(threshold2(igbpid1==3)),3)  = threshold2(igbpid1==3);
x(1:length(threshold2(igbpid1==4)),4)  = threshold2(igbpid1==4);
x(1:length(threshold2(igbpid1==6)),5)  = threshold2(igbpid1==6);
x(1:length(threshold2(igbpid1==7)),6) =threshold2(igbpid1==7);
x(1:length(threshold2(igbpid1==8)),7) =threshold2(igbpid1==8);
x(1:length(threshold2(igbpid1==5)),8) =threshold2(igbpid1==5);
sm_cov_pft=nanmedian(x(:,1:8))
sm_cov_pft_75th=abs(quantile(x(:,1:8),0.75)-sm_cov_pft)
sm_cov_pft_25th=abs(quantile(x(:,1:8),0.25)-sm_cov_pft)

threshold2=0.01*Threshold_ef;
igbpid1=igbpid;
x=nan(200,8);
x(1:length(threshold2(igbpid1==1)),1) = threshold2(igbpid1==1);
x(1:length(threshold2(igbpid1==2)),2)  = threshold2(igbpid1==2);
x(1:length(threshold2(igbpid1==3)),3)  = threshold2(igbpid1==3);
x(1:length(threshold2(igbpid1==4)),4)  = threshold2(igbpid1==4);
x(1:length(threshold2(igbpid1==6)),5)  = threshold2(igbpid1==6);
x(1:length(threshold2(igbpid1==7)),6) =threshold2(igbpid1==7);
x(1:length(threshold2(igbpid1==8)),7) =threshold2(igbpid1==8);
x(1:length(threshold2(igbpid1==5)),8) =threshold2(igbpid1==5);
sm_ef_pft=nanmedian(x(:,1:8))
sm_ef_pft_75th=abs(quantile(x(:,1:8),0.75)-sm_ef_pft)
sm_ef_pft_25th=abs(quantile(x(:,1:8),0.25)-sm_ef_pft)
hold on;
InPath = '/Users/zhengfu/threshold/globalsite1/';cd(InPath);
point_col=cbrewer('qual', 'Dark2', 8);
  for t=1:8
    errorbar(sm_ef_pft(t),sm_cov_pft(t),sm_cov_pft_25th(t),sm_cov_pft_75th(t),sm_ef_pft_25th(t),sm_ef_pft_75th(t),'o','color',point_col(t,:),'MarkerSize',10,'LineWidth',1);
    hpft(t)=plot(sm_ef_pft(t),sm_cov_pft(t),'o','markeredgecolor',point_col(t,:),'MarkerSize',10,'LineWidth',1.5);
    hold on
  end
lege=legend(hpft,{'DBF','EBF','ENF','MF','GRA','SAV','SHR','CRO'},'location','northwest');set(lege,'box','off')
