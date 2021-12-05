function out = zff(sig, Fs)
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
end