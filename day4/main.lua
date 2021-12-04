function love.load()
    love.window.setMode(1000, 600)
    love.window.setTitle("Day 4")
    love.graphics.setFont(love.graphics.newFont(18))
    love.graphics.setLineStyle("rough")
    scale = 1 / 1
    -- get data
    f = love.filesystem.read("day4.txt")
    numbers = {}
    legend = love.graphics.newText(love.graphics.newFont(18), "sample text")
    initBackground()
    boards = {}
    for i = 1, 100 do
        boards[i] = initBoard(220 + 55 * ((i - 1) % 10), 20 + 55 * math.floor((i - 1) / 10), {})
    end
    -- a real hornkin' mess of string processing.
    lines = {}
    for line in f:gmatch("[^\n]+\n") do
        lines[#lines + 1] = line
    end
    -- drawn numbers
    for s in lines[1]:gmatch("%d+") do
        numbers[#numbers + 1] = s
    end
    -- boards
    for i = 2, #lines, 5 do
        data = {}
        for j = 1, 5 do
            data[j] = {}
            for d in lines[i + j - 1]:gmatch("%d+") do
                data[j][#data[j] + 1] = d
            end
        end
        boards[(i - 2) / 5 + 1].data = data
    end
    winOrder = {}
    index = 1
    love.timer.sleep(1) -- so the window has time to load before things start
end

function love.draw()
    w, h = love.graphics.getDimensions()
    love.graphics.draw(background)
    -- boards
    love.graphics.setLineWidth(1)
    for _, board in ipairs(boards) do
        drawBoard(board)
    end
    -- legend
    love.graphics.setColor(0, 0, 0, 0.2)
    tw, th = legend:getDimensions()
    love.graphics.rectangle("fill", w / 2 - tw / 2 - 10, 35, tw + 20, th + 10)
    love.graphics.setColor(1, 1, 1)
    -- love.graphics.draw(legend, math.floor(w / 2 - tw / 2), 40)
end

function love.update(dt)
    if index <= 100 then
        legend:set(numbers[index])
        for _, board in ipairs(boards) do
            updateBoard(board)
        end
        index = index + 1
        love.timer.sleep(3 / 60)
    end
end

function initBackground()
    -- make background canvas
    background = love.graphics.newCanvas()
    love.graphics.setCanvas(background)
    w, h = love.graphics.getDimensions()
    -- background
    love.graphics.clear(28 / 255, 5 / 255, 31 / 255)
    -- love.graphics.setLineWidth(2)
    -- love.graphics.setColor(46 / 255, 13 / 255, 51 / 255)
    -- for i = 5, w, 55 do
    --     love.graphics.line(i, 1, i, h)
    -- end
    -- for i = 25, h, 55 do
    --     love.graphics.line(1, i, w, i)
    -- end
    love.graphics.setCanvas()
end

function initBoard(x, y, data)
    return {
        x = x,
        y = y,
        data = data,
        truth = {{0, 0, 0, 0, 0}, {0, 0, 0, 0, 0}, {0, 0, 0, 0, 0}, {0, 0, 0, 0, 0}, {0, 0, 0, 0, 0}},
        isWinner = false,
        winningLine = {}
    }
end

function updateBoard(board)
    if not board.isWinner then
        for i = 1, 5 do
            for j = 1, 5 do
                if board.data[i][j] == numbers[index] then
                    board.truth[i][j] = 1
                end
            end
        end
        -- check if we're a isWinner
        for i = 1, 5 do
            rowCount, colCount = 0, 0
            for j = 1, 5 do
                -- check row
                rowCount = rowCount + board.truth[i][j]
                -- check column
                colCount = colCount + board.truth[j][i]
            end
            if rowCount >= 5 then
                board.isWinner = true
                board.winningLine = {'row', i}
                winOrder[#winOrder + 1] = board

            elseif colCount >= 5 then
                board.isWinner = true
                board.winningLine = {'col', i}
                winOrder[#winOrder + 1] = board
            end
        end
    end
end

function drawBoard(board)
    for i = 1, 5 do
        for j = 1, 5 do
            atten = 1 - #winOrder / 100 + 0.3
            if board.truth[i][j] > 0 then
                if board.isWinner then
                    if (board.winningLine[1] == 'row' and board.winningLine[2] == i) or
                        (board.winningLine[1] == 'col' and board.winningLine[2] == j) then
                        if winOrder[1] == board then
                            love.graphics.setColor(1, 0.882, 0)
                        elseif winOrder[100] == board then
                            love.graphics.setColor(1, 0.2, 0.2)
                        else
                            love.graphics.setColor(226 / 255, 176 / 255, 232 / 255, atten)
                        end
                    else
                        if winOrder[1] == board then
                            love.graphics.setColor(0.5, 0.441, 0)
                        elseif winOrder[100] == board then
                            love.graphics.setColor(0.5, 0, 0)
                        else
                            love.graphics.setColor(226 / 255, 176 / 255, 232 / 255, 0.5 * atten)
                        end

                    end
                else
                    love.graphics.setColor(226 / 255, 176 / 255, 232 / 255)
                end
            else
                if board.isWinner then
                    if winOrder[1] == board then
                        love.graphics.setColor(0.2, 0.176, 0)
                    elseif winOrder[100] == board then
                        love.graphics.setColor(0.2, 0.0, 0.0)
                    else
                        love.graphics.setColor(98 / 255, 47 / 255, 105 / 255, 0.2 * atten)
                    end
                else
                    love.graphics.setColor(98 / 255, 47 / 255, 105 / 255)
                end
            end
            love.graphics.rectangle('fill', board.x + 10 * i, board.y + 10 * j, 5, 5)
        end
    end
end
