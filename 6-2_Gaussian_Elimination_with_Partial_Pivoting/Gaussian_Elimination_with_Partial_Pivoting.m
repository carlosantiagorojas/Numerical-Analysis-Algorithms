% Source code:
% hArshad Afzal (2024).
% Gaussian Elimination Method with Partial Pivoting 
% (https://www.mathworks.com/matlabcentral/fileexchange/72714-gaussian-elimination-method-with-partial-pivoting), 
% MATLAB Central File Exchange. Retrieved March 2, 2024.

function Gaussian_Elimination_with_Partial_Pivoting(A, B)
% Inputs:
% Augmented coefficient matrix A = [mxn]
% Constants vector B = [mx1]

% Get dimensions of matrix A
[m, n] = size(A);

% Initialize solution vector with zeros
solution = zeros(m, 1);

% Matrix M to store multipliers during Gaussian elimination
M = zeros(m, m-1);

% === Forward elimination ===

for k = 1:m-1
    % Performing partial pivoting (row reordering to avoid division by zero)
    for p = k+1:m
        % Checking if absolute value of current element is greater than pivot
        if abs(A(p, k)) > abs(A(k, k))
            % Swap rows of A and corresponding elements of B
            A([k, p], :) = A([p, k], :);
            B([k, p]) = B([p, k]);
        end
    end
    
    % Calculating and storing elimination multipliers in matrix M
    for i = k+1:m
        % Calculating multiplier for row i
        M(i, k) = A(i, k) / A(k, k);
        
        % Updating row i of A and corresponding element of B
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
    summation = 0;
    for j = i+1:m
        summation = summation + A(i, j) * solution(j);
    end
    
    % Calculate value of corresponding variable
    solution(i) = (B(i) - summation) / A(i, i);
end

fprintf('\n---Procedure completed---\n \nThe solution vector is:\n');
fprintf('%f\n', solution);
end