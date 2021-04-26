function [c,ceq] = nonlconFoot(joint_angles,robot,param,joints0)
    %% Helper Functions
    position = @(transform) transform(1:3,4);
    rotation = @(transform) transform(1:3,1:3);
    %% Convert centerOfMass into foot space
    rCTt = centerOfMass(robot,joint_angles);
    %Keep CoM in support polygon (foot_space)
    RFTf = rotation(getTransform(robot,joint_angles,'torso',param.supportFoot));
    rTFf = position(getTransform(robot,joint_angles,'torso',param.supportFoot));
    rCFf = rTFf + RFTf*rCTt; %CoM to foot space
    %% Constraints
    c =[
        %Ensure CoM (foot space) is within support polygon
        rCFf(1)-0.115;...  %CoMx <= 0.115
        -rCFf(1)-0.115;... %CoMx >= -0.115
        rCFf(2)-0.065;...  %CoMy <= 0.065
        -rCFf(2)-0.065;... %CoMx <= -0.065
        %Ensure knees are bent backwards
        joint_angles(15) - pi/2;
        -joint_angles(15);
        joint_angles(4) - pi/2;
        -joint_angles(4);
        %Ensure next solution is within 0.75 rads of previous
        norm(joint_angles(1) - joints0(1)) - 1;
        norm(joint_angles(2) - joints0(2)) - 1;
        norm(joint_angles(3) - joints0(3)) - 1;
        norm(joint_angles(4) - joints0(4)) - 1;
        norm(joint_angles(5) - joints0(5)) - 1;
        norm(joint_angles(6) - joints0(6)) - 1;
        norm(joint_angles(12) - joints0(1)) - 1;
        norm(joint_angles(13) - joints0(2)) - 1;
        norm(joint_angles(14) - joints0(3)) - 1;
        norm(joint_angles(15) - joints0(4)) - 1;
        norm(joint_angles(16) - joints0(5)) - 1;
        norm(joint_angles(17) - joints0(6)) - 1;
       ];
   % Switch between locking support foot hips
   if(param.supportFoot == "left_foot")
    hip_yaw = joint_angles(1);
    hip_pitch = joint_angles(3);
    hip_roll = joint_angles(2);
   else
    hip_yaw = joint_angles(12);
    hip_pitch = joint_angles(13);
    hip_roll = joint_angles(14);
   end
   ceq =[
         %Keep upper body rigid
         joint_angles(7);
         joint_angles(8);
         joint_angles(9);
         joint_angles(18);
         joint_angles(19);
         joint_angles(20);
         joint_angles(11);
         %Keep support foot hip rigid
%          hip_yaw;
%          hip_pitch;
%          hip_roll;
         0;
         0;
         0;
        ];
end