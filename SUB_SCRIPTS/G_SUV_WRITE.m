function H_SUV_WRITE()

%declaring useful variables
global baseDir
global subj_code
global SPM8_Bqperml_SUV
global dir_pat

%dir_pat=pwd;
cd(fullfile (dir_pat,'SPM'));
renamedCOUNTfile=strcat(dir_pat,'/','SPM','/','counts_',subj_code,'.nii');

% List of open inputs
% Image Calculator: Input Images - cfg_files
% Image Calculator: Expression - cfg_entry
nrun = 1; % enter the number of runs here
jobfile=cellstr(fullfile(baseDir,'JOB_FILES/SUV_IMCALC_job.m'));
jobs = repmat(jobfile, 1, nrun);
inputs = cell(2, nrun);
for crun = 1:nrun
    inputs{1, crun} = cellstr(renamedCOUNTfile); % Image Calculator: Input Images - cfg_files
    inputs{2, crun} = sprintf('(i1*%f)',SPM8_Bqperml_SUV); % Image Calculator: Expression - cfg_entry
    end
spm('defaults', 'PET');
spm_jobman('run', jobs, inputs{:});


  SUVfile = fullfile(dir_pat,'SPM','SUV.nii');
  renamedSUVfile=strcat(dir_pat,'/','SPM','/','SUV_',subj_code,'.nii');
  copyfile(SUVfile, renamedSUVfile);
  delete(SUVfile);
  cd(dir_pat)
  mkdir SUV;
  movefile (renamedSUVfile, 'SUV'); 
  cd SUV;