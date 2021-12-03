function love.load()
    love.window.setMode(1000, 600)
    love.window.setTitle("Day 3, Part 2")
    love.graphics.setFont(love.graphics.newFont(18))
    love.graphics.setLineStyle("rough")
    scale = 1 / 1
    -- get data
    f = love.filesystem.read("day3.txt")
    l = {}
    bars = {initBar("O2", 100, {1, 0.882, 0}, {'0', '1'}), initBar("CO2", 300, {0, 1, 1}, {'1', '0'})}

    for s in f:gmatch("%d+") do
        l[#l + 1] = s
        for _, bar in ipairs(bars) do
            bar.truth[#l] = true
        end
    end
    initBackground()
    love.timer.sleep(1) -- so the window has time to load before things start
end
-- two phases here that loop: the Scan phase, and the Elimination phase.
-- elimination phase should look like it happens in a random order, ideally.

function love.draw()
    w, h = love.graphics.getDimensions()
    love.graphics.draw(background)
    -- bars
    love.graphics.setLineWidth(1)
    for _, bar in ipairs(bars) do
        drawBar(bar)
    end
end

function love.update(dt)
    for _, bar in ipairs(bars) do
        updateBar(bar)
    end
end

function initBackground()
    -- make background canvas
    background = love.graphics.newCanvas()
    love.graphics.setCanvas(background)
    w, h = love.graphics.getDimensions()
    -- background
    love.graphics.clear(0.122, 0.0784, 0.012)
    love.graphics.setLineWidth(4)
    love.graphics.setColor(54 / 255, 42 / 255, 7 / 255)
    for i = 1, h, 8 do
        love.graphics.line(1, i, w, i)
    end
    love.graphics.setCanvas()
end

function initBar(name, y, c, ref)
    return {
        name = name,
        y = y,
        c = c,
        ref = ref,
        truth = {},
        i = 1,
        r = 1,
        state = "scan",
        count = {0, 0},
        legend = love.graphics.newText(love.graphics.newFont(18), "sample text")
    }
end

function updateBar(bar)
    if bar.state == "scan" then
        repeat
            bar.i = bar.i + 1
        until bar.truth[bar.i] or bar.i >= #l
        if bar.truth[bar.i] then
            if l[bar.i]:sub(bar.r, bar.r) == '1' then
                bar.count[2] = bar.count[2] + 1
            else
                bar.count[1] = bar.count[1] + 1
            end
            bar.legend:set({bar.c, bar.name .. ': ' .. l[bar.i]})
        else
            bar.state = "eliminate"
        end

    end
    if bar.state == "eliminate" then
        if bar.count[1] + bar.count[2] ~= 1 then
            for k = 1, #l do
                if bar.count[2] >= bar.count[1] then
                    bar.truth[k] = bar.truth[k] and l[k]:sub(bar.r, bar.r) == bar.ref[2]
                else
                    bar.truth[k] = bar.truth[k] and l[k]:sub(bar.r, bar.r) == bar.ref[1]
                end
            end

            bar.r = bar.r + 1
            bar.i = 1
            bar.count = {0, 0}
            bar.state = "scan"
        else
            for k = 1, #l do
                if bar.truth[k] then
                    bar.i = k
                    break
                end
            end
            bar.c = {0, 1, 0}
            bar.legend:set({bar.c, bar.name .. ': ' .. l[bar.i]})
            bar.state = "solved"
        end
    end
end
function drawBar(bar)
    -- base layer
    love.graphics.setColor(0, 0, 0, 0.2)
    love.graphics.rectangle('fill', 1, bar.y + 50 - 2, w, 100 + 2)
    local r, g, b = bar.c[1], bar.c[2], bar.c[3]
    for k = 1, 1000 do
        if k < bar.i then
            atten = 1 - math.min(200, bar.i - k) / 200
        else
            atten = 0
        end
        love.graphics.setColor(r, g, b, atten * atten + 0.2)
        if bar.truth[k] then
            love.graphics.line(k, bar.y + 50, k, bar.y + 150)
        end
    end
    -- "active" layer: display current index if we're scanning,
    -- or the guy who just got turned off we're eliminating.
    if bar.state == "scan" then
        love.graphics.setColor(1, 0, 0)
        love.graphics.line(bar.i, bar.y + 50 - 2, bar.i, bar.y + 150 + 2)
    elseif bar.state == "eliminate" then
    elseif bar.state == "solved" then
        love.graphics.setColor(0, 1, 0)
        love.graphics.line(bar.i, bar.y + 50 - 2, bar.i, bar.y + 150 + 2)
    end
    -- legend
    love.graphics.setColor(0, 0, 0, 0.2)
    tw, th = bar.legend:getDimensions()
    love.graphics.rectangle("fill", w / 2 - tw / 2 - 10, bar.y, tw + 20, th + 10)
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(bar.legend, math.floor(w / 2 - tw / 2), bar.y + 5)
end
