function output = plot3DRobot(opt_jointAngles,robot,param,trajectory)
close all;
%% Helper Functions
position = @(transform) transform(1:3,4);
%% Plot Robot Configurations
figure
init = zeros(param.numBodies,1)
show(robot,init);
view(2)
ax = gca;
ax.View = [0 0]
ax.Projection = 'orthographic';
hold on
%convert trajectory to torso space
framesPerSecond = 5;
r = rateControl(framesPerSecond);
%plot support polygon/convex hull
k = [0.115, 0.065;
    -0.115, 0.065;
    -0.115, -0.065;
    0.115, -0.065;
    0.115, 0.065;];
%% Initialize video
center = zeros(4,param.numSamples);
supportFootPosition = zeros(3,param.numSamples);
swingFoot = zeros(3,param.numSamples);
for i = 1:length(opt_jointAngles)
    Htf = getTransform(robot,opt_jointAngles(:,i),'base',param.supportFoot)
    center(:,i) = Htf*[centerOfMass(robot,opt_jointAngles(:,i));1];
    supportFootPosition(:,i) = position(getTransform(robot,opt_jointAngles(:,i),param.supportFoot));
    swingFoot(:,i) = position(getTransform(robot,opt_jointAngles(:,i),param.swingFoot,param.supportFoot));
%     p = plot3(center(1,i),center(2,i),center(3,i),'o');
    show(robot,opt_jointAngles(:,i),'PreservePlot',false);
    drawnow
    waitfor(r);
end
%% Plot CoM position
n = size(opt_jointAngles,2);
figure(2)
subplot(4,1,1);
plot(swingFoot(1,:),'LineWidth',5)
hold on;
plot(trajectory(1,:),'--','LineWidth',5)
legend('x_e(1) [m]','x^*_e(1) [m]');
xlabel('Sample [ΔT]');
ylabel('Position [m]');
title('End effector X position [m]');
subplot(4,1,2);
plot(swingFoot(2,:),'LineWidth',5)
hold on;
plot(trajectory(2,:),'--','LineWidth',5)
legend('x_e(2) [m]','x^*_e(2) [m]');
xlabel('Sample [ΔT]');
ylabel('Position [m]');
title('End effector Y position [m]');
subplot(4,1,3);
plot(swingFoot(3,:),'LineWidth',5)
hold on;
plot(trajectory(3,:),'--','LineWidth',5)
legend('x_e(3) [m]','x^*_e(3) [m]');
xlabel('Sample [ΔT]');
ylabel('Position [m]');
title('End effector Z position [m]');
subplot(4,1,4);
hold on;
plot(ones(1,n)*0.075,'--');
hold on;
plot(ones(1,n)*-0.075,'--');
hold on;
plot(center(1,:),'LineWidth', 5);
legend('CoM upper limit [m] (support foot space)','CoM lower limit [m] (support foot space)','CoM position [m](support foot space)');
xlabel('Sample [ΔT]');
ylabel('Position [m]');
title('2D Quasi-static Constraints');

end

