-- Pong — fill in the TODOs to make it playable.
--
-- Run from the project root:
--     love pong
--
-- Controls:
--     Left paddle:  W / S
--     Right paddle: Up / Down arrows
--     Quit:         Escape

-- ─────────────────────────────────────────────────────────────
-- File-scope state (local = scoped to this file, not global)
-- ─────────────────────────────────────────────────────────────
local PADDLE_WIDTH  = 15
local PADDLE_HEIGHT = 100
local PADDLE_SPEED  = 400   -- pixels per second
local BALL_SPEEDUP  = 1.08  -- ball gets 8% faster on every paddle hit

local leftPaddle, rightPaddle, ball
local leftScore, rightScore

-- Reset ball to center. direction = -1 (left) or 1 (right)
local function resetBall(direction)
    ball.x = 400
    ball.y = 300
    ball.dx = 300 * direction
    ball.dy = 200
end

-- ─────────────────────────────────────────────────────────────
-- love.load() runs once at startup. Set up your initial state.
-- ─────────────────────────────────────────────────────────────
function love.load()
    love.window.setTitle("Pong")
    love.window.setMode(800, 600)

    leftPaddle  = { x = 30,                              y = 250 }
    rightPaddle = { x = 800 - 30 - PADDLE_WIDTH,         y = 250 }
    ball        = { x = 400, y = 300, size = 15, dx = 300, dy = 200 }

    leftScore  = 0
    rightScore = 0
end

-- ─────────────────────────────────────────────────────────────
-- love.update(dt) runs ~60 times per second.
-- dt = seconds since last frame. Multiply movement by dt so
-- the game runs at the same speed regardless of framerate.
-- ─────────────────────────────────────────────────────────────
function love.update(dt)
    -- Left paddle: W moves up, S moves down
    if love.keyboard.isDown("w") then
        leftPaddle.y = leftPaddle.y - PADDLE_SPEED * dt
    end
    if love.keyboard.isDown("s") then
        leftPaddle.y = leftPaddle.y + PADDLE_SPEED * dt
    end
    if love.keyboard.isDown("up") then
        rightPaddle.y = rightPaddle.y - PADDLE_SPEED * dt
    end
    if love.keyboard.isDown("down") then
        rightPaddle.y = rightPaddle.y + PADDLE_SPEED * dt
    end


    -- Move the ball
    ball.x = ball.x + ball.dx * dt
    ball.y = ball.y + ball.dy * dt

    -- Bounce off the top and bottom walls
    if ball.y < 0 then
        ball.y = 0
        ball.dy = -ball.dy
    end
    if ball.y + ball.size > 600 then
        ball.y = 600 - ball.size
        ball.dy = -ball.dy
    end

    -- Bounce off the LEFT paddle (axis-aligned box overlap)
    if ball.x < leftPaddle.x + PADDLE_WIDTH and
       ball.x + ball.size > leftPaddle.x and
       ball.y < leftPaddle.y + PADDLE_HEIGHT and
       ball.y + ball.size > leftPaddle.y then
        ball.dx = -ball.dx * BALL_SPEEDUP
        ball.dy = ball.dy * BALL_SPEEDUP
    end

    -- Bounce off the RIGHT paddle (same check, against rightPaddle)
    if ball.x < rightPaddle.x + PADDLE_WIDTH and
       ball.x + ball.size > rightPaddle.x and
       ball.y < rightPaddle.y + PADDLE_HEIGHT and
       ball.y + ball.size > rightPaddle.y then
        ball.dx = -ball.dx * BALL_SPEEDUP
        ball.dy = ball.dy * BALL_SPEEDUP
    end

    -- Scoring: ball goes off left edge → right player scores
    if ball.x + ball.size < 0 then
        rightScore = rightScore + 1
        resetBall(-1)
    end

    -- Scoring: ball goes off right edge → left player scores
    if ball.x > 800 then
        leftScore = leftScore + 1
        resetBall(1)
    end
end

-- ─────────────────────────────────────────────────────────────
-- love.draw() runs every frame after update. Draw the world.
-- ─────────────────────────────────────────────────────────────
function love.draw()
    -- Center line (dashed)
    for y = 0, 600, 20 do
        love.graphics.rectangle("fill", 399, y, 2, 10)
    end

    -- Paddles
    love.graphics.rectangle("fill", leftPaddle.x,  leftPaddle.y,  PADDLE_WIDTH, PADDLE_HEIGHT)
    love.graphics.rectangle("fill", rightPaddle.x, rightPaddle.y, PADDLE_WIDTH, PADDLE_HEIGHT)

    -- Ball
    love.graphics.rectangle("fill", ball.x, ball.y, ball.size, ball.size)

    -- Score
    love.graphics.print(tostring(leftScore),  350, 20, 0, 3, 3)
    love.graphics.print(tostring(rightScore), 430, 20, 0, 3, 3)
end

-- ─────────────────────────────────────────────────────────────
-- love.keypressed(key) fires once per key press (not held).
-- ─────────────────────────────────────────────────────────────
function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end
