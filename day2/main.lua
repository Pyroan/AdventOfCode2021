-- only handles part 1
function love.load()
    love.window.setMode(1000, 600)
    love.window.setTitle("Day 2, Part 1")
    love.graphics.setFont(love.graphics.newFont(18))
    legend = love.graphics.newText(love.graphics.newFont(18), "blugh")
    points = {0, 0}
    err = ""
    f = love.filesystem.read("day2.txt")
    l = {}
    for a, b in f:gmatch("(%a+) (%d+)") do
        l[#l + 1] = {a, b}
    end
    i = 1
end

function love.draw()

    -- depth gauge
    layers = math.ceil(love.graphics.getHeight() / 50)
    for i = 0, layers do
        love.graphics.setColor(0, (1 - i / layers) * 0.2, (1 - i / layers) * 0.2)
        love.graphics.rectangle("fill", 0, i * 50, love.graphics.getWidth(), (i + 1) * 50)
        love.graphics.setColor(1, 1, 1, 0.2)
        love.graphics.print(i * 100, 50, i * 50 - 24)
    end
    -- legend
    love.graphics.setColor(0, 0, 0, 0.2)
    w, h = legend:getDimensions()
    love.graphics.rectangle("fill", love.graphics.getWidth() / 2 - w / 2 - 10, 35, w + 20, h + 10)
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(legend, math.floor(love.graphics.getWidth() / 2 - legend:getWidth() / 2), 40)
    -- line
    love.graphics.setLineStyle("rough")
    love.graphics.setLineWidth(2)
    for j = 3, #points, 2 do
        love.graphics.setColor(5 / (#points - j), 80 / (#points - j), 1, 1)
        love.graphics.line(points[j - 2] * 0.5, points[j - 1] * 0.5, points[j] * 0.5, points[j + 1] * 0.5)
    end
end

function love.update(dt)
    if i <= #l then
        x, y = 0, 0
        if l[i][1] == "forward" then
            x = l[i][2]
        elseif l[i][1] == "down" then
            y = l[i][2]
        elseif l[i][1] == "up" then
            y = -l[i][2]
        end
        points[#points + 1] = points[#points - 1] + x
        points[#points + 1] = points[#points - 1] + y
        i = i + 1
        legend:set({{0, 1, 1}, "x = " .. points[#points - 1] .. ", y = " .. points[#points]})
    else
        legend:set({{0, 1, 1}, "x = " .. points[#points - 1] .. ", y = " .. points[#points] .. "\n", {1, 1, 1},
                    "Answer: " .. points[#points - 1] * points[#points]})
    end

end
