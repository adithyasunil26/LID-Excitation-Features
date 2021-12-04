function res = lp_res(sig, Fs)
    % LPC analysis
    fil=filter([1, -1], 1, sig);
    a=1;
    Lsig = length(sig);
    OrderLPC =24;         %order of LPC
    out = zeros(size(sig));
    Win = hanning(Lsig);  %hanning window
    sigLPC = Win.*fil;
    en = sum(sigLPC.^2); 
    r =  xcorr(sigLPC); 
    r = r./max(abs(r));
    [a,g]=lpc(sigLPC,OrderLPC);               % LPC coefficients
    y_hat = filter([0 -1*a(2:end)],1,sigLPC); % inverse filter
    res=sigLPC-y_hat;
    return
end