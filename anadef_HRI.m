% betaseries analysis definition for BASCO
basco_path = fileparts(which('BASCO'));
AnaDef.Img                  = 'nii';
AnaDef.Img4D                = false;      % true: 4D Nifti
AnaDef.NumCond              = 3;          % number of conditions
AnaDef.Cond                 = { 'HUMAN' , 'ROBOT' , 'PC' }; % names of conditions
AnaDef.units                = 'secs';    % unit 'scans' or 'secs'
AnaDef.RT                   = 2;          % repetition time in seconds
AnaDef.fmri_t               = 16;
AnaDef.fmri_t0              = 8;
AnaDef.OutDir               = 'betaseries';  % output directory
AnaDef.Prefix               = 'swauf';
AnaDef.OnsetModifier        = 0; % subtract this number from the onset-matrix (unit: scans)  <===== 4 files deleted and starting at 0 !!!

AnaDef.VoxelAnalysis        = true;  
AnaDef.ROIAnalysis          = true; % ROI level analysis (estimate model on ROIs for network analysis)
AnaDef.ROIDir               = fullfile('E:/newdatafromdorris/doris2anuja/','ROIs','marsbar'); % select all ROIs in this directory
AnaDef.ROIPrefix            = 'MNI_';
AnaDef.ROINames             = fullfile('E:/newdatafromdorris/doris2anuja/','ROIs','marsbar','roinames.txt'); % txt.-file containing ROI names
AnaDef.ROISummaryFunction   = 'mean'; % 'mean' or 'median'

AnaDef.HRFDERIVS            = [0 0];  % temporal and disperion derivatives: [0 0] or [1 0] or [1 1]

% regressors to include into design
AnaDef.MotionReg            = true;
AnaDef.GlobalMeanReg        = false;

% name of output-file (analysis objects)
AnaDef.Outfile              = fullfile('E:/newdatafromdorris/doris2anuja/','betaseries','estimated_all_subjects.mat');

cSubj = 0; % subject counter

%vp = {'sub-038', 'sub-039'}; 
%vp = {'sub-040'} %Anuja thinks this is a bad subj - yes it is!
vp = {'sub-001', 'sub-003', 'sub-004', 'sub-006', 'sub-007', 'sub-008', 'sub-009', 'sub-010', 'sub-013', 'sub-014', 'sub-015', 'sub-016', 'sub-017', 'sub-019', 'sub-020', 'sub-023', 'sub-024', 'sub-025', 'sub-026', 'sub-027', 'sub-028', 'sub-029', 'sub-030', 'sub-031', 'sub-032', 'sub-033', 'sub-034', 'sub-035', 'sub-036', 'sub-037', 'sub-038', 'sub-039', 'sub-041', 'sub-042', 'sub-043', 'sub-044', 'sub-045', 'sub-046', 'sub-047', 'sub-048', 'sub-049', 'sub-050', 'sub-051', 'sub-052', 'sub-053', 'sub-054', 'sub-055', 'sub-056', 'sub-057'};

data_dir = fullfile('E:/newdatafromdorris/doris2anuja/','derivatives', 'preprocessed'); % directory containing all subject folders

% all subjects
for i=1:length(vp)
    cSubj = cSubj+1;
    AnaDef.Subj{cSubj}.DataPath = fullfile(data_dir,vp{i},'func'); 
    AnaDef.Subj{cSubj}.NumRuns  = 6;
    AnaDef.Subj{cSubj}.RunDirs  = {'run01','run02','run03','run04','run05','run06'};
    AnaDef.Subj{cSubj}.Onsets   = {'onset_times_1.txt','onset_times_2.txt','onset_times_3.txt','onset_times_4.txt','onset_times_5.txt','onset_times_6.txt'};
    AnaDef.Subj{cSubj}.Duration = [6 6 6];
    AnaDef.Subj{cSubj}.DurationsFromFile = false; % Set to true if you want to use durations read in from a text-file 
    AnaDef.Subj{cSubj}.DurationFiles = {'durations1.txt','durations2.txt','durations3.txt','durations4.txt','durations5.txt','durations6.txt'}; % specify the durations for each trial individually (should match the number of onsets)

end

%
AnaDef.NumSubjects = cSubj;
