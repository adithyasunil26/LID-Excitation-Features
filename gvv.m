function k = gvv(sig, res)

%     [data, Fs] = audioread(file);
    
%     sig=data(:,1);  %signal
    %egg=data(:,2);  %egg data


    %Voiced Frame
%     sig=data(40000:50000);
    %egg=egg(16000:18000);

    % GVV 
    gvv_sig=cumtrapz(res);
    k = gvv_sig;
    
    t=linspace(0,length(sig),length(sig));

    
    
%     %plots
%     figure; 
%     subplot(4,1,1)
%     plot(t,sig);
%     xlabel('Time');
%     ylabel('Speech Frame'); 
%     grid on;
% 
%     subplot(4,1,2)
%     plot(t,lp_res);
%     xlabel('Time');
%     ylabel('LP Residual'); 
%     grid on;
% 
%     subplot(4,1,3)
%     plot(t,gvv_sig);
%     xlabel('Time');
%     ylabel('GVV of Speech Frame'); 
%     grid on;
          
          
    %subplot(4,1,4)
    %plot(t,egg);
    %xlabel('Time');
    %ylabel('Ground Truth - EGG'); 
    %grid on;
          

  end