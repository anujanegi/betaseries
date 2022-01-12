%% HELPER: extract timings from my_experiment structure (for sbj 1 only)

%  author: Doris Pischedda
%   start: 2021/09/21

% For decoding the partners (all trials).
% Names of conditions
%        'Human' : cue onsets for human trials
%        'Robot' : cue onsets for robot trials
%           'PC' : cue onsets for computer trials
 
function out = get_timings_partners02(sbj)   

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
     startTime = 12;
     for iTrial = 1:nrTrials                   
         if iTrial == 1
             time(iTrial) = startTime;
         else
             if my_experiment.run(iRun).trial(iTrial-1).duration == 5
                time(iTrial) = time(iTrial-1) + 16.5 + my_experiment.run(iRun).trial(iTrial-1).ITI;
             elseif my_experiment.run(iRun).trial(iTrial-1).duration == 2
                time(iTrial) = time(iTrial-1) + 10.5 + my_experiment.run(iRun).trial(iTrial-1).ITI;
             end
         end
     end

     for iTrial = 1:nrTrials                  
         % for human trials         
         if my_experiment.run(iRun).trial(iTrial).condition == 1 % partner is human
                    
          onset = time(iTrial);
          human = [human onset]; % add time to onset vector        
          trialnr_human = [trialnr_human iTrial]; % add trial number to trial vector (not relevant for our models)
                           
         
         % for robot trials                
          elseif my_experiment.run(iRun).trial(iTrial).condition == 2 % partner is robot         
             onset = time(iTrial);
             robot = [robot onset];             
             trialnr_robot = [trialnr_robot iTrial];                
                  
         % for pc trials                
          elseif my_experiment.run(iRun).trial(iTrial).condition == 3 % partner is computer
         
         % get time             
             %time =  my_experiment.run(iRun).trial(iTrial).cuestart - my_experiment.run(iRun).start_scan.t;             
             onset = time(iTrial);
             pc = [pc onset];             
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
