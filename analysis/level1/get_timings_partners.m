%% HELPER: extract timings from my_experiment structure

%  author: Doris Pischedda
%   start: 2021/06/20

% For decoding the partners.
% Names of conditions
%        'Human' : cue onsets for human trials
%        'Robot' : cue onsets for robot trials
%           'PC' : cue onsets for computer trials
 
function out = get_timings_partners(sbj)   

run_num = 6; 

 % loop over runs
 for iRun = 1:run_num  
     clear session
     clear my_experiment
     
     % trial types for partner representation
     % Initialize vectors
     human = []; 
     robot = []; 
     pc = [];
     trialnr_human = []; 
     trialnr_robot = [];
     trialnr_pc = [];
     
     fname = dir(sprintf('sub-%02i.mat', sbj)); % folder with scannelogs 
     load(fname.name) 

     % Get total number of trials
     nrTrials = length(my_experiment.run(iRun).trial);  
 
     for iTrial = 1:nrTrials                
                  
         % for human trials         
         if my_experiment.run(iRun).trial(iTrial).condition == 1 % partner is human
                    
         % get time in seconds with scanner start time subtracted         
         time =  my_experiment.run(iRun).trial(iTrial).cuestart - my_experiment.run(iRun).start_scan.t;         
         human = [human time]; % add time to onset vector        
         trialnr_human = [trialnr_human iTrial]; % add trial number to trial vector (not relevant for our models)
                           
         
         % for robot trials                
         elseif my_experiment.run(iRun).trial(iTrial).condition == 2 % partner is robot
         
         % get time             
             time =  my_experiment.run(iRun).trial(iTrial).cuestart - my_experiment.run(iRun).start_scan.t;             
             robot = [robot time];             
             trialnr_robot = [trialnr_robot iTrial];   
             
                  
         % for pc trials                
         elseif my_experiment.run(iRun).trial(iTrial).condition == 3 % partner is computer
         
         % get time             
             time =  my_experiment.run(iRun).trial(iTrial).cuestart - my_experiment.run(iRun).start_scan.t;             
             pc = [pc time];             
             trialnr_pc = [trialnr_pc iTrial];             
         end
         
         % Saves onset time vectors for each condition
         out{iRun}{1}.name  = 'Human';    
         out{iRun}{1}.times = human';    
         out{iRun}{1}.trialnr = trialnr_human;
    
         out{iRun}{2}.name  = 'Robot';
         out{iRun}{2}.times = robot';
         out{iRun}{2}.trialnr = trialnr_robot;
         
         out{iRun}{3}.name  = 'PC';
         out{iRun}{3}.times = pc';
         out{iRun}{3}.trialnr = trialnr_pc;

        % CHECK: Are the onsets a column vector?

        for j = 1:size(out{iRun},2)    
            if size(out{iRun}{j}.times,2)>1        
                error('The onsets are not a column vector!')            
            end        
        end   
    
     end
     save(sprintf('onset_times_sub-%02i.mat', sbj), 'human', '-append')
     save(sprintf('onset_times_sub-%02i.mat', sbj), 'robot', '-append')  
     save(sprintf('onset_times_sub-%02i.mat', sbj), 'pc', '-append')   
     
 end
 
end
