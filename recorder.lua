
size = {x=400, y=200}
trackers = {}

function draw()
    UiFont("regular.ttf", 20)
    UiTranslate(100, 100)
    for _, tracker in pairs(trackers) do
        UiText(tracker.title)
        UiTranslate(0, 10)
        drawTracker(tracker)
        UiTranslate(0, size.y + 50)
    end
end

function drawTracker(tracker)
    UiPush()
        --UiTranslate(pos.x, pos.y)
        UiPush()
            UiTranslate(size.x, 0)
            UiPush()
                UiAlign("left top")
                UiText(tracker.max)
            UiPop()
            UiTranslate(0, size.y)
            UiText(tracker.min)
        UiPop()

        UiWindow(size.x, size.y, true)
        UiRectOutline(size.x, size.y, 1)

        local width = size.x/tracker.maxvalues
        local range = tracker.max-tracker.min

        UiTranslate(0, size.y)
        for i=1, tracker.maxvalues-1 do
            UiPush()

                local v = tracker.values[i]
                if v ~= nil then
                    local t = (v-tracker.min) / range
                    UiTranslate(width*(i-1), -t*size.y)
                    --UiRect(width, 1)

                    local v2 = tracker.values[i+1]

                    if v2 ~= nil then
                        t2 = (v2-tracker.min) / range

                        UiLine(width, (-t2*size.y)-(-t*size.y))
                    end
                end
            UiPop()
        end
    UiPop()
end

function createTracker(title, maxvalues)
    local tracker = 
    {
        title = title,
        values = {},
        maxvalues = maxvalues,
        max = nil,
        min = nil
    }
    table.insert(trackers, tracker)
    return tracker
end

function trackvalue(tracker, v)
    --values[n%maxvalues] = v
    table.insert(tracker.values, v)
    if #tracker.values > tracker.maxvalues then
        table.remove(tracker.values, 1)
    end


    tracker.max = math.max(tracker.max or v, v) --set to v if nil
    tracker.min = math.min(tracker.min or v, v)
end

function getmaxmin()
    local max = nil
    local min = nil

    for i=1, maxvalues do
        v = values[i]
        if v ~= nil then
            max = math.max(max or v, v)
            min = math.min(min or v, v)
        end
    end

    return max, min
end

--start point cursor
--x,y = end point relative to cursor
function UiLine(x, y)
    UiPush()
        UiAlign("center bottom")

        local len = math.sqrt(x^2 + y^2)
        UiRotate(math.deg(math.atan2(-x, -y)))
        UiRect(1, len)
    UiPop()
end