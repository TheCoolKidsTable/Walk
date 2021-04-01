function output = initialConditions
l_hip_yaw = 0.02923973;
l_hip_roll = 0.06261409;
l_ankle_roll = -0.06909663;
r_hip_yaw = -0.02923973;
r_hip_roll = -0.06261409;
r_ankle_roll = 0.06909663;
r_shoulder_pitch = 1.963495;
r_shoulder_roll = -0.1239184;
r_elbow_pitch = -2.443461;
l_shoulder_pitch = 1.963495;
l_shoulder_roll = 0.1239184;
l_elbow_pitch = -2.443461;
l_ankle_pitch = -0.2623748;
l_knee_pitch = 0.2945004;
l_hip_pitch = -0.207138;
r_ankle_pitch = -0.2623748;
r_knee_pitch = 0.2945004;
r_hip_pitch = -0.207138;
neck_yaw = 0;
head_pitch = 0;
output = [
            l_hip_yaw;
            l_hip_roll;
            l_hip_pitch;         
            l_knee_pitch;
            l_ankle_pitch;          
            l_ankle_roll;
            l_shoulder_pitch;
            l_shoulder_roll;
            l_elbow_pitch;
            neck_yaw;
            head_pitch;
            r_hip_yaw;
            r_hip_roll;
            r_hip_pitch;
            r_knee_pitch;            
            r_ankle_pitch; 
            r_ankle_roll;        
            r_shoulder_pitch;
            r_shoulder_roll;
            r_elbow_pitch;       
];
end
