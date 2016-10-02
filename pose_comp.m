function p=pose_comp(p1,p2)
%This function computes the composition of two poses, p1,p2 of dimension 3x1
%p is the resultant pose
p=[p1(1)+p2(1)*cos(p1(3))-p2(2)*sin(p1(3));
   p1(2)+p2(1)*sin(p1(3))+p2(2)*cos(p1(3));
   p1(3)+p2(3)];


end
