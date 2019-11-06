% main experiment version 1.0

% initialize settings
settings

% initialize data structure
fprintf('starting experiment.\n')
data.vp = input('please enter vp number: ')
data.response = nan(settings.repetitions, 1)

% load stimulus
original_stimulus = imread(settings.stimulus)

% main loop
for current_run = 1:settings.repetitions

	fprintf('running trial number %i.\n', current_run)
	
	% generate comparison stimulus
	comparison_stimulus = set_brightness(original_stimulus, settings.brightness(current_run))
	
	% show experiment screen
	if strcmp(settings.display, 'opengl')
		openglshow(original_stimulus, comparison_stimulus)
	else	
		display_direct(original_stimulus, comparison_stimulus)
	end
	data.response(current_run) = get_response('which stimulus is brighter (1/2) ?')
	
	% wait for ITI
	pause(settings.speed)

end

% save the resulting data
data.filename = sprintf('results_vp%03i.mat', data.vp)
save(data.filename, data, settings)

fprintf('experiment ended.\n')
