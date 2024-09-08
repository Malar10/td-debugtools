

pos = {x=400, y=100}
size = {x=1000, y=500}
range = {x={-0.2, 1.5}, y={-0.2, 1.5}}
precision = 0.1
newText = ""
oldtext = ""

function tick()

end

function draw()

    UiFont("regular.ttf", 30)
    UiTranslate(pos.x, pos.y)
    
    UiRectOutline(size.x, size.y, 1)
    UiPush()
    UiWindow(size.x, size.y, true)
    --UiRect(size.x, size.y)

    xsize = size.x / (range.x[2] - range.x[1])
    ysize = size.y / (range.y[2] - range.y[1])

    origo = {x = -range.x[1]*xsize, y = range.y[2]*ysize}
    drawAxes()

    
    UiTranslate(0, range.y[2]*ysize)
    UiColor(1, 0, 0, 1)
    --for p=range.x[1]/precision, range.x[2]/precision do
    for i=0, size.x * precision do
        UiPush()
            j = i / precision
            --x = p*precision
            x = range.x[1] + j/xsize
            --i = x - range.x[1]
            y = func(x)

            UiTranslate(j, -(y*ysize))
            UiRect(4, 4)
        UiPop()
    end
    UiPop()

    --text input
    UiTranslate(size.x + 40, 20)

    precision = coolSlider("precision", "ui/common/circle_filled_12x12.png", "x", precision, 0.05, 1, 400)
    UiTranslate(0, 50)

    range.x[1] = coolSlider("x0", "ui/common/circle_filled_12x12.png", "x", range.x[1], -100, 0, 400)
    UiTranslate(0, 50)

    range.x[2] = coolSlider("x1", "ui/common/circle_filled_12x12.png", "x", range.x[2], 0, 100, 400)
    UiTranslate(0, 50)

    range.y[1] = coolSlider("y0", "ui/common/circle_filled_12x12.png", "x", range.y[1], -100, 0, 400)
    UiTranslate(0, 50)

    range.y[2] = coolSlider("y1", "ui/common/circle_filled_12x12.png", "x", range.y[2], 0, 100, 400)
    UiTranslate(0, 50)

    UiMakeInteractive()
    UiAlign("left middle")
    
    w = UiText("y = ")
    UiTranslate(w + 5)
    UiImageBox("ui/common/box-outline-4.png", 400, 42, 12, 12)
    local newText = UiTextInput(oldtext, 400, 42, false)
    oldtext = newText
    if InputPressed("return") then
        --DebugPrint("pressed return")
        newText = ""
        assert(loadstring("function func(x) return "..oldtext.." end"))()
    end
end

function func(x)
    c4 = (2 * math.pi) / 3
    if x == 0 then
        return 0
    else
        return math.pow(2, -10 * x) * math.sin((x*10-0.75)*c4)+1
    end
end

function drawAxes()
    UiFont("regular.ttf", 20)
    
    --x axis
    UiPush()
        UiTranslate(0, origo.y)
        UiRect(size.x, 1)
    UiPop()
    UiPush()
        UiTranslate(origo.x, 0)
        UiRect(1, size.y)
    UiPop()

    UiPush()
        UiTranslate(origo.x, origo.y)
        UiAlign("center middle")

        UiPush()
            for x = 0, range.x[2] do
                if x~= 0 then
                    UiPush()
                    UiTranslate(0, 20)
                    UiText(x)
                    UiPop()
                end
                UiTranslate(xsize, 0)
                UiRect(1, 20)
            end
        UiPop()

        UiPush()
            for x = 0, range.x[1], -1 do
                if x~= 0 then
                    UiPush()
                    UiTranslate(0, 20)
                    UiText(x)
                    UiPop()
                end
                UiTranslate(-xsize, 0)
                UiRect(1, 20)
            end
        UiPop()

        --y axis
        UiPush()
            for y = 0, range.y[2] do
                if y~= 0 then
                    UiPush()
                    UiTranslate(20, 0)
                    UiText(y)
                    UiPop()
                end
                UiTranslate(0, -ysize)
                UiRect(20, 1)
            end
        UiPop()

        UiPush()
            for y = 0, range.y[1], -1 do
                if y~= 0 then
                    UiPush()
                    UiTranslate(20, 0)
                    UiText(y)
                    UiPop()
                end
                UiTranslate(0, ysize)
                UiRect(20, 1)
            end
        UiPop()
    UiPop()
end

function coolSlider(text, path, axis, current, min, max, width)
    sliderwidth = 200

    UiPush()
        UiFont("regular.ttf", 40)
        UiAlign("left middle")
        UiText(text)
        UiTranslate(width-sliderwidth, 0)

        UiAlign("right middle")
        UiText(string.format("%.1f", current))
        UiTranslate(20, 0)

        UiAlign("left middle")
        UiPush()
            UiTranslate(6,0)
            UiRect(sliderwidth, 5)
        UiPop()
        scaled = (current-min) / (max-min)
        UiSliderThumbSize(45, 55)
        scaled = UiSlider(path, axis, scaled*sliderwidth, 0, sliderwidth) / sliderwidth
    UiPop()
    return (scaled * (max-min)) + min
end