function Result=melt_calc(mantle,KD,F,Norm_ini,tag)
% This function implements partial melting of a lunar mantle with known REE
% compositions (mantle), partition coefficients (KD), partial melting degree
% (F), initial mineral modal abundance of the mantle (Norm_ini), and
% melting mode (tag). This function allows matrix input for F.

% CI chondrite values from McDonough & Sun (1995) CG
CI=[0.237,0.613,0.0928,0.457,0.148,0.0563,0.199,0.0361,0.246,0.0546,0.16,0.0247,0.161,0.0246];

% Result format: index, F, Norm_Ol, Norm_Px, Norm_Pl, Norm_Ilm, Norm_Gt, La-Lu
Result=zeros([length(F),24]);

for i=1:length(F)
    SolidF=Norm_ini.*(1-F(i));
    Norm=SolidF./sum(SolidF);
    D=Norm*KD;
    if strcmp(tag,'equilibrium')  % Equilibrium melting
        CL=mantle./(D+(1-D)*F(i));
    elseif strcmp(tag,'fractional')  % Fractional melting
        CL=(mantle./F(i)).*(1-(1-F(i)).^(1./D));
    else
        error('Please check the melting mode. It should be either "equilibrium" or "fractional".')
    end
    Result(i,1)=i;
    Result(i,2)=F(i);
    Result(i,3:10)=SolidF;
    Result(i,11:end)=CL;
end

Result(:,11:end)=Result(:,11:end)./CI;
Result=fillmissing(Result,"linear",2);