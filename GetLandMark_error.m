function [ sal ] = GetLandMark_error( rpos,map,land )

rpos(3)=AngleWrap(rpos(3));
ang=atan2(+rpos(1)-map(1,land),rpos(2)-map(2,land))-rpos(3);
dist=sqrt((rpos(1)-map(1,land))^2+(rpos(2)-map(2,land))^2);
SigmaDis = 0.01;
SigmaAng = 0.01;
%Q = diag([SigmaDis^2 SigmaAng^2]);
dist=dist+randn(1,1)*SigmaDis^2;
ang=ang+randn(1,1)*SigmaAng^2;
sal=[dist;ang];
%sal=pose_comp(sal,randn(1,2)*sqrt(Q));
% Sumar errores
end

