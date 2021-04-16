function [opt_joint_angles] = inverseKinematics(robot,trajectory,param)
%% Helper Functions
position = @(transform) transform(1:3,4);
rotation = @(transform) transform(1:3,1:3);
%% Run optimization
sim_time = length(trajectory);
opt_joint_angles = zeros(param.NumBodies,sim_time);
joints0 = param.initialConditions;
for i = 1:sim_time
    cost = @(joint_angles) norm(rotation(getTransform(robot,joint_angles,param.supportFoot))*trajectory(:,i) - position(getTransform(robot,joint_angles,param.swingFoot,param.supportFoot))) ...
                           + 0.5*trace(eye(3)-rotation(getTransform(robot,joint_angles,param.supportFoot,param.swingFoot)));
    A = [];
    b = [];
    Aeq = [];
    beq = [];
    lb = [];
    ub = [];
    nlconstraint = @(joint_angles) nonlconFoot(joint_angles,robot,param);
    [joints_opt] = fmincon(cost,joints0,A,b,Aeq,beq,lb,ub,nlconstraint);
    joints0 = joints_opt; %warm-start next optimization
    opt_joint_angles(:,i) = joints_opt;
end
end

