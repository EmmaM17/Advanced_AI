cities = ["London", "Paris", "NYC", "Tokyo", "Manchester", "Birmingham", "Portsmouth", "Bath", "Berlin", "Milan", "Los Angeles", "Chicago", "Houston", "Phoenix", "Philadelphia"; 
          12, 4, 34, 123, 456, 969, 575, 14, 659, 500, 400, 349, 934, 100, 509; 
          129, 34, 65, 35, 234, 234, 24, 43, 34, 24, 245, 646, 234, 594, 677];

% Getting starting point
index = randi([1, size(cities, 2)]);  % Correct the index range, use size(cities, 2) for column size
startingCity = cities(1, index);  % City name
x1 = double(cities(2, index));       
y1 = double(cities(3, index));        

disp(['Starting city: ', char(startingCity), ' with x-value: ', num2str(x1), ' and y-value: ', num2str(y1)]);

cities(:, index) = []; % Remove the starting city

% Go through every city
while ~isempty(cities)

    % Get distances for every city from the current city
    distances = []; % Initialize an empty array to store distances
    cityNames = {}; % To store the city names separately

    for i = 1:size(cities, 2)

        newCity = cities(1, i);  % Name of the new city
        x2 = double(cities(2, i));  % x-coordinate of the new city
        y2 = double(cities(3, i));  % y-coordinate of the new city

        % Calculate Euclidean distance between the current city and the new city
        distance = sqrt((x2 - x1)^2 + (y2 - y1)^2);
        
        % Store the city name and the calculated distance
        cityNames{end+1} = newCity;  % Store city name
        distances(end+1) = distance;  % Store the numeric distance
    end

    % Find the city with the smallest distance
    [~, idx] = min(distances);  % Find the index of the minimum distance

    % Print the trip from current city to the next city
    disp([char(startingCity), ' to ', char(cityNames{idx})]);

    % Update the current city to the next city
    x1 = double(cities(2, idx));  
    y1 = double(cities(3, idx));

    % Remove the selected city
    cities(:, idx) = [];
end


