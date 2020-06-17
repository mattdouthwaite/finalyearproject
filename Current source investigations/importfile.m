function results = importfile(filename, dataLines)
%IMPORTFILE Import data from a text file
%  RESULTS = IMPORTFILE(FILENAME) reads data from text file FILENAME for
%  the default selection.  Returns the numeric data.
%
%  RESULTS = IMPORTFILE(FILE, DATALINES) reads data for the specified
%  row interval(s) of text file FILENAME. Specify DATALINES as a
%  positive scalar integer or a N-by-2 array of positive scalar integers
%  for dis-contiguous row intervals.
%
%  Example:
%  results = importfile("H:\FYP\NN Models\Test 1\results.csv", [2, Inf]);
%
%  See also READTABLE.
%
% Auto-generated by MATLAB on 25-Nov-2019 17:10:05

%% Input handling

% If dataLines is not specified, define defaults
if nargin < 2
    dataLines = [2, Inf];
end

%% Setup the Import Options
opts = delimitedTextImportOptions("NumVariables", 7);

% Specify range and delimiter
opts.DataLines = dataLines;
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["Point", "Var2", "Var3", "Nominal", "Var5", "Var6", "Var7"];
opts.SelectedVariableNames = ["Point", "Nominal"];
opts.VariableTypes = ["double", "string", "string", "double", "string", "string", "string"];
opts = setvaropts(opts, [2, 3, 5, 6, 7], "WhitespaceRule", "preserve");
opts = setvaropts(opts, [2, 3, 5, 6, 7], "EmptyFieldRule", "auto");
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Setup rules for import
opts.ImportErrorRule = "omitrow";
opts.MissingRule = "omitrow";

% Import the data
results = readtable(filename, opts);

%% Convert to output type
results = table2array(results);
end