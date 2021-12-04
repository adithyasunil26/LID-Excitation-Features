function out = zff(sig, Fs)
%     [data, Fs] = audioread(file);
%     sig=data(:,1); %sig
%     egg=data(:,2); %EGG data
    %egg=filter([1 -1],1,egg);
%     sig = data(16000:18000);
    %egg = egg(16000:18000);
    pre_emp_sig= filter([1, -1], 1, sig);
    % Passing through cascaded Resonator
    x=cumtrapz(pre_emp_sig);
    x=cumtrapz(x);
    x=cumtrapz(x);
    x=cumtrapz(x);
    % Mean-Frame length 
    Horizon=4;
    Horizon = Horizon*Fs/1000;
    % Mean Trend Removal 
    Lsig=length(sig);
    slice = 1:Horizon;
    Nfr = floor(Lsig/Horizon);
    out = zeros(size(sig));
    for l=1:Nfr
        frame=x(slice);
        out(slice)=frame-mean(frame);
        slice = slice+Horizon;
    end
    return
    
%     Plotting .
%     figure; 
%     t=linspace(0,length(sig),length(sig));
%     subplot(4,1,1)
%     plot(t,sig);
%     xlabel('Time (ms)');
%     ylabel('Speech Frame'); 
%     grid on; 
%     subplot(4,1,2)
%     plot(t,x);
%     xlabel('Time (ms)');
%     ylabel('Filtered Signal'); 
%     grid on;
%     subplot(4,1,3)
%     plot(t,out);
%     xlabel('Time (ms)');
%     ylabel('ZFFS'); 
%     grid on;
%     subplot(4,1,4)
%     %plot(t,egg,'-');
%     xlabel('Time (ms)');
%     ylabel('EGG');
%     grid on    
end