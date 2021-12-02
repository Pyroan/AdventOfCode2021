-- truly some spaghetti but that's graphics for ya
function love.load()
    love.window.setMode(1000, 600)
    love.window.setTitle("Day 1")
    love.graphics.setFont(love.graphics.newFont(18))
    legend = love.graphics.newText(love.graphics.newFont(18), "sample text")
    scale = 1 / math.pi
    -- get data
    f = love.filesystem.read("day1.txt")
    l = {}
    for a in f:gmatch("%d+") do
        l[#l + 1] = tonumber(a)
    end
    i, k = 1, 1
    a, b = 0, 0
    circles = {}
end

function love.draw()
    w, h = love.graphics.getDimensions()
    -- background
    love.graphics.clear(0, 0.05, 0)
    love.graphics.setColor(0, 0.1, 0)
    love.graphics.setLineWidth(4)
    for j = 1, 6 do
        love.graphics.line(w / 2, h / 2, math.cos(2 * math.pi * (j + 0.5) / 6) * 1000 + w / 2,
            math.sin(2 * math.pi * (j + 0.5) / 6) * 1000 + h / 2)
    end
    for j = 1, 10 do
        love.graphics.circle("line", w / 2, h / 2, j * 200 * scale)
        love.graphics.print(j * 200, w / 2 + 5, h / 2 - (j * 200 * scale) - 24)
    end
    -- line
    love.graphics.setLineWidth(1)
    for j = math.max(1, i - 200), i - 1 do
        local f = 1 - (i - j) / 200
        c = l[j + 1] > l[j] and {0, 1, 0, f * f * 0.8} or {0, 0, 0, f * f * 0.8}
        love.graphics.setColor(c)
        love.graphics.circle("line", w / 2, h / 2, j * scale)
    end
    for j = math.max(1, k - 200), k - 1 do
        local f = 1 - (k - j) / 200
        c = l[j + 3] > l[j] and {1, 0, 0, f * f * 0.8} or {0, 0, 0, f * f * 0.8}
        love.graphics.setColor(c)
        love.graphics.circle("line", w / 2, h / 2, j * scale)
    end
    love.graphics.setColor(0, 1, 0)
    love.graphics.circle("line", w / 2, h / 2, i * scale)
    love.graphics.setColor(1, 0, 0)
    love.graphics.circle("line", w / 2, h / 2, k * scale)
    -- legend
    love.graphics.setColor(0, 0, 0, 0.2)
    tw, th = legend:getDimensions()
    love.graphics.rectangle("fill", w / 2 - tw / 2 - 10, 35, tw + 20, th + 10)
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(legend, math.floor(w / 2 - tw / 2), 40)
end

function love.update(dt)
    if i <= #l - 1 then
        if l[i + 1] > l[i] then
            a = a + 1
        end
        i = i + 1
    end
    if i >= 250 and k <= #l - 3 then
        if l[k + 3] > l[k] then
            b = b + 1
        end
        k = k + 1
    end
    legend:set({{0, 1, 0}, "Part 1: " .. a, {1, 0, 0}, "\nPart 2: " .. b})
end
