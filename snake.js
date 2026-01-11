const canvas = document.getElementById('gameCanvas');
const ctx = canvas.getContext('2d');

canvas.width = 400;
canvas.height = 400;

let snake = [{ x: 200, y: 200 }];
let direction = { x: 0, y: 0 };
let food = { x: Math.floor(Math.random() * 20) * 20, y: Math.floor(Math.random() * 20) * 20 };

function draw() {
    ctx.clearRect(0, 0, canvas.width, canvas.height);

    // Draw snake
    ctx.fillStyle = 'green';
    snake.forEach(segment => {
        ctx.fillRect(segment.x, segment.y, 20, 20);
    });

    // Draw food
    ctx.fillStyle = 'red';
    ctx.fillRect(food.x, food.y, 20, 20);
}

function update() {
    const head = { x: snake[0].x + direction.x, y: snake[0].y + direction.y };

    // Check for collision with walls
    if (head.x < 0 || head.x >= canvas.width || head.y < 0 || head.y >= canvas.height) {
        alert('Game Over');
        document.location.reload();
        return;
    }

    // Check for collision with self
    for (let i = 1; i < snake.length; i++) {
        if (head.x === snake[i].x && head.y === snake[i].y) {
            alert('Game Over');
            document.location.reload();
            return;
        }
    }

    snake.unshift(head);

    // Check for collision with food
    if (head.x === food.x && head.y === food.y) {
        food = { x: Math.floor(Math.random() * 20) * 20, y: Math.floor(Math.random() * 20) * 20 };
    } else {
        snake.pop();
    }
}

function changeDirection(event) {
    const keyPressed = event.keyCode;
    const LEFT_KEY = 37;
    const RIGHT_KEY = 39;
    const UP_KEY = 38;
    const DOWN_KEY = 40;

    const goingUp = direction.y === -20;
    const goingDown = direction.y === 20;
    const goingRight = direction.x === 20;
    const goingLeft = direction.x === -20;

    if (keyPressed === LEFT_KEY && !goingRight) {
        direction = { x: -20, y: 0 };
    }
    if (keyPressed === UP_KEY && !goingDown) {
        direction = { x: 0, y: -20 };
    }
    if (keyPressed === RIGHT_KEY && !goingLeft) {
        direction = { x: 20, y: 0 };
    }
    if (keyPressed === DOWN_KEY && !goingUp) {
        direction = { x: 0, y: 20 };
    }
}

document.addEventListener('keydown', changeDirection);

function gameLoop() {
    update();
    draw();
    setTimeout(gameLoop, 100);
}

gameLoop();
