%% add the files in the foo subfolder to path
mfp = mfilename('fullpath');
[fp,fn,fe] = fileparts(mfp);
addpath(genpath(fullfile(fp,'foo')));

%% call build_bar from here (this will showcase the 'auto_set_pwd' switch)
build_bar

%% the .mex file should now lie in foo/
ls foo