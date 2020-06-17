%need an X and a w
clear;
load('linear_model_fixedpoint_4bit_3radix.mat')
load('jockeys_and_basketball_fixedpoint_4bit_3radix_normalised.mat')
offset = 0;   % This is the virtual gnd of the mirror.

y_model = X*w' + b; % ground truth, actual matrix multiplication
y_model = y_model';       %transpose



y_true_false_model = y_model >= 0; %if >=0, set as 1. else set as 0.
res_model = y_true_false_model == y_actual; %test. will compare
accuracy_model = sum(res_model)/200;
hold on;

y_analog_0_1_uA = importfile("H:\FYP\NN Models\Test 1\results_test1_IREF_0_1u_C_1pF.csv", [2, Inf]); %import the data from a file called results. Autogenerated
y_analog_0_1_uA = y_analog_0_1_uA(:,2)';    %get rid of first column
y_analog_0_1_uA = y_analog_0_1_uA - offset;
scatter(y_model, y_analog_0_1_uA, 'b');

y_analog_0_2_uA = importfile("H:\FYP\NN Models\Test 1\results_test1_IREF_0_2u_C_1.6pF.csv", [2, Inf]); %import the data from a file called results. Autogenerated
y_analog_0_2_uA = y_analog_0_2_uA(:,2)';    %get rid of first column
y_analog_0_2_uA = y_analog_0_2_uA - offset;
scatter(y_model, y_analog_0_2_uA, 'g');

y_analog_0_3_uA = importfile("H:\FYP\NN Models\Test 1\results_test1_IREF_0_3u_C_2.4pF.csv", [2, Inf]); %import the data from a file called results. Autogenerated
y_analog_0_3_uA = y_analog_0_3_uA(:,2)';    %get rid of first column
y_analog_0_3_uA = y_analog_0_3_uA - offset;
scatter(y_model, y_analog_0_3_uA, 'k');

y_analog_0_5_uA = importfile("H:\FYP\NN Models\Test 1\results_test1_IREF_0_5u_C_5pF.csv", [2, Inf]); %import the data from a file called results. Autogenerated
y_analog_0_5_uA = y_analog_0_5_uA(:,2)';    %get rid of first column
y_analog_0_5_uA = y_analog_0_5_uA - offset;
scatter(y_model, y_analog_0_5_uA, 'r');

y_analog_0_5_uA_8pF = importfile("H:\FYP\NN Models\Test 1\results_test1_IREF_0_5u_C_8pF.csv", [2, Inf]); %import the data from a file called results. Autogenerated
y_analog_0_5_uA_8pF = y_analog_0_5_uA_8pF(:,2)';    %get rid of first column
y_analog_0_5_uA_8pF = y_analog_0_5_uA_8pF - offset;
scatter(y_model, y_analog_0_5_uA_8pF, 'p');

y_analog_0_3_uA_8pF = importfile("H:\FYP\NN Models\Test 1\results_test1_IREF_0_3u_C_8pF.csv", [2, Inf]); %import the data from a file called results. Autogenerated
y_analog_0_3_uA_8pF = y_analog_0_3_uA_8pF(:,2)';    %get rid of first column
y_analog_0_3_uA_8pF = y_analog_0_3_uA_8pF - offset;
scatter(y_model, y_analog_0_3_uA_8pF, 'y');



%analog_true_false = y_analog >= 0; %if >=threshold, 1 else 0.
%res = y_actual == analog_true_false; %test. will compare

%accuracy_analog = sum(res)/200

xlabel("y = X*w + b");
ylabel("Change from 0.9 V / V");
legend('0.1uA, 1pF', '0.2uA, 1.6pF','0.3uA, 2.4pF','0.5uA, 5pF','0.5uA, 8pF', '0.3uA, 8pF');
