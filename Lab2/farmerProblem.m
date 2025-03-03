%Farmer, fox, goose, grain
finalState = [0 3 4 5];  % final state, goal
left = finalState;  % starting bank (left)
right  = [1 1 1 1];  % starting bank (right)
boat = [1 1];  % initial boat state (only the farmer is on the boat)
solved = false;
test = 0;

% initial states
disp("left bank starts like "), disp(left)
disp("boat starts like "), disp(boat)
disp("right bank starts like "), disp(right)

% cycle until complete
while test < 2
   
    % go right
    direction = right;
    disp("going to the right -->")
    [boat, left] = who(left,boat, direction);

    % drop off
    right(1) = 0; % dropped farmer off
    boat(1) = 1; % farmer off boat
    indicies= find(right == 1); % find free spots
    right(indicies(1)) = boat(2); % drop off charcter at next free spot
    boat(2)= 1;

    disp("left bank "), disp(left)
    disp("boat "), disp(boat)
    disp("right bank "), disp(right)

    % go left
    direction = left;
    disp("going to the left -->")
    [boat, right] = who(right,boat,direction);

    % drop off
    left(1) = 0; % dropped farmer off
    boat(1) = 1; % farmer off boat
    indicies= find(left == 1); % find free spots
    left(indicies(1)) = boat(2); % drop off charcter at next free spot
    boat(2)= 1;

    disp("left bank "), disp(left)
    disp("boat "), disp(boat)
    disp("right bank "), disp(right)


    test = test + 1;
    
end

% Function to select who travels
function [boat, bank] = who(bank, boat, direction)
    whoGoes = false;
    bankInit = bank;

    

    % Randomly select a passenger (not the farmer)
    while ~whoGoes
        random = randi([2, 4]);  % Choose between fox (2), goose (3), and grain (4)

        % Farmer always sits at index 1, choose random passenger
        boat(1) = 0;             % Farmer always sits on index 1 (off boat)
        bank(1) = 1;             % Farmer moves to the starting position on the bank

        bankCheck = checkBank(bank);  % Check if it's safe to leave the bank
        if bankCheck
            disp("i go left and safe to leave bank")
            return;  % (no need to pick anyone)
        end

        boat(2) = bank(random);  % The passenger at index 2 (selected character)
        bank(random) = 1;        % Remove the passenger from the bank

        % Check if this is a valid state after the move
        bankCheck = checkBank(bank);

        % If valid, move on
        if bankCheck
            whoGoes = true;  % Successful move, exit loop
        else
            % If not valid, restore the bank and reset the boat to initial state
            bank = bankInit;
            boat = [1 1];  % Reset boat to initial state (farmer only)
        end
    end
end

% Function to check the bank
function works = checkBank(bank)
    product = prod(bank);

    % Conditions to allow safe leaving (not leaving an unsafe combination behind)
    if product == 0 || mod(product, 2) == 0
        % If the product is 0 (empty bank) or an even number (which is always valid)
        if sort(bank) == sort([1 1 4 1])  % Check if the state is [1 1 4 1] or valid
            works = true;
        else
            works = false;  % Invalid configuration
        end
    else
        works = true;  % If no product conflict, it's valid
    end
end
