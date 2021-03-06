% Main Code
% Graphical simulation of a robot trying to find its position

numland=4;

map=CreateMap(numland,5);
nland=size(map);
land=randi(nland(2)) 
x=[0;0;0];

k=1;
x = zeros(3,1);
xtrue = zeros(3,1);
%%Noisy control action
SigmaX = 0.01;
SigmaY = 0.01;
SigmaPhi = 0.0015;
Sigma_sensor=0.001;
Q = diag([SigmaX^2 SigmaY^2 SigmaPhi^2]);
%%length of the simulation
num_steps=100;
particles=zeros(4,100);
ini_weight=1/100;
particles(4,:)=ini_weight;
figure (1)
hold on
grid on
for i=1:numland
plot(map(1,i),map(2,i),'*','markers',17,'Color',[.5,0.1,0.1]);
t=sprintf('LM %d',i);
text(map(1,i)+1,map(2,i)+1,t);
end
while (k<num_steps+1)
%% Add here the control action to follow a rectangle in terms of increments of x,y,theta
u(1)=.1;
u(2)=0;
u(3)=0;
 if (mod(k,num_steps/4))==0
 u(1)=0;
 u(3)=pi/2;
 end;
  %%updating pose:
 %% Here the pose of the robot "x" should be updated with the control action
 xtrue=pose_comp(xtrue,u);
 %%Drawing

 uruid=pose_comp(u,randn(1,3)*sqrt(Q));
x=pose_comp(x,uruid);
 plot(xtrue(1),xtrue(2),'k.');
 plot(x(1),x(2),'o','color',[1,0,1]);
for i=1:100
 uruid=pose_comp(u,randn(1,3)*sqrt(Q));
 particles(1:3,i)=pose_comp(particles(1:3,i),uruid);
 particles(4,i)=exp(-0.5*(GetLandMark_error(x,map,land)-GetLandMark_error(particles(1:3,i),map,land))'*inv(Sigma_sensor)*(GetLandMark_error(x,map,land)-GetLandMark_error(particles(1:3,i),map,land)))+0.001;
end
if (mod(k,5))==0
plot(particles(1,:),particles(2,:),'*','markers',5);
plot([map(1,land) xtrue(1)],[map(2,land) xtrue(2)],'linewidth',2,'color',[1,0,0]);
plot(xtrue(1),xtrue(2),'o','markers',10);



end
 %%
 %%% Compute the cumulative densitity function as:
CDF=cumsum( particles(4,:))/sum( particles(4,:));
%%% Select n_samples random numbers from the standard uniform
%%% distribution [0,1)
iSelect=rand(100,1);

%%%Interpolate the values randomly selected: options nearest
%%and extrap are needed to avoid values out of range. iNext are
%%the indexes of the chosen particles

iNext=interp1(CDF,1:100,iSelect,'nearest','extrap');
iNextt=iNext.';
%%%Update the samples set.  Some particles can be repetitions
particles=particles(:,iNextt);
est_particle=[mean(particles(1,:));mean(particles(2,:))];

if (mod(k,5))==0
plot(est_particle(1),est_particle(2),'x','markers',7,'Color',[1,0.5,0]);
end

%text(xtrue(1)+1,xtrue(2)+1,'robot');

 %a small pause to see the animation
 pause(0.025);
 %increment the value of k
 k=k+1;
 %making the robot moves.
 %if (~isempty(r)), delete(r);end;
end
