function [ sal ] = GetLandMark( rpos,map )
nland=size(map);
land=randi(nland(2))
rpos(3)=AngleWrap(rpos(3))
ang=atan2(+rpos(1)-map(1,land),rpos(2)-map(2,land))-rpos(3);
dist=sqrt((rpos(1)-map(1,land))^2+(rpos(2)-map(2,land))^2);
sal=[dist;ang];
end

