function settings = module(p,state)
%windowManager.module state dependent steps for windowManager object
%
%  Return configuration settings for module:
%  settings = windowManager.module
%
%  This is a PLDAPS module for the openreception branch.  This initializes
%  and updates windowManager object.
%
%  NB:  Generally speaking, we want to update the window manager after
%  digitized data is captured from Datapixx (order -Inf, when default trial
%  function should be called), after corresponding position sources are
%  updated, but before the custom trial function events (order NaN).
%
%  Lee Lovejoy
%  October 2017
%  ll2833@columbia.edu

if(nargin==0)

    %  Generate the settings structure for the module
    stateFunction.order = 20;
    stateFunction.acceptsLocationInput = false;
    stateFunction.name = 'windowManager.module';
    moduleName = 'moduleWindowManager';
    requestedStates = {'experimentPostOpenScreen' 'frameUpdate' 'frameDraw'};    
    settings.(moduleName).stateFunction = stateFunction;
    settings.(moduleName).use = true;
    settings.(moduleName).requestedStates = requestedStates;
else
    
    %  Execute the state dependent components    
    switch state
        case p.trial.pldaps.trialStates.experimentPreOpenScreen

            %  Initialize the window manager object            
            fprintf('****************************************************************\n');
            p.functionHandles.windowManagerObj = windowManager;
            fprintf('Initialized window manager\n');
            fprintf('****************************************************************\n');            
        
        case p.trial.pldaps.trialStates.frameUpdate
        
            %  Update the window manager object
            p.functionHandles.windowManagerObj.update;
            
        case p.trial.pldaps.trialStates.frameDraw
            
            %  Draw the windows
            p.functionHandles.windowManagerObj.draw;
    end
end
end
