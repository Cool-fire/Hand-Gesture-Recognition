% Program to do text to speech.
% Get user's sentence
function re = speech(y)
userPrompt = 'What do you want the computer to say?';
titleBar = 'Text to Speech';
defaultString = 'Hello World!  MATLAB is an awesome program!';
caUserInput = inputdlg(userPrompt, titleBar, 1, {y});
if isempty(caUserInput)
	return;
end; % Bail out if they clicked Cancel.
caUserInput = char(caUserInput); % Convert from cell to string.

NET.addAssembly('System.Speech');
obj = System.Speech.Synthesis.SpeechSynthesizer;
obj.Volume = 100;
Speak(obj, caUserInput);
end