#include "recorder.lua"

function init()
    heighttrack = createTracker("height", 100)
    speedtrack = createTracker("speed", 100)
    randomtrack = createTracker("random", 100)
end

function tick()
    trackvalue(heighttrack, GetPlayerTransform().pos[2])
    trackvalue(speedtrack, VecLength(GetPlayerVelocity()))
    trackvalue(randomtrack, math.random())
end