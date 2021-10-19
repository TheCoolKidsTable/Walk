function rpy = rot2rpy(R)
 rpy = [atan2(R(3,2), R(3,3)), ...
        atan2(-R(3,1),sqrt(R(3,2)^2+R(3,3)^2)),...
        atan2(R(2,1),R(1,1))];
end