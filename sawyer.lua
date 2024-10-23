sim=require'sim'

function moveToConfig(handles,maxVel,maxAccel,maxJerk,targetConf)
    local params = {
        joints = handles,
        targetPos = targetConf,
        maxVel = maxVel,
        maxAccel = maxAccel,
        maxJerk = maxJerk,
    }
    sim.moveToConfig(params)
end

function sysCall_thread()
    local jointHandles={}
    for i=1,7,1 do
        jointHandles[i]=sim.getObject('../joint',{index=i-1})
    end
    headCameraHandle=sim.getObject('../head_camera')
    sim.setExplicitHandling(headCameraHandle,1) -- disable the head camera
    wristCameraHandle=sim.getObject('../wristCamera')
    sim.setExplicitHandling(wristCameraHandle,1) -- disable the wrist camera


    -- Set-up some of the RML vectors:
    local accel=20
    local jerk=40
    local maxVel={84*math.pi/180,64*math.pi/180,95*math.pi/180,95*math.pi/180,170*math.pi/180,170*math.pi/180,221*math.pi/180}
    local maxAccel={accel*math.pi/180,accel*math.pi/180,accel*math.pi/180,accel*math.pi/180,accel*math.pi/180,accel*math.pi/180,accel*math.pi/180}
    local maxJerk={jerk*math.pi/180,jerk*math.pi/180,jerk*math.pi/180,jerk*math.pi/180,jerk*math.pi/180,jerk*math.pi/180,jerk*math.pi/180}

    local targetPos1={90*math.pi/180,0*math.pi/180,170*math.pi/180,90*math.pi/180,90*math.pi/180,90*math.pi/180,0}
    moveToConfig(jointHandles,maxVel,maxAccel,maxJerk,targetPos1)

    local targetPos2={-90*math.pi/180,-180*math.pi/180,180*math.pi/180,-90*math.pi/180,90*math.pi/180,90*math.pi/180,0}
    moveToConfig(jointHandles,maxVel,maxAccel,maxJerk,targetPos2)

    local targetPos3={0,-90*math.pi/180,0,0,0,0,0}
    moveToConfig(jointHandles,maxVel,maxAccel,maxJerk,targetPos3)
end