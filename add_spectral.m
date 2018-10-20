function add_spectral(file)
%add_spectral this function takes the FCS file and makes a new FCS file
%with 2 new paramaters called spectral band and spectral signal to allow
%visualisation of the signal from different detectors. output name is same
%as input but with spectral added.
%   Uses the read/write FCS function from SPADE.

%rules, must have 6 FSC/SSC parameters and then more FL parameters.
%


%example file
%file = "C:\Users\utopi\Documents\WMI\20180824_spectral\network copy_final data\96 Well - V bottom\Specimen_001_B12_B12_003.fcs";
[data,markers,chans,scale,comp,metadata]=readfcs_v2(file);
%remove FSC/SSC (default ssc/fsc a/h/w recorded as first 6 parameters
[tempA tempB]=size(data);
data = data(7:tempA,:);
%make new table with time extending parameter spectral_band &
%spectral_signal

%new time parameter...
[tempA tempB]=size(data);
%get original time data or make numeric fake data (more consistent between
%samples
%%timedata = data(tempA,:);
timedata = 1:tempB;
%number of bands (takes time as the last parameter.
bands = tempA - 1;
%value to add to time
%%toadd = data(tempA,tempB);
toadd = tempB;
%define new variable
spectral = double.empty(0);
%make it for number of parameters
for n=0:bands-1;
    timedata2 = timedata + (toadd*n);
    spectral = cat(2,spectral,timedata2(1,:));
end
%now for the bands
for n=1:bands;
    start = ((n-1)*tempB)+1;
    finish = (n*tempB);
    spectral(2,start:finish) = data(n,:);
end
%markernames
names = {'spectral_band';'spectral_signal'};

[~,name,~] = fileparts(file);
name = char(name);
name = strcat(name,'_spectral.fcs');

writefcs(name,spectral,names);

end

