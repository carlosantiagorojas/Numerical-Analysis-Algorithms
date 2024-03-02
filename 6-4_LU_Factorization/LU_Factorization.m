% Source code:
% Yasin Shiboul (2024). 
% LU Factorization by Doolittle's method 
% (https://www.mathworks.com/matlabcentral/fileexchange/7779-lu-factorization-by-doolittle-s-method), 
% MATLAB Central File Exchange. Retrieved March 2, 2024.

function LU_Factorization(A)
% Input:
%   - A: Square matrix of size m x m to be decomposed
% Outputs:
%   - L: Lower triangular matrix
%   - U: Upper triangular matrix

% Initialization and obtaining the size of matrix A
[m,~] = size(A);

% Initialize upper triangular matrix U with zeros
U = zeros(m);
% Initialize lower triangular matrix L with zeros
L = zeros(m);

% Initialization of the diagonal of L with ones
for j = 1:m
    L(j,j) = 1;
end

% Copy the first row of A to the first row of U
for j = 1:m
    U(1,j) = A(1,j);
end

% Step 3: Calculation of elements of L and U
for i = 2:m
    % Calculate elements of row i of L and U
    for j = 1:m
        for k = 1:i-1
            % Calculation of sum to compute elements of L
            sum_L = 0;
            if k ~= 1
                for p = 1:k-1
                    sum_L = sum_L + L(i,p) * U(p,k);
                end
            end
            % Calculation of element of L using LU factorization formula
            L(i,k) = (A(i,k) - sum_L) / U(k,k);
        end

         % Calculation of elements of row i of U
        for k = i:m
             % Calculation of sum to compute elements of U
             sum_U = 0;
           for p = 1:i-1
               sum_U = sum_U + L(i,p) * U(p,k);
           end
           % Calculation of element of U using LU factorization formula
           U(i,k) = A(i,k) - sum_U;
        end
    end
end

% Print the matrices
fprintf('\n---Procedure completed---\n');
fprintf('\nResult of matrix L:\n');
disp(L);
fprintf('\nResult of matrix U:\n');
disp(U);
end