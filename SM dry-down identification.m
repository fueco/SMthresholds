%%%%%%%%%%%%%%%%%%%%%%%%%Example for SMAP SCA-V
%Read SMAP SM
clear all
InPath = '/Volumes/zf2-mac/SMAP SCA-V SM/';cd(InPath);
d=dir('*.mat');
smap=nan(720,1440);

for k=1:366
    name=d(k).name
    InFile = strcat(InPath,name);
    load(InFile)
    day(k)=str2num(name(7:8));
    smap(:,:,k)=SMAP_SM;
end

%%%%%%%%%%%%%Soil moisture dry-down identification
clear all
InPath = '/Volumes/zf2-mac/SMAPanalysis/ddLST20152020/';cd(InPath);
d=dir('*.mat');
InPath2 = '/Volumes/zf2-mac/SMAPanalysis/';cd(InPath2);
d2=dir('*.mat');
for k=2:6
    name=d(k).name;InFile = strcat(InPath,name);
    deltaLST=cell2mat(struct2cell(load(InFile)));
    name2=d2(k).name;InFile2 = strcat(InPath2,name2);
    smos=cell2mat(struct2cell(load(InFile2)));
    
    ddnumber=nan(720,1440,120,2);dryn=nan(720,1440);
    for i=1:720
        for j=1:1440
            swc(1:365,1)=smos(i,j,1:365);
            lst(1:365,1)=deltaLST(i,j,1:365);
            swc=[0;swc];smt=swc(~isnan(swc));
            lst=[0;lst];slst=lst(~isnan(swc));
            smt=[smt;100];slst=[slst;100];
            
            if length(smt)<32
                continue
            else
                smt=roundn(smt,-5);slst=roundn(slst,-5);
                [pks, ipb] = findpeaks(smt);% Find all peaks in soil moisture
                [troughs,ipe] = findpeaks(-smt);% Find all troughs in soil moisture
                jj = 0;nn=0;ssmv = NaN(40,30);sslst = NaN(40,30);
                for kk = 1 : length(ipb)
                    ke = min(find(ipe>ipb(kk)));
                    smv =  smt(ipb(kk):ipe(ke));
                    smv(isnan(smv)) = [];
                    lstdry = slst(ipb(kk):ipe(ke));
                    lstdry(isnan(smv)) = [];
                    if (length(smv)>=5) && smv(2)<smv(1) && smv(3)<smv(2) && smv(4)<smv(3) && (max(smv)-min(smv))>=0.01   %Only store if drydown length>=dLength
                        jj = jj + 1;
                        nn(jj,1)=length(smv);
                        ssmv(jj,1:length(smv)) =  smv;
                        sslst(jj,1:length(smv)) =  lstdry;
                    end
                end
                total_ssmv=nan(1,30);total_slstdry=nan(1,30);
                total_ssmv=[total_ssmv;ssmv];
                total_slstdry=[total_slstdry;sslst];
                slstdry2=reshape(total_slstdry(:,1:30)',[30*length(total_slstdry(:,1)),1]);
                ssmv2=reshape(total_ssmv(:,1:30)',[30*length(total_ssmv(:,1)),1]);
                data=[ssmv2,slstdry2];
                data = rmmissing(data,1);
                
                ddnumber(i,j,1:length(data(:,1)),:)=data;
                dryn(i,j)=jj;
            end
        end
        i
    end
    newname = ['ddnumber',name2(5:10)];
    filename_out=['/Volumes/zf2-mac/SMAPanalysis/ddnumber/' newname '.mat'];
    save(filename_out,'ddnumber','dryn','-v7.3');
    
    clearvars -except k InPath d InPath2 d2
end

%%%%%%%%%%%%%%%%%%%%%%2015 0401start SMAP, 1-90days miss SM DATA
%20150401start
clear all
InPath = '/Volumes/zf2-mac/SMAPanalysis/ddLST20152020/';cd(InPath);
d=dir('*.mat');
InPath2 = '/Volumes/zf2-mac/SMAPanalysis/';cd(InPath2);
d2=dir('*.mat');
k=1
name=d(k).name;InFile = strcat(InPath,name);
deltaLST=cell2mat(struct2cell(load(InFile)));
name2=d2(k).name;InFile2 = strcat(InPath2,name2);
smos=cell2mat(struct2cell(load(InFile2)));

ddnumber=nan(720,1440,120,2);dryn=nan(720,1440);
for i=1:720
    for j=1:1440
        clear swc lst
        swc(1:275,1)=smos(i,j,1:275);
        lst(1:275,1)=deltaLST(i,j,91:365);
        swc=[0;swc];smt=swc(~isnan(swc));
        lst=[0;lst];slst=lst(~isnan(swc));
        smt=[smt;100];slst=[slst;100];
        
        if length(smt)<32
            continue
        else
            smt=roundn(smt,-5);slst=roundn(slst,-5);
            [pks, ipb] = findpeaks(smt);% Find all peaks in soil moisture
            [troughs,ipe] = findpeaks(-smt);% Find all troughs in soil moisture
            jj = 0;nn=0;ssmv = NaN(40,30);sslst = NaN(40,30);
            for kk = 1 : length(ipb)
                ke = min(find(ipe>ipb(kk)));
                smv =  smt(ipb(kk):ipe(ke));
                smv(isnan(smv)) = [];
                lstdry = slst(ipb(kk):ipe(ke));
                lstdry(isnan(smv)) = [];
                if (length(smv)>=5) && smv(2)<smv(1) && smv(3)<smv(2) && smv(4)<smv(3) && (max(smv)-min(smv))>=0.01   %Only store if drydown length>=dLength
                    jj = jj + 1;
                    nn(jj,1)=length(smv);
                    ssmv(jj,1:length(smv)) =  smv;
                    sslst(jj,1:length(smv)) =  lstdry;
                end
            end
            total_ssmv=nan(1,30);total_slstdry=nan(1,30);
            total_ssmv=[total_ssmv;ssmv];
            total_slstdry=[total_slstdry;sslst];
            slstdry2=reshape(total_slstdry(:,1:30)',[30*length(total_slstdry(:,1)),1]);
            ssmv2=reshape(total_ssmv(:,1:30)',[30*length(total_ssmv(:,1)),1]);
            data=[ssmv2,slstdry2];
            data = rmmissing(data,1);
            
            ddnumber(i,j,1:length(data(:,1)),:)=data;
            dryn(i,j)=jj;
        end
    end
    i
end
newname = ['ddnumber',name2(5:10)];
filename_out=['/Volumes/zf2-mac/SMAPanalysis/ddnumber/' newname '.mat'];
save(filename_out,'ddnumber','dryn','-v7.3');


%%%%%%%Save data
clear all
InPath = '/Volumes/zf2-mac/SMAPanalysis/ddnumber/';cd(InPath);
load('ddnumber2015.mat')
ddnumber2015=ddnumber;
load('ddnumber2016.mat')
ddnumber2016=ddnumber;
load('ddnumber2017.mat')
ddnumber2017=ddnumber;
load('ddnumber2018.mat')
ddnumber2018=ddnumber;
load('ddnumber2019.mat')
ddnumber2019=ddnumber;
load('ddnumber2020.mat')
ddnumber2020=ddnumber;
k1=1
sm5(:,:,1:120)=ddnumber2015(:,:,:,k1);
sm6(:,:,1:120)=ddnumber2016(:,:,:,k1);
sm7(:,:,1:120)=ddnumber2017(:,:,:,k1);
sm8(:,:,1:120)=ddnumber2018(:,:,:,k1);
sm9(:,:,1:120)=ddnumber2019(:,:,:,k1);
sm10(:,:,1:120)=ddnumber2020(:,:,:,k1);

sm=cat(3,sm5,sm6,sm7,sm8,sm9,sm10);
k1=2
dt5(:,:,1:120)=ddnumber2015(:,:,:,k1);
dt6(:,:,1:120)=ddnumber2016(:,:,:,k1);
dt7(:,:,1:120)=ddnumber2017(:,:,:,k1);
dt8(:,:,1:120)=ddnumber2018(:,:,:,k1);
dt9(:,:,1:120)=ddnumber2019(:,:,:,k1);
dt10(:,:,1:120)=ddnumber2020(:,:,:,k1);
dt=cat(3,dt5,dt6,dt7,dt8,dt9,dt10);
newname = ['sm'];
filename_out=['/Volumes/zf2-mac/SMAPanalysis/ddnumber/' newname '.mat'];
save(filename_out,'sm','-v7.3');
newname = ['dt'];
filename_out=['/Volumes/zf2-mac/SMAPanalysis/ddnumber/' newname '.mat'];
save(filename_out,'dt','-v7.3');


