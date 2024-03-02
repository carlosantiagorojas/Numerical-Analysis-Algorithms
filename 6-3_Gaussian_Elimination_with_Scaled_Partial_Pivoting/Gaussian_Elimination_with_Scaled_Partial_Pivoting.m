function Gaussian_Elimination_with_Scaled_Partial_Pivoting(A, B)
% Inputs:
% Augmented coefficient matrix A = [mxn]
% Constants vector B = [mx1]

% Get dimensions of matrix A
[m, n] = size(A);

% Initialize solution vector with zeros
solution = zeros(m, 1);

% Matrix M to store multipliers during Gaussian elimination
M = zeros(m, m-1);

% Vector D to store row scales
D = ones(m, 1);

% === Forward elimination ===
for k = 1:m-1
    % Find pivot with maximum absolute value in current column
    max_value = abs(A(k, k));
    max_row = k;
    for i = k+1:m
        if abs(A(i, k)) > max_value
            max_value = abs(A(i, k));
            max_row = i;
        end
    end
    
    % Swap rows if necessary
    if max_row ~= k
        A([k, max_row], :) = A([max_row, k], :);
        B([k, max_row]) = B([max_row, k]);
        D([k, max_row]) = D([max_row, k]);
    end
    
    % Row scaling for improved accuracy
    if D(k) ~= 0
        A(k, :) = A(k, :) / D(k);
        B(k) = B(k) / D(k);
    end
    
    % Store scale of current row
    D(k) = A(k, k);
    
    % Calculate and store elimination multipliers
    for i = k+1:m
        M(i, k) = A(i, k) / A(k, k);
        
        % Update row i of A and corresponding element of B
        for j = k+1:n
            A(i, j) = A(i, j) - M(i, k) * A(k, j);
        end
        B(i) = B(i) - M(i, k) * B(k);
    end
end

% === Backward elimination ===
% With the last equation, solve for the corresponding variable
solution(m) = B(m) / A(m, m);
for i = m-1:-1:1
    % Summation of products of coefficients and already found variables
    sum = 0;
    for j = i+1:m
        sum = sum + A(i, j) * solution(j);
    end
    
    % Calculate value of the corresponding variable
    solution(i) = (B(i) - sum) / A(i, i);
end

% Print the solution vector
fprintf('\n---Procedure completed---\n\nThe solution vector is:\n');
fprintf('%f\n', solution);
end