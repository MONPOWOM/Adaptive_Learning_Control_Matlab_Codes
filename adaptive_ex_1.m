

%%Given data%%

% Sampling times %
Ts = 2.0;   
Ts_new = 1.0;

% terms in denominator of continuous TF %

den_term_1 = [5 1];
den_term_2 = [10 1];

% convoluting the above terms to create a polynomial %

den_s = conv(den_term_1 , den_term_2);
den_s_polynomial_form = poly2sym(den_s , 's')

num_s = 1;

% num and den of Z transfer function %

num_z = [0 0.0329 0.0269];
den_z = [1 -1.4891 0.5489];


% creating impulse and unit step functions %

imp_input = [1 zeros(1,4)];
step_input = [1 ones(1,4)];



%%

% Finding the continous 's' transfer function. Plotting the zero pole map %

tf_s = tf(num_s, den_s)

% Alternate form of TF(s) %

zpk(tf_s)

% pole zero map %

figure(1);
grid on
pzmap(tf_s);


%%

% finding the discrete 'z' transfer function. Plotting pole zero map of TF(z) % 

tf_z = filt(num_z, den_z, Ts)

figure(2);
grid on
pzmap(tf_z);


%%

% Finding the output response of 'z' transfer function for unit impulse and step inputs % 

output_impulse = filter(num_z, den_z, imp_input)

output_step = filter(num_z, den_z, step_input)


%%

% converting the continuous 's' transfer function to 'z' discrete tranfer function, when sampling time is 1 including ZOH %

tf_s2z = c2d(tf_s, Ts_new, 'ZOH')

% plotting zeros and poles of the new Z transfer function %
figure(3)
pzmap(tf_s2z)

% Alternate form of TF(z) %
zpk(tf_s2z)

%%

% comparison of old and new discrete transfer functions %
tf_old = c2d(tf_s, Ts, 'ZOH')

tf_new = tf_s2z

figure(4)
subplot(2,2,1);
step(tf_old);
subplot(2,2,2);
step(tf_new);
subplot(2,2,3);
pzmap(tf_old);
subplot(2,2,4)
pzmap(tf_new)














