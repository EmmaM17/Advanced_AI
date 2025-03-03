board = ['-' '-' '-'; '-' '-' '-'; '-' '-' '-'];
x = 'X';
o = 'O';
finish = false;

% empty board
disp(board)
disp(' ');

% Who goes first
if randi([1, 2]) == 1
    player1 = x;
    player2 = o;
else
    player1 = o;
    player2 = x;
end

% Player1 starting position (random placement)
board(randi([1, 3]), randi([1, 3])) = player1;
disp(board);
disp(' ');


% Now play

while ~finish
    allPossibleMoves = place(board);
    
    % Player2 
    oppPositions = getPlayerPositions(player1, board);
    playerPositions = getPlayerPositions(player2, board);
    board = playGo(player2, playerPositions, oppPositions, board);
    
    % Check for winner 
    player1win = checkWin(board, player1);
    player2win = checkWin(board, player2);
    

    % Display winner if any
    if player1win
        disp('Player 1 wins!');
        break;
    elseif player2win
        disp('Player 2 wins!');
        break;
    elseif ~any(board(:) == '-') 
        disp('draw')
        break;
    else
        disp('No winner yet.');
    end

    % Player1
    oppPositions = getPlayerPositions(player2, board);
    playerPositions = getPlayerPositions(player1, board);
    board = playGo(player1, playerPositions, oppPositions, board);
    
    % Check for winner 
    player1win = checkWin(board, player1);
    player2win = checkWin(board, player2);
    

    % Display winner if any
    if player1win
        disp('Player 1 wins!');
        finish = true;
    elseif player2win
        disp('Player 2 wins!');
        finish = true;
    elseif ~any(board(:) == '-') 
        disp('draw')
        finish = true;
    else
        disp('No winner yet.');
    end


end

% Functions
function allPossibleMoves = place(board)
    [row, col] = find(board == '-');
    allPossibleMoves = [row, col];
end

function positions = getPlayerPositions(player, board)
    [row, col] = find(board == player);
    positions = [row, col];
end

function positions = checkNeighbour(positions2check, board)
    positions = [];
    for i = 1:size(positions2check, 1)
        row = positions2check(i, 1);
        col = positions2check(i, 2);
        
        % Check adjacent empty positions
        if row-1 >= 1 && col-1 >= 1 && board(row-1, col-1) == '-'  % top left
            positions = [positions; row-1, col-1];
        end
        if row-1 >= 1 && board(row-1, col) == '-'  % top middle
            positions = [positions; row-1, col];
        end
        if row-1 >= 1 && col+1 <= 3 && board(row-1, col+1) == '-'  % top right
            positions = [positions; row-1, col+1];
        end
        if col-1 >= 1 && board(row, col-1) == '-'  % left
            positions = [positions; row, col-1];
        end
        if col+1 <= 3 && board(row, col+1) == '-'  % right
            positions = [positions; row, col+1];
        end
        if row+1 <= 3 && col-1 >= 1 && board(row+1, col-1) == '-'  % bottom left
            positions = [positions; row+1, col-1];
        end
        if row+1 <= 3 && board(row+1, col) == '-'  % bottom middle
            positions = [positions; row+1, col];
        end
        if row+1 <= 3 && col+1 <= 3 && board(row+1, col+1) == '-'  % bottom right
            positions = [positions; row+1, col+1];
        end
    end
end

function position = bestMove(blockPositions, winPositions, board)
    positions = [blockPositions; winPositions];  % Combine all possible moves
    availablePositions = [];

    % Filter out already taken positions
    for i = 1:size(positions, 1)
        if board(positions(i, 1), positions(i, 2)) == '-'  % Check if position is free
            availablePositions = [availablePositions; positions(i, :)];
        end
    end

    if ~isempty(availablePositions)
        randomSelect = randi([1, size(availablePositions, 1)]);  % Randomly pick from available moves
        position = availablePositions(randomSelect, :);
    else
        position = [];  % No available positions, handle this case
        disp("No available positions.");
    end
end

function winner = checkWin(board, player)
    winner = false;
    
    % Check for row win
    for r = 1:3
        if all(board(r, :) == player)  % Check if all elements in the row are the same player
            winner = true;
            return;
        end
    end
    
    % Check for column win
    for c = 1:3
        if all(board(:, c) == player)  % Check if all elements in the column are the same player
            winner = true;
            return;
        end
    end
    
    % Check for diagonal win (top-left to bottom-right)
    if all(diag(board) == player)
        winner = true;
        return;
    end
    
    % Check for diagonal win (top-right to bottom-left)
    if all(diag(flip(board, 2)) == player)
        winner = true;
        return;
    end
end

function board = playGo(player, playerPositions, oppPositions, board)
    
    blockPositions = checkNeighbour(oppPositions, board); % Find positions that will block opponent
    winPositions = checkNeighbour(playerPositions, board); % Find positions that will make the player win
    
    bestPosition = bestMove(blockPositions, winPositions, board); % Determine best move
    disp("Best move:");
    disp(bestPosition)
    
    % Check if the position is available before placing the second player
    if board(bestPosition(1), bestPosition(2)) == '-'
        board(bestPosition(1), bestPosition(2)) = player;
        disp(board);
    else
        disp("Position already taken, retrying...");
    end
end