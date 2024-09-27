 A=codes.Run_codes;
Check1=[7;8;9;10;11];
for i =1:length(A)
    for j=1:length(Check1)
        if A(i) == Check1(j)
            A(i)=101;
        end
    end
end
Check2=[12;13;14;15;16];
for i =1:length(A)
    for j=1:length(Check2)
        if A(i) == Check2(j)
            A(i)=102;
        end
    end
end
Check3=[17;18;19;20;21];
for i =1:length(A)
    for j=1:length(Check3)
        if A(i) == Check3(j)
             A(i)=103;
        end
    end
end
Check4=[22;23;24;25;26];
for i =1:length(A)
    for j=1:length(Check4)
        if A(i) == Check4(j)
             A(i)=104;
        end
    end
end
Check5=[27;28;29;30;31];
for i =1:length(A)
    for j=1:length(Check5)
        if A(i) == Check5(j)
             A(i)=105;
        end
    end
end
Check6=[32;33;34;35;36];
for i =1:length(A)
    for j=1:length(Check6)
        if A(i) == Check6(j)
             A(i)=106;
        end
    end
end
Check7=[38;39;45];
for i =1:length(A)
    for j=1:length(Check7)
        if A(i) == Check7(j)
             A(i)=107;
        end
    end
end
Check8=[53;54;55];
for i =1:length(A)
    for j=1:length(Check8)
        if A(i) == Check8(j)
             A(i)=108;
        end
    end
end
Check9=[61;62;66];
for i =1:length(A)
    for j=1:length(Check9)
        if A(i) == Check9(j)
             A(i)=109;
        end
    end
end
Check10=[37;40;44];
for i =1:length(A)
    for j=1:length(Check10)
        if A(i) == Check10(j)
             A(i)=110;
        end
    end
end
Check11=[51;52;56];
for i =1:length(A)
    for j=1:length(Check11)
        if A(i) == Check11(j)
             A(i)=111;
        end
    end
end
Check12=[63;64;65];
for i =1:length(A)
    for j=1:length(Check12)
        if A(i) == Check12(j)
             A(i)=112;
        end
    end
end
Check13=[41;42;43;46;47;48;49;50;57;58;59;60;69;72;73;74;75;76;77;78;79;83;84;86;87;88;90;93;94;96];
for i =1:length(A)
    for j=1:length(Check13)
        if A(i) == Check13(j)
             A(i)=200;
        end
    end
end
