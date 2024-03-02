% Clear screen and delete variables
clc;
clear;
clear all;

% Allow the use of symbols
syms x;

% Define the base function
fx = (10 * cos(2 * x)) / x;

% Enter initial values of the interval
fprintf('---Initial value of the interval---\n');
a = input('Enter the value of a: ');
b = input('Enter the value of b: ');

% Plot the function in the interval
fplot((fx/x),[a,b],'LineWidth',5)
grid on

% 1. Evaluate the function values at a and b
fa = subs(fx, a);
fb = subs(fx, b);

% 2. Check if any of the endpoints is already a root
if fa == 0 || fb == 0
    if fa == 0
        fprintf('The value of x at %8.5f is already a root\n', a);
    else 
        fprintf('The value of x at %8.5f is already a root\n', b);
    end
else
    % 3. Check if f(a) * f(b) < 0 ensuring one is positive
    % and the other negative to apply the method 

    if fa * fb > 0
        fprintf('The interval is invalid');
    else
        % (try with 1e-6)
        max_error = input('Enter the value of the maximum allowed error: ');

        % Evaluate initial error
        error = abs(b - a) / 2;
        
        i = 1;
        % Iterate until the error is less than the maximum error
        fprintf('\n---Applying bisection method---\n');
        while error > max_error
            % 4. Evaluate the midpoint
            midpoint = (a + b) / 2;
            fprintf('Iteration No. %d, interval [%f,%f]',i, a ,b);
            fprintf(' the most approximate root is:%8.5f\n', midpoint);
            % 5. If f(a) * f(midpoint) > 0 then a = midpoint
            if fa * subs(fx, midpoint) > 0
                a = midpoint;
            else
                b = midpoint;
            end
            % 6. Evaluate the error
            error = abs(b - a) / 2;
            i  = i + 1;
        end
        fprintf('\n---Procedure completed---\nThe approximate solution is %8.5f\n',midpoint);
    end 
end