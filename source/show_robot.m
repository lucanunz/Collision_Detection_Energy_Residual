close all
clear variables
clc

L1=0.5; % link lengths [m]  
L2=0.5;
L3=0.4;
r1=0.2; 
r2=0.1;
r3=0.1; 
dhparams = [0   	pi/2	L1   	0;
            L2      0       0       0;
            L3      0       0   	0];

robot = rigidBodyTree;
body1 = rigidBody('body1');
jnt1 = rigidBodyJoint('jnt1','revolute');

setFixedTransform(jnt1,dhparams(1,:),'dh');
body1.Joint = jnt1;

addBody(robot,body1,'base');
body2 = rigidBody('body2');
jnt2 = rigidBodyJoint('jnt2','revolute');
body3 = rigidBody('body3');
jnt3 = rigidBodyJoint('jnt3','revolute');

setFixedTransform(jnt2,dhparams(2,:),'dh');
setFixedTransform(jnt3,dhparams(3,:),'dh');

body2.Joint = jnt2;
body3.Joint = jnt3;

addBody(robot,body2,'body1');
addBody(robot,body3,'body2');

showdetails(robot)

mat1 = [elem_rot_mat('x',pi/2) [0 -L1/2 0]';
        zeros(1,3)             1];
mat2 = [elem_rot_mat('y',pi/2)  [-L2/2 0 0]';
        zeros(1,3)             1];
mat3 = [elem_rot_mat('y',pi/2)  [-L3/2 0 0]';
        zeros(1,3)             1];
cylinder1 = collisionCylinder(r1,L1);
cylinder2 = collisionCylinder(r2,L2);
cylinder3 = collisionCylinder(r3,L3);
cylinder1.Pose = mat1;
cylinder2.Pose = mat2;
cylinder3.Pose = mat3;
addCollision(robot.Bodies{1},cylinder1);
addCollision(robot.Bodies{2},cylinder2);
addCollision(robot.Bodies{3},cylinder3);
show(robot,'Collisions','on','Visuals','off');