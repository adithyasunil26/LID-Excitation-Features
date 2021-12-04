
list = dir('complete');
list = list(4:length(list));


l={};
for i=1:length(list)
    l=[l, list(i).name];
end


for i=1:length(l)

    [sig, Fs] = audioread(strcat('complete/',char(l(i))));

    if(length(sig)<2.75*Fs)
        disp(char(l(i)))
    end

end

