%%
% Wrapper around Matlab's 'mex' command that is a little more intuitive
% and closer to the way how I usually write code in Matlab.
%
% @author B. Schauerte
% @date   2012,2013

% smex - Simple mex build script
% Copyright (C) 2012  Boris Schauerte
%
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.

%% define compiler options
% 1. define what you want to compile
cpp_pathes      = {'region_saliency_mex.cpp','region_saliency.cpp','ext/segment-image.cpp'};
% 2. optional arguments
include_pathes  = {'/usr/local/include/opencv/','/usr/local/include/'};
lib_pathes      = {'/usr/local/lib/'};
lib_names       = {'opencv_core','opencv_imgproc'};
ext_defines     = {'__MEX'};
other_options   = {'-O'};
% 3. further settings
arch            = computer('arch'); % target architecture
outdir          = '';
outname         = '';

%% create an options cell array as input for mex ...
mex_options=cell(1,numel(include_pathes)+numel(lib_pathes)+numel(lib_names)+numel(cpp_pathes)+numel(ext_defines));
c=1;

% external defines
for i=1:numel(ext_defines)
  mex_options{c} = sprintf('-D%s',ext_defines{i});
  c = c+1;
end

% .c/.cpp files
for i=1:numel(cpp_pathes)
  mex_options{c} = sprintf('%s',cpp_pathes{i});
  c = c+1;
end

% -I
for i=1:numel(include_pathes)
  mex_options{c} = sprintf('-I%s',include_pathes{i});
  c = c+1;
end

% -L
for i=1:numel(lib_pathes)
  mex_options{c} = sprintf('-L%s',lib_pathes{i});
  c = c+1;
end

% -l
for i=1:numel(lib_names)
  mex_options{c} = sprintf('-l%s',lib_names{i});
  c = c+1;
end

% some further settings
further_options = {};
if ~isempty(arch)
  further_options = [further_options {sprintf('-%s',arch)}];
end
if ~isempty(outdir)
  further_options = [further_options {'-outdir'} {sprintf('%s',outdir)}];
end
if ~isempty(outname)
  further_options = [further_options {'-output'} {sprintf('%s',outname)}];
end

mex_options = [other_options further_options mex_options];

%% ... and compile
mex(mex_options{:});
